//
//  ViewController.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 07/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit
import SafariServices

class BlockListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var selectionOptions: SelectionOptionsView?
    
    var viewModel: BlockListViewModel!
    let sizeProvider = DynamicCellSizeProvider()
    
    private var cellProvider: BlockListCellProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellProvider = BlockListCellProvider(textBlockCellDelegate: self)
        cellProvider.registerCells(on: collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        viewModel.didChange = { change in
            DispatchQueue.main.async {
                switch change {
                case .updated:
                    self.collectionView.reloadData()
                }
            }
        }
        
        viewModel.loadData()
    }
}

extension BlockListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {        
        dismissOptions()
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
        let leftRightPadding: CGFloat = 0.0
        
        switch block {
        case let block as ImageBlock:
            let ratio = CGFloat(block.height / block.width)
            let height = collectionView.frame.width * ratio
            return CGSize(width: collectionView.frame.width - leftRightPadding, height: height)
        case let block as TextBlock:
            return sizeProvider.size(
                indexPath: indexPath,
                nibCreatable: TextBlockCell.self,
                preferredWidth: collectionView.frame.width - leftRightPadding,
                configureAction: DynamicConfigureActionProvider.configureAction(for: block)
            )
        case let block as CardBlock:
            return sizeProvider.size(
                indexPath: indexPath,
                nibCreatable: CardBlockCell.self,
                nibName: CardNibNameProvider.nibName(for: block.cardType),
                preferredWidth: collectionView.frame.width - leftRightPadding,
                configureAction: DynamicConfigureActionProvider.configureAction(for: block)
            )
        default:
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
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
    func textBlockCellDidTapAction(_ action: TapAction) {
        switch action {
        case let .openURL(url):
            let sf = SFSafariViewController(url: url)
            present(sf, animated: true, completion: nil)
        case .none:
            break
        }
    }
    
    func textBlockCellDidDismissOptions() {
        dismissOptions()
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
