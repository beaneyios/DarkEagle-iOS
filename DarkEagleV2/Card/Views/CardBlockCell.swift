//
//  CardBlockCell.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 14/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

class CardBlockCell: UICollectionViewCell, NibLoadable {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(with block: CardBlock) {
        titleLabel.text = block.title
        subtitleLabel.text = block.subtitle
        
        titleLabel.font = block.style?.titleFont.font
        subtitleLabel.font = block.style?.subtitleFont.font
        
        titleLabel.textColor = block.style?.titleColour.colour
        subtitleLabel.textColor = block.style?.subtitleColour.colour
        
        ImageDownloader().downloadImage(url: block.image.src) { (result) in
            switch result {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                break
            }
        }
    }
}


