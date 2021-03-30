//
//  CreateTaskCoordinator.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 17.03.2021.
//
import UIKit

class TaskCreationCoordinator: BaseCoordinator, TaskCreationCoordinatorFinishOutput {
    
    // MARK: - AuthCoordinatorFinishOutput
    
    var finishFlow: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory
    
    // MARK: - Private methods
    private func showCreateTaskViewController() {
        let viewController = viewControllerFactory.instantiateCreateTaskViewController()
        viewController.tabBarItem = UITabBarItem(title: "Create task", image: UIImage(systemName: "plus"), tag: 0)

        router.setRootModule(viewController)
    }
    
    // MARK: - Coordinator
    
    override func start() {
        self.showCreateTaskViewController()
    }
    
    // MARK: - Init
    
    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
    }
}