//
//  BlockSection.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 14/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

struct BlockSection: Decodable {
    var blocks: [AnyBlock]
    var sectionSpacing: CGFloat?
    var itemSpacing: CGFloat?
}
