//
//  NavigationControllerCoordinator.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 18/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

class NavigationControllerCoordinator: NSObject, NavigationCoordinator {
    var navigationController: UINavigationController
    var parent: NavigationCoordinator?
    var childCoordinators: [NavigationCoordinator] = []
    var managedViewControllers: [Weak<UIViewController>] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        assertionFailure("Needs to be implemented by subclass")
    }
    
    func finish() {
        parent?.remove(self)
    }
}

extension NavigationControllerCoordinator: UINavigationControllerDelegate {
    func push(_ viewController: UIViewController, animated: Bool) {
        managedViewControllers.append(Weak(viewController))
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if navigationController.viewControllerIsManaged(viewController, by: managedViewControllers) {
            finish()
        }
    }
}
