//
//  CardBlock.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 14/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

struct CardBlock: Block, Decodable {
    enum CardType: String, Decodable {
        case row
        case large
    }
    
    struct Style: Decodable {
        var titleStyle: FontStyle
        var subtitleStyle: FontStyle
    }
    
    var cardType: CardType
    var id: String
    var image: Image
    var size: Size?
    var subtitle: String
    var style: Style?
    var tapAction: TapAction?
    var type: BlockType
    var title: String
}
