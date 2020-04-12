//
//  TextCell.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 07/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

class TextBlockCell: UICollectionViewCell, NibLoadable {
    
    @IBOutlet weak var textView: UITextView!
    
    private var block: TextBlock?
    private var selectionOptions: UIView?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.textView.isUserInteractionEnabled = true
        self.textView.isEditable = false
        self.textView.tintColor = .green
        self.textView.delegate = self
        
        let tappy = UITapGestureRecognizer(target: self, action: #selector(objectsTapLabel(gesture:)))
        textView.addGestureRecognizer(tappy)
    }
    
    func configure(with textBlock: TextBlock) {
        self.block = textBlock
        let attributedString = NSMutableAttributedString(string: textBlock.text).withStyleRanges(textBlock.styles)
        self.textView.attributedText = attributedString
    }
    
    @IBAction func objectsTapLabel(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: textView)
        let position = CGPoint(x: location.x, y: location.y)
        
        let tapPosition = textView.closestPosition(to: position)
        let tappedSentenceRange = textView.tokenizer.rangeEnclosingPosition(
            tapPosition!,
            with: UITextGranularity.sentence,
            inDirection: UITextDirection(rawValue: 1)
        )
        
        let tappedCharacterRange = textView.tokenizer.rangeEnclosingPosition(
            tapPosition!,
            with: UITextGranularity.character,
            inDirection: UITextDirection(rawValue: 1)
        )
        
        if let tappedSentenceRange = tappedSentenceRange, let tappedCharacterRange = tappedCharacterRange {
            let range = selectedRangeInTextView(textView, tappedRange: tappedSentenceRange)
            let charRange = selectedRangeInTextView(textView, tappedRange: tappedCharacterRange)
            
            if let actions = block?.tapActions {
                let actionTapped = actions.contains {
                    charRange.location >= $0.startIndex && charRange.location + charRange.length <= $0.endIndex
                }
                
                if actionTapped {
                    print("HIT!")
                } else {
                    highlight(selectRange: range)
                }
            } else {
                highlight(selectRange: range)
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
        selectionOptions?.removeFromSuperview()
        
        let startRect = textView.caretRect(for: tappedTextRange.start)
        let endRect = textView.caretRect(for: tappedTextRange.end)
        
        let yPosition: CGFloat = {
            if startRect.minY - 50.0 < 0 {
                return endRect.maxY
            } else {
                return startRect.minY - 50.0
            }
        }()
        
        let newView = UIView()
        newView.backgroundColor = .white
        newView.layer.borderColor = UIColor.black.cgColor
        newView.layer.borderWidth = 0.5
        newView.alpha = 0.9
        addSubview(newView)
        newView.translatesAutoresizingMaskIntoConstraints = false
        
        newView.pinVertically(to: self, at: yPosition)
        newView.center(in: self)
        newView.size(at: CGSize(width: 250.0, height: 50.0))
        
        selectionOptions = newView
    }
}

extension TextBlockCell: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        if let selectedTextRange = textView.selectedTextRange, selectedRangeInTextView(textView, tappedRange: selectedTextRange).length > 0 {
            presentOptions(tappedTextRange: textView.selectedTextRange!)
        }
    }
}
