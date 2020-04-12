//
//  NSMutableAttributedString+WithStyles.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 12/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    func withStyleRanges(_ styleRanges: [StyleRange]) -> Self {
        let updatedAttributedString = self
        updatedAttributedString.setAttributes(
            [
                NSAttributedString.Key.font: UIFont(name: "AvenirNext-Regular", size: 25.0)!
            ],
            range: NSRange(location: 0, length: updatedAttributedString.string.count)
        )
        
        styleRanges.forEach {
            let length = $0.endIndex - $0.startIndex + 1
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
