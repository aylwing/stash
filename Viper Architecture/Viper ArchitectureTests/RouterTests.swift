//
//  RouterTests.swift
//  Viper ArchitectureTests
//
//  Created by Aylwing Olivas on 1/10/21.
//

import XCTest
import Combine
@testable import Viper_Architecture

class RouterTests: XCTestCase {

    func test_ScreenRouter() throws {

        let mockSubscriber = MockRouterSubscriber()
        XCTAssertNil(mockSubscriber.currentRoute)

        let stubInteractor: AppRouter = ScreenRouter()
        stubInteractor.subjectTransitions.subscribe(mockSubscriber)

        stubInteractor.start()
        XCTAssertEqual(mockSubscriber.currentRoute, .smartInvestingListView)

        stubInteractor.articleSelected()
        XCTAssertEqual(mockSubscriber.currentRoute, .showArticleImageView)
    }

}

final class MockRouterSubscriber: Subscriber {

    var currentRoute: Input?

    typealias Input = WireFrame
    typealias Failure = Error

    /// Subscriber is willing recieve unlimited values upon subscription
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }

    /// .none, indicating that the subscriber will not adjust its demand
    func receive(_ input: WireFrame) -> Subscribers.Demand {
        currentRoute = input
        return .none
    }

    /// Print the completion event
    func receive(completion: Subscribers.Completion<Error>) {
        print("Received completion", completion)
    }
}
