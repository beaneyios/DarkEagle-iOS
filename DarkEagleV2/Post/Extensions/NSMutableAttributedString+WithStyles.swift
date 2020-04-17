//
//  NSMutableAttributedString+WithStyles.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 12/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    func withStyleRanges(_ styleRanges: [TextStyleRange]) -> Self {
        let updatedAttributedString = self
        
        styleRanges.forEach {
            // If endIndex is nil, it means the user wants the style to apply to the whole block.
            let endIndex = $0.endIndex ?? (updatedAttributedString.string.count - 1)
            let length = endIndex - $0.startIndex + 1
            let range = NSRange(location: $0.startIndex, length: length)
            
            switch $0.style {
            case .underlined:
                updatedAttributedString.addAttributes([.underlineStyle: NSUnderlineStyle.single.rawValue], range: range)
            case let .colour(colour):
                updatedAttributedString.addAttribute(.foregroundColor, value: colour, range: range)
            case let .font(font):
                updatedAttributedString.addAttribute(.font, value: font, range: range)
            case .none:
                break
            }
        }
        
        return updatedAttributedString
    }
}
