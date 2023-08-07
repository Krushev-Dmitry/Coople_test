//
//  NetworkManagerTests.swift
//  Coople_KrushevTests
//
//  Created by Krushev on 8/5/23.
//

import XCTest
import Combine
import Foundation
@testable import Coople_Krushev

class MockURLSession: URLSessionProtocol {
    var data: Data?
    var error: URLError?
    
    func customDataTaskPublisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        if let error = self.error {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        guard let data = self.data,
              let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) else {
            return Fail(error: URLError(.unknown)).eraseToAnyPublisher()
        }
        
        return Just((data: data, response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
    }
}


final class NetworkManagerTests: XCTestCase {
    var subscriptions: Set<AnyCancellable> = []
    
    func testGetJobsSuccess() {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "JobsResponse", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            XCTFail("Missing or unable to read file: JobsResponse.json")
            return
        }

        let mockSession = MockURLSession()
        mockSession.data = data
        let networkManager = NetworkManager(session: mockSession)

        let expectation = self.expectation(description: "Get Jobs Success")

        networkManager.getJobs()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Expected success but got \(error)")
                }
            }, receiveValue: { jobResponse in
                XCTAssertNotNil(jobResponse, "JobResponse should not be nil.")
                guard let items = jobResponse.data?.items else {
                    XCTFail("Items in JobResponse should not be nil.")
                    return
                }
                XCTAssertEqual(items.count, 3, "Items count should be 3.")
                expectation.fulfill()
            })
            .store(in: &subscriptions)

        waitForExpectations(timeout: 5)
    }
}
