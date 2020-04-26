//
//  LoginCoordinator.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 26/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

class LoginCoordinator: ViewCoordinator {
    var childCoordinators: [ViewCoordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.setNavigationBarHidden(true, animated: false)
        let loginViewController: LoginViewController = LoginViewController.create(from: UIStoryboard(name: "Login", bundle: nil))
        navigationController.setViewControllers([loginViewController], animated: true)
    }
    
    func finish() {
        
    }
}
