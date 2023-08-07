//
//  NetworkManager.swift
//  Coople_test
//
//  Created by Krushev on 8/5/23.
//

import Foundation
import Combine

protocol URLSessionProtocol {
    func customDataTaskPublisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

extension URLSession: URLSessionProtocol {
    
    func customDataTaskPublisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        return self.dataTaskPublisher(for: url).eraseToAnyPublisher()
    }
}

protocol NetworkManagerProtocol {
    func getJobs() -> AnyPublisher<JobResponse, Error>
}

class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager(session: URLSession.shared)

    private let session: URLSessionProtocol

    init(session: URLSessionProtocol) {
        self.session = session
    }

    func getJobs() -> AnyPublisher<JobResponse, Error> {
        guard let url = URL(string:
                                "https://www.coople.com/ch/resources/api/work-assignments/public-jobs/list?pageNum=0&pageSize=200") else {
            return Fail(outputType: JobResponse.self, failure: URLError(.badURL)).eraseToAnyPublisher()
        }

        return session.customDataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: JobResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
