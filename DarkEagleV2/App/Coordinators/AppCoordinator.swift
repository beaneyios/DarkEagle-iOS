//
//  AppCoordinator.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 22/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

class AppCoordinator: ViewCoordinator {
    var childCoordinators: [ViewCoordinator] = []
    var tabBarController: UITabBarController
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        let vc1 = addPostCoordinator()
        let vc2 = addPostCoordinator()
        let vc3 = addPostCoordinator()
        tabBarController.setViewControllers([vc1, vc2, vc3], animated: false)
    }
    
    private func addPostCoordinator() -> UIViewController {
        let navigationController = UINavigationController()
        let postCoordinator = PostListCoordinator(
            navigationController: navigationController,
            coordinatorDelegate: nil
        )
        
        navigationController.tabBarItem = UITabBarItem(title: "Post", image: nil, selectedImage: nil)
        
        postCoordinator.start()
        add(postCoordinator)
        return navigationController
    }
    
    func finish() {
        assertionFailure("This should never finish!")
    }
}
