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
        tabBarController.tabBar.tintColor = UIColor(named: "de-purple")
    }
    
    func start() {
        let postList = self.postList()
        let localList = self.localList()
        let userView = self.userView()
        tabBarController.tabBar.isHidden = true
        tabBarController.setViewControllers([postList, localList, userView], animated: false)
    }
    
    private func showLoginScreen() {
        let navigationController = UINavigationController()
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator.start()
        add(loginCoordinator)
        tabBarController.tabBar.isHidden = true
        tabBarController.setViewControllers([navigationController], animated: false)
    }
    
    private func postList() -> UIViewController {
        let navigationController = UINavigationController()
        let postCoordinator = PostListCoordinator(
            navigationController: navigationController,
            coordinatorDelegate: nil
        )
        
        navigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "home-icon"), selectedImage: nil)
        postCoordinator.start()
        add(postCoordinator)
        
        return navigationController
    }
    
    private func userView() -> UIViewController {
        let navigationController = UINavigationController()
        let postCoordinator = PostListCoordinator(
            navigationController: navigationController,
            coordinatorDelegate: nil
        )
        
        navigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "user-icon"), selectedImage: nil)
        postCoordinator.start()
        add(postCoordinator)
        
        return navigationController
    }
    
    private func localList() -> UIViewController {
        let navigationController = UINavigationController()
        let postCoordinator = PostListCoordinator(
            navigationController: navigationController,
            coordinatorDelegate: nil
        )
        
        navigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "aim-icon"), selectedImage: nil)
        postCoordinator.start()
        add(postCoordinator)
        
        return navigationController
    }
    
    func finish() {
        assertionFailure("This should never finish!")
    }
}
