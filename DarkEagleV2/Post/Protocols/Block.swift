//
//  Block.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 11/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation

protocol Block {
    var id: String { get }
    var type: BlockType { get }
}
