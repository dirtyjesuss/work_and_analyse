//
//  MyTasksCoordinator.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 28.04.2021.
//

import UIKit

class MyTasksCoordinator: BaseCoordinator {
    
    // MARK: - Vars & Lets
    
    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory
    
    // MARK: - Coordinator
    
    override func start() {
        showMyTasksViewController()
    }
    
    // MARK: - Init
    
    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
    }
    
    // MARK: - Private methods
    
    private func showMyTasksViewController() {
        let viewController = viewControllerFactory.instantiateTaskListViewController()
        viewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.crop.circle"), tag: 1)
        viewController.navigationItem.title = "My tasks"
        
        let viewModel = TaskListViewModel(taskService: TaskServiceImplementation.shared, taskTypes: [.missing, .next])
        viewModel.delegate = viewController
        viewModel.noDataText = "No tasks to complete :("
        
        viewController.viewModel = viewModel
        router.setRootModule(viewController)
    }
}
