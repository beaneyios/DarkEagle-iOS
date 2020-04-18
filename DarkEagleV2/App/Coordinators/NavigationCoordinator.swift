//
//  NavigationCoordinator.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 18/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

protocol NavigationCoordinator: AnyObject {
    var navigationController: UINavigationController { get }
    var parent: NavigationCoordinator? { get set }
    var childCoordinators: [NavigationCoordinator] { get set }
    
    func start()
    func finish()
    func add(_ coordinator: NavigationCoordinator)
    func remove(_ coordinator: NavigationCoordinator)
}

extension NavigationCoordinator {
    func add(_ coordinator: NavigationCoordinator) {
        coordinator.parent = self
        childCoordinators.append(coordinator)
    }
    
    func remove(_ coordinator: NavigationCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}

extension UINavigationController {
    func viewControllerIsManaged(_ viewController: UIViewController, by viewControllers: [Weak<UIViewController>]) -> Bool {
        // Check to see if view controller has been popped.
        guard
            let from = self.transitionCoordinator?.viewController(forKey: .from),
            !self.viewControllers.contains(from)
        else {
            return false
        }
        
        // If the view controller we have popped to does not live in
        // the managed list of VC's for that coordinator, it's time to kill
        // the coordinator.
        let contained = viewControllers.contains {
            $0.value == viewController
        }
        
        return !contained
    }
}
