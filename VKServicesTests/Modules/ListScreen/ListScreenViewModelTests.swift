//
//  ListScreenViewModelTests.swift
//  VKServicesTests
//
//  Created by Yana Dudareva on 19.02.2023.
//

import XCTest
@testable import VKServices

class ListScreenViewModelTests: XCTestCase {
    
    private var vm: ListScreenViewModel!
    private var networkManager: NetworkManagerMock!
    
    override func setUpWithError() throws {
        networkManager = NetworkManagerMock()
        vm = ListScreenViewModel()
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        vm = nil
        networkManager = nil
        try super.tearDownWithError()
    }
    
    func testApiSuccessResult() {

        //Given [Arrange]
        let data = Data()
        networkManager.performRequestResult = .success(data)

        //When [Act]
        vm.getData {
            XCTAssertEqual(data, data)
        }
    }
}

class NetworkManagerMock {
    
    fileprivate var performRequestResult: Result<Data, Error>?
    
    func fetchData(completion: @escaping () -> Void) {
        performRequest(urlString: "") { result in
            switch result {
            case .success(_):
                do {
                    completion()
                }
            case .failure(_):
                print("error")
            }
        }
    }
    
    private func performRequest(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        if let result = performRequestResult {
            completion(result)
        }
    }
}
