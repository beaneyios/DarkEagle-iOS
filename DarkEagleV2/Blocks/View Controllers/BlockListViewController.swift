//
//  ViewController.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 07/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit
import SafariServices

protocol BlockListViewControllerDelegate: AnyObject {
    func blockListViewController(_ viewController: BlockListViewController, didSelectOpenUrl url: URL)
    func blockListViewController(_ viewController: BlockListViewController, didSelectOpenPostWithId postId: String)
    func blockListViewController(_ viewController: BlockListViewController, didBookmarkPostWithId postId: String, andResult result: BookmarkController.Result)
}

class BlockListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var skeletonViewContainer: UIView!
    
    typealias SkeletonableUIView = UIView & SkeletonableView
    private var skeletonView: SkeletonableUIView?

    var loadingView: LoadingView?
    
    weak var delegate: BlockListViewControllerDelegate?
    var viewModel: BlockListViewModel!
    let sizeProvider = DynamicCellSizeProvider()
    
    private var cellProvider: BlockListCellProvider!
    private var selectionOptions: SelectionOptionsView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureRefreshControl()
        addSkeletonView()
        
        cellProvider = BlockListCellProvider(
            textBlockCellDelegate: self,
            cardBlockCellDelegate: self
        )
        
        cellProvider.registerCells(on: collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        viewModel.didChange = { change in
            DispatchQueue.main.async {
                switch change {
                case .updated:
                    self.collectionView.reloadData()
                case .startLoading:
                    self.collectionView.isUserInteractionEnabled = false
                    self.loadingView?.startAnimating()
                    self.navigationItem.rightBarButtonItem?.isEnabled = false
                    
                    UIView.animate(withDuration: 0.3, animations: {
                        self.collectionView.alpha = 0.6
                        self.loadingView?.alpha = 0.6
                    })
                case .stopLoading:
                    self.skeletonView?.stopSkeleton()
                    self.collectionView.isUserInteractionEnabled = true
                    UIView.animate(withDuration: 0.3, animations: {
                        self.loadingView?.alpha = 1.0
                        self.collectionView.alpha = 1.0
                    }) { (finished) in
                        self.collectionView.refreshControl?.endRefreshing()
                        self.loadingView?.stopAnimating()
                        self.navigationItem.rightBarButtonItem?.isEnabled = true
                    }
                case let .bookmarked(result, id):
                    self.delegate?.blockListViewController(self, didBookmarkPostWithId: id, andResult: result)
                }
            }
        }
        
        viewModel.loadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.reloadData()
    }
    
    private func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc func refresh() {
        viewModel.reloadData()
    }
    
    func configureSkeletonView(withType type: SkeletonableView.Type) {
        guard let skeletonView = type.createTemplate() as? SkeletonableUIView else {
            return
        }
    
        self.skeletonView = skeletonView
    }
    
    private func addSkeletonView() {
        guard let skeletonView = self.skeletonView else {
            return
        }
        
        skeletonView.translatesAutoresizingMaskIntoConstraints = false
        skeletonViewContainer.addSubview(skeletonView)
        skeletonView.pinToEdges(on: skeletonViewContainer)
        skeletonView.startSkeleton()
    }
    
    private func handleTapAction(_ tapAction: TapAction) {
        switch tapAction {
        case let .openURL(url):
            delegate?.blockListViewController(self, didSelectOpenUrl: url)
        case let .openPost(postId):
            delegate?.blockListViewController(self, didSelectOpenPostWithId: postId)
        case .none:
            break
        }
    }
}

extension BlockListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let block = viewModel.block(for: indexPath)
        return cellProvider.cell(for: block, collectionView: collectionView, indexPath: indexPath)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfBlockSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfBlocks(in: section)
    }
}

