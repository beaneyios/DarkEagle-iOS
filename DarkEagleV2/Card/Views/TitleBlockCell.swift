//
//  TitleBlockCell.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 28/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit
import SkeletonView

class TitleBlockCell: UICollectionViewCell, NibLoadable {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.isSkeletonable = true
    }
    
    func configure(with block: TitleBlock) {
        titleLabel.text = block.title
        titleLabel.font = block.style?.font.font
        titleLabel.textColor = block.style?.colour.colour
    }
    
    func configureSkeleton() {
        enableSkeleton()
        titleLabel.clipsToBounds = true
    }
    
    func enableSkeleton() {
        titleLabel.showAnimatedSkeleton()
    }
    
    func disableSkeleton() {
        titleLabel.hideSkeleton()
    }
}
