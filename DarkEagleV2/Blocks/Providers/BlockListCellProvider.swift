//
//  NativeArticleCellProvider.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 12/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

struct BlockListCellProvider {
    enum ReuseIdentifiers: String {
        case textBlock
        case imageBlock
        case rowCard
        case largeCard
    }
    
    private var textBlockCellDelegate: TextBlockCellDelegate?
    private var cardBlockCellDelegate: CardBlockCellDelegate?
    
    init(
        textBlockCellDelegate: TextBlockCellDelegate? = nil,
        cardBlockCellDelegate: CardBlockCellDelegate? = nil
    ) {
        self.textBlockCellDelegate = textBlockCellDelegate
        self.cardBlockCellDelegate = cardBlockCellDelegate
    }
    
    func registerCells(on collectionView: UICollectionView) {
        collectionView.register(TextBlockCell.nib(), forCellWithReuseIdentifier: ReuseIdentifiers.textBlock.rawValue)
        collectionView.register(ImageBlockCell.nib(), forCellWithReuseIdentifier: ReuseIdentifiers.imageBlock.rawValue)
        collectionView.register(
            CardBlockCell.nib(named: CardNibNameProvider.nibName(for: .row)),
            forCellWithReuseIdentifier: ReuseIdentifiers.rowCard.rawValue
        )
        collectionView.register(
            CardBlockCell.nib(named: CardNibNameProvider.nibName(for: .large)),
            forCellWithReuseIdentifier: ReuseIdentifiers.largeCard.rawValue
        )
    }
    
    func cell(for block: Block, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        switch block {
        case let block as TextBlock:
            let cell: TextBlockCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ReuseIdentifiers.textBlock.rawValue,
                for: indexPath
            )
            
            cell.delegate = textBlockCellDelegate
            cell.configure(with: block)
            return cell
        case let block as ImageBlock:
            let cell: ImageBlockCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ReuseIdentifiers.imageBlock.rawValue,
                for: indexPath
            )
            
            cell.configure(with: block)
            return cell
        case let block as CardBlock:
            return cardCell(for: block, collectionView: collectionView, indexPath: indexPath)
        default:
            fatalError("Unexpected block \(block.self)")
        }
    }
    
    func cardCell(for block: CardBlock, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CardBlockCell = {
            switch block.cardType {
            case .row:
                return collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifiers.rowCard.rawValue, for: indexPath)
            case .large:
                return collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifiers.largeCard.rawValue, for: indexPath)
            }
        }()
        
        cell.delegate = cardBlockCellDelegate
        cell.configure(with: block)
        return cell
    }
}
