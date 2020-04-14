//
//  DETextView.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 11/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

class DETextView: UITextView {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}
