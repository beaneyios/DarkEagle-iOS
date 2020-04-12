//
//  NibLoadable.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 11/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

protocol NibLoadable {
    static var nib: UINib { get }
}

extension NibLoadable {
    static var nib: UINib {
        UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static func createTemplate() -> Self {
        guard let template = Bundle.main.loadNibNamed(String(describing: Self.self), owner: nil, options: nil)?.first as? Self else {
            fatalError()
        }
        
        return template
    }
}
