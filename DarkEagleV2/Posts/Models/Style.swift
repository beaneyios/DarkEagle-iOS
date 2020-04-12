//
//  Style.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 11/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation

enum Style: String, Codable {
    case bold
    case url
}

struct StyleRange: Codable {
    var startIndex: Int
    var endIndex: Int
    var style: Style
}
