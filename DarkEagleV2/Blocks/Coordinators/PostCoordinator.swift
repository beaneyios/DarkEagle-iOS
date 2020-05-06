//
//  File.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 06/05/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

class PostCoordinator: PostCoordinating {
    weak var coordinatorDelegate: ViewCoordinatorDelegate?
    
    var childCoordinators: [ViewCoordinator] = []
    let navigationController: UINavigationController
    
    let postId: String
    
    init(postId: String, navigationController: UINavigationController, coordinatorDelegate: ViewCoordinatorDelegate?) {
        self.postId = postId
        self.navigationController = navigationController
        self.coordinatorDelegate = coordinatorDelegate
        
        navigationController.navigationBar.tintColor = UIColor(named: "de-purple")
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Block", bundle: nil)
        let viewController: BlockListViewController = BlockListViewController.create(from: storyboard)
        
        let viewModel = PostBlockListViewModel(postId: postId)
        
        let loadingView = LoadingView.instanceFromNib()
        loadingView.configureSizes(size: CGSize(width: 10, height: 10), padding: 0)
        loadingView.configureBorders(borderColor: UIColor.white, borderWidth: 1)
        
        viewController.viewModel = viewModel
        viewController.loadingView = loadingView
        viewController.configureSkeletonView(withType: PostSkeletonView.self)
        viewController.delegate = self
        
        let saveController = BookmarkController()
        let status = saveController.getBookmarkStatus(id: postId)
        let bookmarkItem = UIBarButtonItem(
            image: status.bookmarkImage,
            style: .done,
            target: viewModel,
            action: #selector(PostBlockListViewModel.bookmarkPost)
        )
        
        viewController.navigationItem.rightBarButtonItems = [newNavBarLoadingViewBarButton(withLoadingView: loadingView), bookmarkItem]
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func finish() {
        coordinatorDelegate?.coordinatorDidFinish(self)
    }
}

extension PostCoordinator: BlockListViewControllerDelegate, SafariLoading {
    func blockListViewController(_ viewController: BlockListViewController, didSelectOpenUrl url: URL) {
        loadUrlInSafari(url: url, on: navigationController)
    }
    
    func blockListViewController(_ viewController: BlockListViewController, didSelectOpenPostWithId postId: String) {
        openPost(id: postId, navigationController: navigationController)
    }
    
    func blockListViewController(_ viewController: BlockListViewController, didBookmarkPostWithId postId: String, andResult result: BookmarkController.Result) {
        let saveController = BookmarkController()
        let status = saveController.getBookmarkStatus(id: postId)
        
        guard let viewModel = viewController.viewModel as? PostBlockListViewModel, let loadingView = viewController.loadingView else {
            return
        }
        
        let bookmarkItem = UIBarButtonItem(
            image: status.bookmarkImage,
            style: .done,
            target: viewModel,
            action: #selector(PostBlockListViewModel.bookmarkPost)
        )
        
        viewController.navigationItem.rightBarButtonItems = [
            newNavBarLoadingViewBarButton(withLoadingView: loadingView),
            bookmarkItem
        ]
    }
}
