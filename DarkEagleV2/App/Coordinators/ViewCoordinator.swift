//
//  ViewCoordinator.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 25/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation

protocol ViewCoordinatorDelegate: AnyObject {
    func coordinatorDidFinish(_ coordinator: ViewCoordinator)
}

protocol ViewCoordinator: AnyObject {
    var childCoordinators: [ViewCoordinator] { get set }
    
    func start()
    func finish()
    func add(_ coordinator: ViewCoordinator)
    func remove(_ coordinator: ViewCoordinator)
}

extension ViewCoordinator {
    func add(_ coordinator: ViewCoordinator) {
        childCoordinators.append(coordinator)
    }
    
    func remove(_ coordinator: ViewCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
