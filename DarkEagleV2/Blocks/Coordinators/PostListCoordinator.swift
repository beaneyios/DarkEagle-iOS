//
//  AppCoordinator.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 18/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit
import SafariServices

class PostListCoordinator: ViewCoordinator {
    weak var coordinatorDelegate: ViewCoordinatorDelegate?
    
    var childCoordinators: [ViewCoordinator] = []
    let navigationController: UINavigationController

    init(navigationController: UINavigationController, coordinatorDelegate: ViewCoordinatorDelegate?) {
        self.navigationController = navigationController
        self.coordinatorDelegate = coordinatorDelegate
    }
    
    func start() {
        let loginViewController: LoginViewController = LoginViewController.create(from: UIStoryboard(name: "Login", bundle: nil))
        navigationController.setViewControllers([loginViewController], animated: true)
        return;
        let storyboard = UIStoryboard(name: "Block", bundle: nil)
        let viewController: BlockListViewController = BlockListViewController.create(from: storyboard)
        viewController.title = "DarkEagle"
        viewController.viewModel = ListViewModel()
        viewController.delegate = self
        
        let userNavImage = UIImage(named: "user-icon")
        let userNavItem = UIBarButtonItem(image: userNavImage, style: .plain, target: nil, action: nil)
        userNavItem.tintColor = .black
        
        let refreshNavImage = UIImage(named: "refresh-icon")
        let refreshNavItem = UIBarButtonItem(image: refreshNavImage, style: .plain, target: nil, action: nil)
        refreshNavItem.tintColor = .black
        
        viewController.navigationItem.leftBarButtonItem = userNavItem
        viewController.navigationItem.rightBarButtonItem = refreshNavItem
        
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    func finish() {
        coordinatorDelegate?.coordinatorDidFinish(self)
    }
}

extension PostListCoordinator: BlockListViewControllerDelegate {
    func blockListViewController(_ viewController: BlockListViewController, didSelectOpenPostWithId postId: String) {
        let storyboard = UIStoryboard(name: "Block", bundle: nil)
        let viewController: BlockListViewController = BlockListViewController.create(from: storyboard)
        viewController.viewModel = NativePostViewModel(postId: postId)
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func blockListViewController(_ viewController: BlockListViewController, didSelectOpenUrl url: URL) {
        let sf = SFSafariViewController(url: url)
        navigationController.present(sf, animated: true, completion: nil)
    }
}
