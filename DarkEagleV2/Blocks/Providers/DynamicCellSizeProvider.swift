//
//  DynamicCellSizeProvider.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 11/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

class DynamicCellSizeProvider {
    typealias ConfigureAction<T> = (_ cell: T) -> Void
    typealias TemplateCell = UIView & NibLoadable
    
    private var sizes = [IndexPath: CGSize]()
    private var nibs = [TemplateCell]()
    
    func resetSizes() {
        sizes = [:]
    }
    
    func size<T: TemplateCell>(indexPath: IndexPath, nibCreatable: T.Type, nibName: String? = nil, preferredWidth: CGFloat, configureAction: ConfigureAction<TemplateCell>?) -> CGSize {
        if let cachedSize = sizes[indexPath] {
            return cachedSize
        }
        
        let templateCell: TemplateCell = {
            guard let templateCell: TemplateCell = nibs.first(ofType: nibCreatable.self) else {
                return nibCreatable.createTemplate(named: nibName)
            }
            
            return templateCell
        }()
        
        nibs.append(templateCell)
        
        templateCell.frame.size.width = preferredWidth
        configureAction?(templateCell)
        
        templateCell.setNeedsLayout()
        templateCell.layoutIfNeeded()
        
        let size = templateCell.systemLayoutSizeFitting(
            CGSize(
                width: preferredWidth,
                height: UIView.layoutFittingCompressedSize.height
            )
        )
        
        let calculatedSize = CGSize(width: preferredWidth, height: size.height)
        sizes[indexPath] = calculatedSize
        return calculatedSize
    }
}
