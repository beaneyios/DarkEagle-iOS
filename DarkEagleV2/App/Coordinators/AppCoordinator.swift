//
//  AppCoordinator.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 18/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit
import SafariServices

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
        viewController.delegate = self
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    func finish() {
        assertionFailure("This should never finish!")
    }
}

extension AppCoordinator: BlockListViewControllerDelegate {
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
