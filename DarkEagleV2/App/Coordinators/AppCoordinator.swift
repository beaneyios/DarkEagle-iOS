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
        showSplashScreen()
    }
    
    private func showStories() {
        let postList = self.postList()
        let localList = self.localList()
        let userView = self.userView()
        tabBarController.tabBar.isHidden = true
        tabBarController.setViewControllers([postList, localList, userView], animated: true)
    }
    
    private func showSplashScreen() {
        let viewController = newSplashViewController
        viewController.delegate = self
        tabBarController.tabBar.isHidden = true
        tabBarController.setViewControllers([viewController], animated: true)
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
            coordinatorDelegate: self
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
            coordinatorDelegate: self
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
            coordinatorDelegate: self
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

extension AppCoordinator {
    var newSplashViewController: SplashViewController {
        let storyboard = UIStoryboard(name: "Splash", bundle: nil)
        return SplashViewController.create(from: storyboard)
    }
}

extension AppCoordinator: SplashViewControllerDelegate {
    func splashViewControllerDidEndLoading(_ splashViewController: SplashViewController) {
        showStories()
    }
}
