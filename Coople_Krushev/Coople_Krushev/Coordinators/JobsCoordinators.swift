//
//  JobsCoordinators.swift
//  Coople_Krushev
//
//  Created by Krushev on 8/5/23.
//

import UIKit

protocol JobsCoordinator: AnyObject {
    func start()
}

class JobsCoordinatorImpl: JobsCoordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = JobsListViewModel(coordinator: self)
        let jobsListViewController = JobsListViewController(viewModel: viewModel)
        navigationController.pushViewController(jobsListViewController, animated: false)
    }
}
