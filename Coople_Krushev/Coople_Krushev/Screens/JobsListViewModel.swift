//
//  JobsListViewModel.swift
//  Coople_Krushev
//
//  Created by Krushev on 8/5/23.
//

import Foundation
import Combine

class JobsListViewModel {
    weak var coordinator: JobsCoordinator?
    private var cancellables = Set<AnyCancellable>()

    @Published var jobs: [Job] = []

    init(coordinator: JobsCoordinator?) {
        self.coordinator = coordinator
        loadJobs()
    }
    
    private func loadJobs() {
        NetworkManager.shared.getJobs()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("An error occurred: \(error)")
                case .finished:
                    print("Finished loading jobs")
                }
            }, receiveValue: { [weak self] response in
                print("Jobs count: \(response.data?.items?.count)")
                self?.jobs = response.data?.items ?? []
            })
            .store(in: &cancellables)
    }
}
