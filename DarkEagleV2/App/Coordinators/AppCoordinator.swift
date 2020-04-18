//
//  AppCoordinator.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 18/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

class AppCoordinator: NavigationCoordinator {
    weak var parent: NavigationCoordinator? = nil
    var childCoordinators: [NavigationCoordinator] = []
    var managedViewControllers: [UIViewController]? = nil
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Block", bundle: nil)
        let viewController: BlockListViewController = BlockListViewController.create(from: storyboard)
        viewController.viewModel = ListViewModel()
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    func finish() {
        assertionFailure("This should never finish!")
    }
}
