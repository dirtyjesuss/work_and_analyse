//
//  CoordinatorFactory.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 27.03.2021.
//

import UIKit

protocol CoordinatorFactoryProtocol {
    func makeAuthCoordinator(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> AuthCoordinator
    
    func makeTaskCreationCoordinator(navigationController: UINavigationController, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> (TaskCreationCoordinator, UINavigationController)
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    
    // MARK: - CoordinatorFactoryProtocol

    func makeTaskCreationCoordinator(navigationController: UINavigationController, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> (TaskCreationCoordinator, UINavigationController) {
        let coordinator = TaskCreationCoordinator(router: Router(rootController: navigationController), coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
        return (coordinator, navigationController)
    }
    
    func makeAuthCoordinator(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> AuthCoordinator {
        let coordinator = AuthCoordinator(router: router, coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
        return coordinator
    }
}
