//
//  Array+FirstOfType.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 11/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation

extension Array {
    func first<T>(ofType type: T.Type) -> T? {
        first { $0 is T } as? T
    }
}
