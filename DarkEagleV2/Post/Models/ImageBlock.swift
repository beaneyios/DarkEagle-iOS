//
//  ImageBlock.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 11/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation

struct Image: Decodable {
    var src: URL
    var height: Double
    var width: Double
}

struct ImageBlock: Block, Decodable {
    var id: String
    var type: BlockType
    var image: Image
}
