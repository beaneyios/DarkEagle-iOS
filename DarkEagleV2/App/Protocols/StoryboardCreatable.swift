//
//  StoryboardCreatable.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 13/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

extension UIViewController: StoryboardCreatable {}

protocol StoryboardCreatable {
    static var storyboardId: String { get }
    static func create(from storyboard: UIStoryboard) -> UIViewController
}

extension StoryboardCreatable {
    static var storyboardId: String {
        return "\(Self.self)"
    }
    
    static func create(from storyboard: UIStoryboard) -> UIViewController {
        let viewController = storyboard.instantiateViewController(identifier: self.storyboardId)
        return viewController
    }
}
