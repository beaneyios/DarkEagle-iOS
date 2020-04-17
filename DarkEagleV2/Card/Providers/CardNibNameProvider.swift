//
//  CardNibNameProvider.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 14/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation

struct CardNibNameProvider {
    static func nibName(for cardType: CardBlock.CardType) -> String {
        switch cardType {
        case .row:
            return "RowCardBlockCell"
        }
    }
}
