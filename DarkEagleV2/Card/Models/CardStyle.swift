//
//  CardStyle.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 14/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation

struct CardStyle: Decodable {
    var titleFont: FontWrapper
    var titleColour: ColourWrapper
    
    var subtitleFont: FontWrapper
    var subtitleColour: ColourWrapper
}
