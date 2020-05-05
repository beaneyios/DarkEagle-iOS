//
//  PostSkeletonView.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 05/05/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

class PostSkeletonView: UIView, SkeletonableView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var bodyLabels: [UILabel]!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.isSkeletonable = true
        titleLabel.isSkeletonable = true
        
        bodyLabels.forEach {
            $0.isSkeletonable = true
        }
    }
    
    func stopSkeleton() {
        isHidden = true
        imageView.hideSkeleton()
        titleLabel.hideSkeleton()
        
        bodyLabels.forEach {
            $0.hideSkeleton()
        }
    }
    
    func startSkeleton() {
        isHidden = false
        imageView.showAnimatedSkeleton()
        titleLabel.showAnimatedSkeleton()
        
        bodyLabels.forEach {
            $0.showAnimatedSkeleton()
        }
    }
}

