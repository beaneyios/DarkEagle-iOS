//
//  TextCell.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 07/04/2020.
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
            case .bold:
                updatedAttributedString.setAttributes(
                    [
                        NSAttributedString.Key.font: UIFont(name: "AvenirNext-Bold", size: 25.0)!
                    ],
                    range: range
                )
            case .url:
                updatedAttributedString.setAttributes(
                    [
                        NSAttributedString.Key.font: UIFont(name: "AvenirNext-Regular", size: 25.0)!,
                        NSAttributedString.Key.foregroundColor: UIColor.blue,
                        NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
                    ],
                    range: range
                )
                break
            }
        }
        
        return updatedAttributedString
    }
}

class TextBlockCell: UICollectionViewCell, NibLoadable {
    
    @IBOutlet weak var textView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.textView.isUserInteractionEnabled = true
        self.textView.isEditable = false
        self.textView.tintColor = .green
        
        let tappy = UITapGestureRecognizer(target: self, action: #selector(objectsTapLabel(gesture:)))
        textView.addGestureRecognizer(tappy)
    }
    
    func configure(with textBlock: TextBlock) {
        let attributedString = NSMutableAttributedString(string: textBlock.text).withStyleRanges(textBlock.styles)
        self.textView.attributedText = attributedString
    }
    
    @IBAction func objectsTapLabel(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: textView)
        let position = CGPoint(x: location.x, y: location.y)
        
        let tapPosition = textView.closestPosition(to: position)
        let tappedRange = textView.tokenizer.rangeEnclosingPosition(
            tapPosition!,
            with: UITextGranularity.sentence,
            inDirection: UITextDirection(rawValue: 1)
        )
        
        if let tappedRange = tappedRange {
            let range = selectedRangeInTextView(textView, tappedRange: tappedRange)
            
            if range.location >= 5 && range.location < 15 {
                print("Hit!")
            } else {
                highlight(selectRange: range)
//                presentOptions(tappedTextRange: tappedRange)
            }
        }
    }
    
    func selectedRangeInTextView(_ textView: UITextView, tappedRange: UITextRange) -> NSRange {
        let beginning = textView.beginningOfDocument
        let selectionStart = tappedRange.start
        let selectionEnd = tappedRange.end
        
        let location = textView.offset(from: beginning, to: selectionStart)
        let length = textView.offset(from: selectionStart, to: selectionEnd)
        
        return NSRange(location: location, length: length)
    }
    
    private func highlight(selectRange: NSRange) {
        textView.becomeFirstResponder()
        textView.selectedRange = selectRange
    }
    
    private func presentOptions(tappedTextRange: UITextRange) {
        let startRect = textView.caretRect(for: tappedTextRange.start)
        let newRect: CGRect = {
            if startRect.minY - 50.0 < 0 {
                return CGRect(x: startRect.minX, y: startRect.maxY + 50.0, width: 150.0, height: 50.0)
            } else {
                return CGRect(x: startRect.minX, y: startRect.minY - 50.0, width: 150.0, height: 50.0)
            }
        }()
        let newView = UIView(frame: newRect)
        newView.backgroundColor = .red
        self.addSubview(newView)
    }
}
