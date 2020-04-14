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
        URLSession.shared.dataTask(with: block.src) { (data, response, error) in
            DispatchQueue.main.async {
                let image = UIImage(data: data!)
                self.imgView.image = image
            }
        }.resume()
    }
}
