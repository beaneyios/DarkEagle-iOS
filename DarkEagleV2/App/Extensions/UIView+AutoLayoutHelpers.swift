//
//  UIView+AutoLayoutHelpers.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 12/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

enum PinPosition {
    case top
    case bottom
}

extension NSLayoutConstraint {
    func activate() {
        isActive = true
    }
}

extension UIView {
    func pinVertically(to view: UIView, at yPosition: CGFloat) {
        topAnchor.constraint(equalTo: view.topAnchor, constant: yPosition).activate()
    }
    
    func size(at size: CGSize) {
        widthAnchor.constraint(equalToConstant: size.width).activate()
        heightAnchor.constraint(equalToConstant: size.height).activate()
    }
    
    func center(in parent: UIView) {
        centerXAnchor.constraint(equalToSystemSpacingAfter: parent.centerXAnchor, multiplier: 1.0).activate()
    }
}
