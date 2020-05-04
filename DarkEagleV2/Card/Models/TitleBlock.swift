//
//  TitleBlock.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 28/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation

struct TitleBlock: Block, Decodable {    
    var id: String
    var size: Size?
    var style: FontStyle?
    var tapAction: TapAction?
    var type: BlockType
    var title: String
}