extension BlockListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let block = viewModel.block(for: indexPath)
        let horizontalPadding: CGFloat = 0.0
        
        switch block {
        case let block as ImageBlock:
            let ratio = CGFloat(block.image.height / block.image.width)
            let height = collectionView.frame.width * ratio
            return CGSize(width: collectionView.frame.width - horizontalPadding, height: height)
        case let block as TextBlock:
            return sizeProvider.size(
                indexPath: indexPath,
                nibCreatable: TextBlockCell.self,
                preferredWidth: collectionView.frame.width - horizontalPadding,
                configureAction: DynamicConfigureActionProvider.configureAction(for: block)
            )
        case let block as TitleBlock:
            return sizeProvider.size(
                indexPath: indexPath,
                nibCreatable: TitleBlockCell.self,
                preferredWidth: collectionView.frame.width - horizontalPadding,
                configureAction: DynamicConfigureActionProvider.configureAction(for: block)
            )
        case let block as CardBlock:
            return size(
                forCard: block,
                indexPath: indexPath,
                collectionView: collectionView,
                horizontalPadding: horizontalPadding
            )
        case let block as SkeletonBlock:
            if let size = block.size, case let Size.fullWidthFixedHeight(height) = size {
                return CGSize(width: collectionView.frame.width, height: height)
            }
        default:
            return CGSize.zero
        }
        
        return CGSize.zero
    }
    
    private func size(forCard block: CardBlock, indexPath: IndexPath, collectionView: UICollectionView, horizontalPadding: CGFloat) -> CGSize {
        guard let size = block.size else {
            return sizeProvider.size(
                indexPath: indexPath,
                nibCreatable: CardBlockCell.self,
                nibName: CardNibNameProvider.nibName(for: block.cardType),
                preferredWidth: collectionView.frame.width - horizontalPadding,
                configureAction: DynamicConfigureActionProvider.configureAction(for: block)
            )
        }
        
        switch size {
        case .fullWidthFlexibleHeight:
            return sizeProvider.size(
                indexPath: indexPath,
                nibCreatable: CardBlockCell.self,
                nibName: CardNibNameProvider.nibName(for: block.cardType),
                preferredWidth: collectionView.frame.width - horizontalPadding,
                configureAction: DynamicConfigureActionProvider.configureAction(for: block)
            )
        case let .weightedWidthFixedHeight(weighting, height):
            let section = viewModel.blockSections[indexPath.section]
            let collectionWidth = collectionView.frame.width
            let widthWithoutPadding = collectionWidth - horizontalPadding
            let spacing = (weighting - 1.0) * (section.itemSpacing ?? 0.0)
            let widthWithoutSpacing = widthWithoutPadding - spacing
            return CGSize(width: widthWithoutSpacing / weighting, height: height)
        case let .fullWidthFixedHeight(height):
            return CGSize(width: collectionView.frame.width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let section = viewModel.blockSections[section]
        return section.itemSpacing ?? 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let section = viewModel.blockSections[section]
        return section.itemSpacing ?? 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let section = viewModel.blockSections[section]
        
        return UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: section.sectionSpacing ?? 0.0,
            right: 0.0
        )
    }
}

extension BlockListViewController: TextBlockCellDelegate {
    func textBlockCellDidDismissOptions() {
        dismissOptions()
    }
    
    func textBlockCell(_ cell: TextBlockCell, wasSelectedWithTapAction action: TapAction) {
        handleTapAction(action)
    }
    
    func textBlockCell(_ cell: TextBlockCell, didSelectatYPosition yPosition: CGFloat) {
        selectionOptions?.removeFromSuperview()
        
        let newView = SelectionOptionsView(frame: .zero)
        view.addSubview(newView)
        newView.translatesAutoresizingMaskIntoConstraints = false
        
        let newYPosition = cell.convert(CGPoint(x: 0.0, y: yPosition), to: self.view).y
        let adjustedYPosition = newYPosition < 100.0 ? 100.0 : newYPosition
        
        newView.pinVertically(to: self.view, at: adjustedYPosition)
        newView.centerHorizontally(in: self.view)
        newView.height(50.0)
        newView.widthAnchor.constraint(greaterThanOrEqualToConstant: 10.0).activate()
        
        selectionOptions = newView
    }
    
    private func dismissOptions() {
        selectionOptions?.removeFromSuperview()
        selectionOptions = nil
    }
}

extension BlockListViewController: CardBlockCellDelegate {
    func cardBlockCell(_ cell: CardBlockCell, wasSelectedWithTapAction action: TapAction) {
        handleTapAction(action)
    }
}
