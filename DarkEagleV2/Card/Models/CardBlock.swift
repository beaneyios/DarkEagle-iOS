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
    }
    
    var id: String
    var type: BlockType
    var title: String
    var subtitle: String
    var image: Image
    var tapAction: TapAction?
    var cardType: CardType
    var style: CardStyle?
}
