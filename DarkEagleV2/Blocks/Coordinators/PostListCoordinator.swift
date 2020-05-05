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

// MARK: Generate new views
extension PostListCoordinator {
    var newBlockListViewController: BlockListViewController {
        let storyboard = UIStoryboard(name: "Block", bundle: nil)
        return BlockListViewController.create(from: storyboard)
    }
    
    var newLoadingView: LoadingView {
        let loadingView = LoadingView.instanceFromNib()
        loadingView.configureSizes(size: CGSize(width: 10, height: 10), padding: 0)
        loadingView.configureBorders(borderColor: UIColor.white, borderWidth: 1)
        return loadingView
    }
    
    func newNavBarLoadingViewBarButton(withLoadingView loadingView: LoadingView) -> UIBarButtonItem {
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 20.0, height: 44.0))
        spacerView.addSubview(loadingView)
        loadingView.frame = spacerView.frame
        let spacerButton = UIBarButtonItem(customView: spacerView)
        return spacerButton
    }
}

extension PostListCoordinator: BlockListViewControllerDelegate {
    func blockListViewController(_ viewController: BlockListViewController, didSelectOpenPostWithId postId: String) {
        let viewController = newBlockListViewController
        viewController.viewModel = NativePostViewModel(postId: postId)
        viewController.delegate = self
        
        let loadingView = newLoadingView
        viewController.navigationItem.rightBarButtonItems = [newNavBarLoadingViewBarButton(withLoadingView: loadingView)]
        viewController.loadingView = loadingView
        viewController.configureSkeletonView(withType: PostSkeletonView.self)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func blockListViewController(_ viewController: BlockListViewController, didSelectOpenUrl url: URL) {
        let sf = SFSafariViewController(url: url)
        navigationController.present(sf, animated: true, completion: nil)
    }
}
