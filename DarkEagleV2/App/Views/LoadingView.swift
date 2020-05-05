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
    @IBOutlet var borderables: [UIView]!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    @IBOutlet var spacingConstraints: [NSLayoutConstraint]!
    
    // Loading animation properties
    private var shouldAnimate = false
    
    // Pull to refresh properties
    private var pullToRefreshLocked = false
    
    // View Properties
    private var borderColor: UIColor = .white
    private var borderWidth: CGFloat = 2.0
    
    private var animationCompletion: (() -> Void)?
    
    class func instanceFromNib() -> LoadingView {
        return UINib(nibName: "LoadingView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LoadingView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.roundables.forEach {
            $0.setNeedsLayout()
            $0.layoutIfNeeded()
            $0.layer.cornerRadius = $0.frame.width / 2.0
            $0.clipsToBounds = true
        }
        
        self.borderables.forEach {
            $0.layer.borderColor = self.borderColor.cgColor
            $0.layer.borderWidth = self.borderWidth
        }
    }
    
    func configureBorders(borderColor: UIColor, borderWidth: CGFloat) {
        self.borderColor = borderColor
        self.borderWidth = borderWidth
    }
    
    func configureSizes(size: CGSize, padding: CGFloat) {
        self.heightConstraint.constant = size.height
        self.widthConstraint.constant = size.width
        self.spacingConstraints.forEach {
            $0.constant = padding
        }
    }
}

// MARK: Loading functions
extension LoadingView {
    func startAnimating() {
        if shouldAnimate {
            return
        }
        
        shouldAnimate = true
        animate()
    }
    
    func stopAnimating(withBlock completion: (() -> Void)? = nil) {
        shouldAnimate = false
        animationCompletion = completion
    }
    
    private func animate() {
        guard shouldAnimate else {
            animationCompletion?()
            animationCompletion = nil
            return
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform.identity
            self.loader.alpha = 1.0
        }) { (finished) in
            UIView.animate(withDuration: 0.8, animations: {
                self.loader.transform = self.loader.transform.translatedBy(x: 0.0, y: -10.0)
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
