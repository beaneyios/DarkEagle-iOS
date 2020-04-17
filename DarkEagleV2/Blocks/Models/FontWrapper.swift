//
//  FontWrapper.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 14/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

final class FontWrapper: Decodable {
    enum DecodingKey: CodingKey {
        case fontName
        case fontSize
    }
    
    var font: UIFont
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKey.self)
        let fontName = try container.decode(String.self, forKey: .fontName)
        let fontSize = try container.decode(CGFloat.self, forKey: .fontSize)
        
        let descriptor = UIFontDescriptor(name: fontName, size: fontSize)
        font = UIFont(descriptor: descriptor, size: fontSize)
    }
}
