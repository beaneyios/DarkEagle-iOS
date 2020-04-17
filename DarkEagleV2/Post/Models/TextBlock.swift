//
//  TextBlock.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 11/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation

struct TextBlock: Block, Decodable {
    var id: String
    var type: BlockType
    var text: String
    var styles: [TextStyleRange]
    var tapActions: [TapActionRange]?
}
