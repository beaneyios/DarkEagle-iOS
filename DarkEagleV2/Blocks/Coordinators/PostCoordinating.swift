//
//  PostCoordinator.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 06/05/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

protocol PostCoordinating: ViewCoordinator {}

extension PostCoordinating {
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
    
    func openPost(id: String, navigationController: UINavigationController) {
        let postCoordinator = PostCoordinator(
            postId: id,
            navigationController: navigationController,
            coordinatorDelegate: self
        )
        
        add(postCoordinator)
        postCoordinator.start()
    }
}
