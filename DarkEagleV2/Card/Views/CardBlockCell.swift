//
//  CardBlockCell.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 14/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit
import SkeletonView

protocol CardBlockCellDelegate: AnyObject {
    func cardBlockCell(_ cell: CardBlockCell, wasSelectedWithTapAction action: TapAction)
}

class CardBlockCell: UICollectionViewCell, NibLoadable {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    weak var delegate: CardBlockCellDelegate?
    
    private var block: CardBlock?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.isSkeletonable = true
        subtitleLabel.isSkeletonable = true
        imageView.isSkeletonable = true
    }
    
    override func prepareForReuse() {
        block = nil
    }
    
    func configure(with block: CardBlock) {
        disableSkeleton()
        
        self.block = block
        
        titleLabel.text = block.title
        subtitleLabel.text = block.subtitle
        
        titleLabel.font = block.style?.titleStyle.font.font
        subtitleLabel.font = block.style?.subtitleStyle.font.font
        
        titleLabel.textColor = block.style?.titleStyle.colour.colour
        subtitleLabel.textColor = block.style?.subtitleStyle.colour.colour
        
        ImageDownloader().downloadImage(url: block.image.src) { (result) in
            switch result {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                break
            }
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        addGestureRecognizer(tap)
    }
    
    func configureSkeleton() {
        enableSkeleton()
        titleLabel.clipsToBounds = true
        subtitleLabel.clipsToBounds = true
    }
    
    func enableSkeleton() {
        titleLabel.showAnimatedSkeleton()
        subtitleLabel.showAnimatedSkeleton()
        imageView.showAnimatedSkeleton()
    }
    
    func disableSkeleton() {
        titleLabel.hideSkeleton()
        subtitleLabel.hideSkeleton()
        imageView.hideSkeleton()
    }
    
    @objc private func cellTapped() {
        guard let action = block?.tapAction else {
            return
        }
        
        delegate?.cardBlockCell(self, wasSelectedWithTapAction: action)
    }
}


