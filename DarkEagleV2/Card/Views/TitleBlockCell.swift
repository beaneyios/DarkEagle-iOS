//
//  TitleBlockCell.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 28/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

class TitleBlockCell: UICollectionViewCell, NibLoadable {
    @IBOutlet weak var titleLabel: UILabel!
        
    func configure(with block: TitleBlock) {
        titleLabel.text = block.title
        titleLabel.font = block.style?.font.font
        titleLabel.textColor = block.style?.colour.colour
    }
}
