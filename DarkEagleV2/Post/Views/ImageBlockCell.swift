//
//  ImageBlockCell.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 12/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

class ImageBlockCell: UICollectionViewCell, NibLoadable {

    @IBOutlet weak var imgView: UIImageView!
    
    func configure(with block: ImageBlock) {
        ImageDownloader().downloadImage(url: block.image.src) { (result) in
            switch result {
            case let .success(image):
                self.imgView.image = image
            case let .failure(error):
                break
            }
        }
    }
}
