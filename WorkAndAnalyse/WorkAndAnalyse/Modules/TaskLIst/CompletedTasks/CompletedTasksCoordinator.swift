//
//  CompletedTasksCoordinator.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 25.05.2021.
//

import UIKit

class CompletedTasksCoordinator: BaseCoordinator {
    // MARK: - Vars & Lets
    
    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory
    
    // MARK: - Coordinator
    
    override func start() {
        showCompletedTasksViewController()
    }
    
    // MARK: - Init
    
    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
    }
    
    // MARK: - Private methods

    
    private func showCompletedTasksViewController() {
        let viewController = viewControllerFactory.instantiateTaskListViewController()
        viewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "checkmark.circle"), tag: 2)
        viewController.navigationItem.title = "Completed"
        
        let viewModel = TaskListViewModel(taskService: TaskServiceImplementation.shared, taskTypes: [.history])
        viewModel.delegate = viewController
        viewModel.noDataText = "You haven't completed any task :("
        
        viewController.viewModel = viewModel
        router.setRootModule(viewController)
    }
}
