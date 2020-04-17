//
//  DynamicConfigureActionProvider.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 11/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation

struct DynamicConfigureActionProvider {
    typealias ConfigureAction = DynamicCellSizeProvider.ConfigureAction<DynamicCellSizeProvider.TemplateCell>
    
    static func configureAction(for block: Block) -> ConfigureAction {
        { (_ templateCell: DynamicCellSizeProvider.TemplateCell) in
            switch (block, templateCell) {
            case let (block as TextBlock, templateCell as TextBlockCell):
                templateCell.configure(with: block)
            case let (block as CardBlock, templateCell as CardBlockCell):
                templateCell.configure(with: block)
            default:
                break
            }
        }
    }
}
