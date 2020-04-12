//
//  Article.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 11/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation

struct AnyBlock: Decodable {
    var resource: Block
    
    enum DecodingKey: CodingKey {
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKey.self)
        let type = try container.decode(BlockType.self, forKey: .type)
        
        switch type {
        case .text:
            resource = try TextBlock(from: decoder)
        case .image:
            resource = try ImageBlock(from: decoder)
        }
    }
}
