//
//  Size.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 18/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

enum Size: Decodable {
    case fullWidthFlexibleHeight
    case weightedWidthFixedHeight(weighting: CGFloat, height: CGFloat)
    case fullWidthFixedHeight(_ height: CGFloat)
    
    enum SizeType: String, Decodable {
        case fullWidthFlexibleHeight
        case weightedWidthFixedHeight
    }
    
    enum DecodingKeys: CodingKey {
        case type
        case height
        case weighting
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        let type = try container.decode(SizeType.self, forKey: .type)
        
        switch type {
        case .fullWidthFlexibleHeight:
            self = .fullWidthFlexibleHeight
        case .weightedWidthFixedHeight:
            let height = try container.decode(CGFloat.self, forKey: .height)
            let weighting = try container.decode(CGFloat.self, forKey: .weighting)
            self = .weightedWidthFixedHeight(weighting: weighting, height: height)
        }
    }
}
