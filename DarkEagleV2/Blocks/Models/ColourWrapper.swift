//
//  ColourWrapper.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 14/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

final class ColourWrapper: Decodable {
    var colour: UIColor
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let hex = try container.decode(String.self)
        colour = UIColor(hex: hex) ?? .clear
    }
}
