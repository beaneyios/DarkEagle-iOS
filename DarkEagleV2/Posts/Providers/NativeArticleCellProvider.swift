//
//  NativeArticleCellProvider.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 12/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

struct NativePostCellProvider {
    enum ReuseIdentifiers: String {
        case textBlock
        case imageBlock
    }
    
    func registerCells(on collectionView: UICollectionView) {
        collectionView.register(TextBlockCell.nib, forCellWithReuseIdentifier: ReuseIdentifiers.textBlock.rawValue)
        collectionView.register(ImageBlockCell.nib, forCellWithReuseIdentifier: ReuseIdentifiers.imageBlock.rawValue)
    }
    
    func cell(for block: Block, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        switch block {
        case let block as TextBlock:
            let cell: TextBlockCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ReuseIdentifiers.textBlock.rawValue,
                for: indexPath
            )
            
            cell.configure(with: block)
            return cell
        case let block as ImageBlock:
            let cell: ImageBlockCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ReuseIdentifiers.imageBlock.rawValue,
                for: indexPath
            )
            
            cell.configure(with: block)
            return cell
        default:
            fatalError("Unexpected block \(block.self)")
        }
    }
}

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(
        withReuseIdentifier identifier: String,
        for indexPath: IndexPath
    ) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("No cell found for identifier \(identifier) of type \(T.self)")
        }
        
        return cell
    }
}
