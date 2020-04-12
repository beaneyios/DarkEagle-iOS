//
//  Style.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 11/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

enum Style {
    case underlined
    case colour(UIColor)
    case font(UIFont)
    case none
}

struct StyleRange: Decodable {
    var startIndex: Int
    var endIndex: Int?
    var style: Style
    
    enum DecodingKeys: CodingKey {
        case style

        case startIndex
        case endIndex
        case colour
        case fontName
        case fontSize
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        self.style = StyleRange.style(from: container)
        self.startIndex = try container.decode(Int.self, forKey: .startIndex)
        self.endIndex = try container.decodeIfPresent(Int.self, forKey: .endIndex)
    }
    
    static func style(from container: KeyedDecodingContainer<DecodingKeys>) -> Style {
        do {
            let style = try container.decode(String.self, forKey: .style)
            
            switch style {
            case "underlined":
                return .underlined
            case "colour":
                return try colourStyle(from: container)
            case "font":
                return try fontStyle(from: container)
            default:
                return .none
            }
        } catch {
            return .none
        }
    }
    
    static func colourStyle(from container: KeyedDecodingContainer<DecodingKeys>) throws -> Style {
        let colourHex = try container.decode(String.self, forKey: .colour)
        guard let colour = UIColor(hex: colourHex) else {
            return .none
        }
        
        return .colour(colour)
    }
    
    static func fontStyle(from container: KeyedDecodingContainer<DecodingKeys>) throws -> Style {
        let fontName = try container.decode(String.self, forKey: .fontName)
        let fontSize = try container.decode(Double.self, forKey: .fontSize)
        guard let font = UIFont(name: fontName, size: CGFloat(fontSize)) else {
            return .none
        }
        
        return .font(font)
    }
}
