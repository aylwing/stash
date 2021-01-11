//
//  SmartInvestingInteractorTests.swift
//  Viper ArchitectureTests
//
//  Created by Aylwing Olivas on 1/9/21.
//

import XCTest
@testable import Viper_Architecture

class SmartInvestingInteractorTests: XCTestCase {

    func test_SmartInvestingInteractor_valid() throws {

        let mockInteractor = SmartInvestingInteractor()
        mockInteractor.loadEntity(for: Endpoint.localSmartInvestingArticlesData) { (result: SmartInvesting) in

            switch result {
                case
            }
        }

        let localURL = Endpoint.localSmartInvestingArticlesData.url
        let apiManager = APIManager<SmartInvesting>()
        apiManager.loadEntity(for: localURL) { result in
            <#code#>
        }
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
