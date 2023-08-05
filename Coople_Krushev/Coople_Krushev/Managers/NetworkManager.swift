//
//  NetworkManager.swift
//  Coople_test
//
//  Created by Krushev on 8/5/23.
//

import Foundation
import Combine

protocol NetworkManagerProtocol {
    func getJobs() -> AnyPublisher<JobResponse, Error>
}

class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    private init() {}

    func getJobs() -> AnyPublisher<JobResponse, Error> {
        //MARK: used https instead of http
        guard let url = URL(string:
                                "https://www.coople.com/ch/resources/api/work-assignments/public-jobs/list?pageNum=0&pageSize=200") else {
            fatalError("Invalid URL")
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: JobResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
