//
//  Style.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 11/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

enum Style {
    case bold
    case underlined
    case coloured(UIColor)
    case none
}

struct StyleRange: Decodable {
    var startIndex: Int
    var endIndex: Int
    var style: Style
    
    enum DecodingKeys: CodingKey {
        case startIndex
        case endIndex
        case colour
        case style
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        self.style = StyleRange.style(from: container)
        self.startIndex = try container.decode(Int.self, forKey: .startIndex)
        self.endIndex = try container.decode(Int.self, forKey: .endIndex)
    }
    
    static func style(from container: KeyedDecodingContainer<DecodingKeys>) -> Style {
        do {
            let style = try container.decode(String.self, forKey: .style)
            
            switch style {
            case "bold":
                return .bold
            case "underlined":
                return .underlined
            case "coloured":
                let colourHex = try container.decode(String.self, forKey: .colour)
                guard let colour = UIColor(hex: colourHex) else {
                    return .none
                }
                
                return .coloured(colour)
            default:
                return .none
            }
        } catch {
            return .none
        }
    }
}
