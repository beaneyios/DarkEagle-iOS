//
//  AppCoordinator.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 18/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit
import SafariServices

class PostListCoordinator: PostCoordinating {
    weak var coordinatorDelegate: ViewCoordinatorDelegate?
    
    var childCoordinators: [ViewCoordinator] = []
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, coordinatorDelegate: ViewCoordinatorDelegate?) {
        self.navigationController = navigationController
        self.coordinatorDelegate = coordinatorDelegate
        
        navigationController.navigationBar.tintColor = UIColor(named: "de-purple")
    }
    
    func start() {
        let viewController = newBlockListViewController
        viewController.viewModel = ListViewModel()
        viewController.delegate = self
        
        let refreshNavImage = UIImage(named: "refresh-icon")
        let refreshNavItem = UIBarButtonItem(
            image: refreshNavImage,
            style: .plain,
            target: viewController,
            action: #selector(BlockListViewController.refresh)
        )
        refreshNavItem.tintColor = UIColor(named: "de-purple")
        
        let loadingView = newLoadingView
        viewController.navigationItem.leftBarButtonItems = [newNavBarLoadingViewBarButton(withLoadingView: loadingView)]
        viewController.navigationItem.rightBarButtonItem = refreshNavItem
        viewController.loadingView = loadingView
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    func finish() {
        coordinatorDelegate?.coordinatorDidFinish(self)
    }
}

extension PostListCoordinator: BlockListViewControllerDelegate, SafariLoading {
    func blockListViewController(_ viewController: BlockListViewController, didSelectOpenPostWithId postId: String) {
        openPost(id: postId, navigationController: navigationController)
    }
    
    func blockListViewController(_ viewController: BlockListViewController, didSelectOpenUrl url: URL) {
        loadUrlInSafari(url: url, on: navigationController)
    }
    
    func blockListViewController(_ viewController: BlockListViewController, didBookmarkPostWithId postId: String, andResult result: SaveController.Result) {
        
    }
}
