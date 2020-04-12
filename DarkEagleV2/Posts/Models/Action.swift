//
//  Action.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 12/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation

enum TapAction: Decodable {
    case openURL(_ url: URL)
    case none
    
    enum DecodingKeys: CodingKey {
        case type
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        
        switch type {
        case "openURL":
            let url = try container.decode(URL.self, forKey: .url)
            self = .openURL(url)
        default:
            self = .none
        }
    }
}

struct TapActionRange: Decodable {
    var startIndex: Int
    var endIndex: Int
    var action: TapAction
}
