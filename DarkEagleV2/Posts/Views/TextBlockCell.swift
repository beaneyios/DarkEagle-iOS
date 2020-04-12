//
//  TextCell.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 07/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

protocol TextBlockCellDelegate: AnyObject {
    func actionTapped(_ action: TapAction)
}

class TextBlockCell: UICollectionViewCell, NibLoadable {
    
    @IBOutlet weak var textView: UITextView!
    
    weak var delegate: TextBlockCellDelegate?
    
    private var block: TextBlock?
    private var selectionOptions: SelectionOptionsView?

    override func prepareForReuse() {
        super.prepareForReuse()
        dismissSelectionOptions()
    }
    
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
        block = textBlock
        let attributedString = NSMutableAttributedString(string: textBlock.text).withStyleRanges(textBlock.styles)
        textView.attributedText = attributedString
    }
    
    @IBAction func objectsTapLabel(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: textView)
        let position = CGPoint(x: location.x, y: location.y)
        
        let tapPosition = textView.closestPosition(to: position)
        
        guard
            let tappedSentenceRange = textView.tokenizer.tappedSentenceRange(tapPosition: tapPosition),
            let tappedCharacterRange = textView.tokenizer.tappedCharacterRange(tapPosition: tapPosition)
        else {
            return
        }
        
        let sentenceRange = textView.selectedRangeInTextView(tappedRange: tappedSentenceRange)
        let characterRange = textView.selectedRangeInTextView(tappedRange: tappedCharacterRange)
        
        guard let actions = block?.tapActions, let action = action(forCharacterRange: characterRange, actions: actions) else {
            if textView.selectedRange == sentenceRange {
                clearSelection()
            } else {
                textView.highlight(sentenceRange)
            }
            return
        }
                    
        delegate?.actionTapped(action)
    }
    
    func clearSelection() {
        textView.selectedTextRange = nil
    }
    
    private func dismissSelectionOptions() {
        selectionOptions?.removeFromSuperview()
        selectionOptions = nil
    }
    
    private func action(forCharacterRange characterRange: NSRange, actions: [TapActionRange]) -> TapAction? {
        actions.first {
            characterRange.location >= $0.startIndex && characterRange.location + characterRange.length <= $0.endIndex
        }?.action
    }
    
    private func presentSelectionOptions(tappedTextRange: UITextRange) {
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
        
        let newView = SelectionOptionsView(frame: .zero)
        addSubview(newView)
        newView.translatesAutoresizingMaskIntoConstraints = false
        
        newView.pinVertically(to: self, at: yPosition)
        newView.center(in: self)
        newView.height(50.0)
        newView.widthAnchor.constraint(greaterThanOrEqualToConstant: 10.0).activate()
        selectionOptions = newView
    }
}

extension TextBlockCell: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        if let selectedTextRange = textView.selectedTextRange, textView.selectedRangeInTextView(tappedRange: selectedTextRange).length > 0 {
            presentSelectionOptions(tappedTextRange: textView.selectedTextRange!)
        } else {
            dismissSelectionOptions()
        }
    }
}
