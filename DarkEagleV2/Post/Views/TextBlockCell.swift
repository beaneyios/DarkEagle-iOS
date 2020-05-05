//
//  TextCell.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 07/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit
import SkeletonView

protocol TextBlockCellDelegate: AnyObject {
    func textBlockCell(_ cell: TextBlockCell, wasSelectedWithTapAction action: TapAction)
    func textBlockCell(_ cell: TextBlockCell, didSelectatYPosition yPosition: CGFloat)
    func textBlockCellDidDismissOptions()
}

class TextBlockCell: UICollectionViewCell, NibLoadable {
    
    @IBOutlet weak var textView: DETextView!
    
    weak var delegate: TextBlockCellDelegate?
    
    private var block: TextBlock?

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clipsToBounds = false
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        textView.tintColor = .green
        textView.delegate = self
        textView.textContainerInset = UIEdgeInsets(top: 4.0, left: 8.0, bottom: 4.0, right: 8.0)
        
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
                    
        delegate?.textBlockCell(self, wasSelectedWithTapAction: action)
    }
    
    func clearSelection() {
        textView.selectedTextRange = nil
    }
    
    private func action(forCharacterRange characterRange: NSRange, actions: [TapActionRange]) -> TapAction? {
        actions.first {
            characterRange.location >= $0.startIndex && characterRange.location + characterRange.length <= $0.endIndex
        }?.action
    }
    
    private func presentSelectionOptions(tappedTextRange: UITextRange) {
        
        let startRect = textView.caretRect(for: tappedTextRange.start)
        let endRect = textView.caretRect(for: tappedTextRange.end)
        
        let yPosition: CGFloat = {
            let selectionAtTopOfCell = startRect.minY - 50.0 < 0
            let selectionAtBottomOfCell = endRect.maxY + 50 > frame.height
            
            // If the cell is too small to go at the top or bottom, center it.
            if selectionAtTopOfCell && selectionAtBottomOfCell {
                return startRect.minY - 50.0;
            }
            
            // If the selection is at the top, present the options at the bottom.
            if selectionAtTopOfCell {
                return endRect.maxY
            }
            
            // Otherwise, default to presenting options at the top.
            return startRect.minY - 50.0
        }()
        
        self.delegate?.textBlockCell(self, didSelectatYPosition: yPosition)
    }
}

extension TextBlockCell: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        guard
            let deTextView = textView as? DETextView,
            let selectedTextRange = textView.selectedTextRange,
            deTextView.selectedRangeInTextView(tappedRange: selectedTextRange).length > 0
        else {
            delegate?.textBlockCellDidDismissOptions()
            return
        }
        
        presentSelectionOptions(tappedTextRange: selectedTextRange)
    }
}
