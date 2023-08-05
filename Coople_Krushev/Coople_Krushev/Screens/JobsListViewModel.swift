//
//  JobsListViewModel.swift
//  Coople_Krushev
//
//  Created by Krushev on 8/5/23.
//

import Foundation

class JobsListViewModel {
    weak var coordinator: JobsCoordinator?

    init(coordinator: JobsCoordinator?) {
        self.coordinator = coordinator
    }
}
