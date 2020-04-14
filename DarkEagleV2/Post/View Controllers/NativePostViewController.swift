//
//  ViewController.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 07/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit
import SafariServices

class NativePostViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var selectionOptions: SelectionOptionsView?
    
    var viewModel = NativePostViewModel(postId: "1")
    let sizeProvider = DynamicCellSizeProvider()
    
    private var cellProvider: NativePostCellProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellProvider = NativePostCellProvider(textBlockCellDelegate: self)
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
        
        viewModel.fetchPost()
    }
}

extension NativePostViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {        
        dismissOptions()
    }
}

extension NativePostViewController: UICollectionViewDataSource {
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

extension NativePostViewController: UICollectionViewDelegateFlowLayout {
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
        default:
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: 16.0,
            right: 0.0
        )
    }
}

extension NativePostViewController: TextBlockCellDelegate {
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
