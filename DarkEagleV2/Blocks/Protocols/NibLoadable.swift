//
//  NibLoadable.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 11/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

protocol NibLoadable {
    static func nib(named name: String?) -> UINib
}

extension NibLoadable {
    static func nib(named name: String? = nil) -> UINib {
        guard let name = name else {
            return UINib(nibName: String(describing: self), bundle: nil)
        }
        
        return UINib(nibName: name, bundle: nil)
    }
    
    static func createTemplate(named name: String? = nil) -> Self {
        let nibName = name ?? String(describing: Self.self)
        
        guard let template = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as? Self else {
            fatalError()
        }
        
        return template
    }
}
