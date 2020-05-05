//
//  SkeletonBlock.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 04/05/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation

struct SkeletonBlock: Block, Decodable, Sizeable {
    enum SkeletonType: String, Decodable {
        case largeCard
        case rowCard
        case text
    }
    
    var id: String
    var type: BlockType
    var skeletonType: SkeletonType
    var size: Size?
}
