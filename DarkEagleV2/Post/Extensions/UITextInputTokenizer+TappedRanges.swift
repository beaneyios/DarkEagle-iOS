//
//  UITextInputTokenizer+TappedRanges.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 12/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

extension UITextInputTokenizer {
    func tappedSentenceRange(tapPosition: UITextPosition?) -> UITextRange? {
        guard let tapPosition = tapPosition else { return nil }
        return rangeEnclosingPosition(tapPosition, with: .sentence, inDirection: UITextDirection(rawValue: 1))
    }
    
    func tappedCharacterRange(tapPosition: UITextPosition?) -> UITextRange? {
        guard let tapPosition = tapPosition else { return nil }
        return rangeEnclosingPosition(tapPosition, with: .character, inDirection: UITextDirection(rawValue: 1))
    }
}
