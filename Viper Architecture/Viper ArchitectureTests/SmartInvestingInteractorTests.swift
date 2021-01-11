//
//  SmartInvestingInteractorTests.swift
//  Viper ArchitectureTests
//
//  Created by Aylwing Olivas on 1/9/21.
//

import XCTest
@testable import Viper_Architecture

class SmartInvestingInteractorTests: XCTestCase {

    func test_SmartInvestingInteractor_invalid() throws {
        let mockInteractor: Interactor = SmartInvestingInteractor()
        let expect = expectation(description: "Should NOT serialize normally")

        mockInteractor.loadEntity(for: URL(fileURLWithPath: "")) { (result: Result<SmartInvesting>) in
            switch result {
                case .success: XCTFail()
                case .failure: expect.fulfill()
            }
        }

        waitForExpectations(timeout: 1.0)
    }

    func test_SmartInvestingInteractor_valid() throws {

        let mockInteractor: Interactor = SmartInvestingInteractor()
        let expect = expectation(description: "Should serialize normally")

        mockInteractor.loadEntity(for: Endpoint.localSmartInvestingArticlesData) { (result: Result<SmartInvesting>) in
            switch result {
                case .success: expect.fulfill()
                case .failure: XCTFail()
            }
        }

        waitForExpectations(timeout: 1.0)
    }

    func test_SmartInvestingInteractor_EntitiesOrder_valid() throws {

        let stubInteractor: Interactor = SmartInvestingInteractor()
        let expect = expectation(description: "Investment Entit")

        stubInteractor.loadEntity(for: Endpoint.localSmartInvestingArticlesData) { (result: Result<SmartInvesting>) in
            switch result {
                case .success(let entities):

                    let levels = entities.achievements.map { Int($0.level)! }
                    XCTAssertEqual(levels, [1, 2, 3])

                    let consecutiveLevels = levels.map { $0 - 1 }.dropFirst() == levels.dropLast()

                    if consecutiveLevels {
                        expect.fulfill()
                    }

                case .failure: XCTFail()
            }
        }

        waitForExpectations(timeout: 1.0)
    }
}
