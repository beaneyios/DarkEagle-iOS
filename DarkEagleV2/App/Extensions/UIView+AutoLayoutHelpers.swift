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
    func pinToEdges(on view: UIView) {
        topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).activate()
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).activate()
        leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).activate()
        rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).activate()
    }
    
    func pinVertically(to view: UIView, at yPosition: CGFloat) {
        topAnchor.constraint(equalTo: view.topAnchor, constant: yPosition).activate()
    }
    
    func height(_ height: CGFloat) {
        heightAnchor.constraint(equalToConstant: height).activate()
    }
    
    func size(at size: CGSize) {
        widthAnchor.constraint(equalToConstant: size.width).activate()
        heightAnchor.constraint(equalToConstant: size.height).activate()
    }
    
    func center(in parent: UIView) {
        centerXAnchor.constraint(equalToSystemSpacingAfter: parent.centerXAnchor, multiplier: 1.0).activate()
    }
}
