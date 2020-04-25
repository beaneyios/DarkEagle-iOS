//
//  LoadingView.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 25/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

class LoadingView: UIView {
    
    @IBOutlet weak var loader: UIView!
    
    @IBOutlet var roundables: [UIView]!
    
    private var shouldAnimate = false
    
    class func instanceFromNib() -> LoadingView {
        return UINib(nibName: "LoadingView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LoadingView
    }
    
    func startAnimating() {
        shouldAnimate = true
        animate()
    }
    
    func stopAnimating() {
        shouldAnimate = false
        UIView.animate(withDuration: 0.5) {
            self.loader.alpha = 0.5
            self.transform = self.transform.rotated(by: 0.5)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.roundables.forEach {
            $0.setNeedsLayout()
            $0.layoutIfNeeded()
            $0.layer.cornerRadius = $0.frame.width / 2.0
            $0.clipsToBounds = true
        }
        
        loader.alpha = 0.5
        
        UIView.animate(withDuration: 0.5) {
            self.transform = self.transform.rotated(by: 0.5)
        }
    }
    
    private func animate() {
        guard shouldAnimate else {
            return
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform.identity
            self.loader.alpha = 1.0
        }) { (finished) in
            UIView.animate(withDuration: 0.8, animations: {
                self.loader.transform = self.loader.transform.translatedBy(x: 0.0, y: -20.0)
            }) { (finished) in
                UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 3, options: .curveEaseInOut, animations: {
                    self.loader.transform = CGAffineTransform.identity
                }) { _ in
                    self.animate()
                }
            }
        }
    }
}
