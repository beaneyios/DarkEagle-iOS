//
//  UITextView+selectedRangeConversion.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 12/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

extension UITextView {
    func selectedRangeInTextView(tappedRange: UITextRange) -> NSRange {
        let beginning = beginningOfDocument
        let selectionStart = tappedRange.start
        let selectionEnd = tappedRange.end
        
        let location = offset(from: beginning, to: selectionStart)
        let length = offset(from: selectionStart, to: selectionEnd)
        
        return NSRange(location: location, length: length)
    }
    
    func highlight(_ selectRange: NSRange) {
        becomeFirstResponder()
        selectedRange = selectRange
    }
}
