//
//  Weak.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 18/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation

struct Weak<T: AnyObject> {
    weak var value: T?
    
    init(_ value: T) {
        self.value = value
    }
}
