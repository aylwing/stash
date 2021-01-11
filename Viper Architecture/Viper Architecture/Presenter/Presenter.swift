//
//  Presenter.swift
//  Viper Architecture
//
//  Created by Aylwing Olivas on 1/9/21.
//

import UIKit
import Combine

// Could have made a protocol to work with abstract objects as Presenters - but currently it seems the navigation can function with one presenter

final class Presenter: UINavigationController {

    // If variable is made public it can be tested and swapped out for other implementations of protocols
    // But I opted to test directly. Currently this is motly UI Logic here i.e UINavigation pushes

    private let interactor = SmartInvestingInteractor()
    private let router: AppRouter = ScreenRouter()

    private var selectedArticle: Achievement?

    private lazy var smartInvestingCollectionViewController: SmartInvestingCollectionViewController = {
        let smartInvestingCollectionViewController = SmartInvestingCollectionViewController()
        interactor.loadSmartInvestingEntity(for: .localSmartInvestingArticlesData) { [unowned self] (entity: Result<SmartInvesting>) in

            // With ViewError pattern - we could have presenter here present the error to the view layer
            // For now ignoring decoding error since it's being fed from a local file URL.

            guard case let .success(investmentItem) = entity else { return }
            smartInvestingCollectionViewController.smartInvestingEntity = investmentItem
        }

        smartInvestingCollectionViewController.presenter = self
        return smartInvestingCollectionViewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        router.subjectTransitions.subscribe(self)
        router.start()
    }

    private func present(currentRoute: WireFrame) {
        switch currentRoute {
            case .smartInvestingListView: pushViewController(smartInvestingCollectionViewController, animated: false)
            case .showArticleImageView: pushViewController(FullScreenImageViewController(imageURL: selectedArticle?.bg_image_url ?? ""), animated: true)
        }
    }

    // "Where there is an if statement, you can have a Unit Test"
    // This area here can be tested but I feel is covered with other tests
    func selected(article: Achievement) {
        selectedArticle = article
        router.articleSelected()
    }
}

extension Presenter: Subscriber {

    typealias Input = WireFrame
    typealias Failure = Error

    /// Subscriber is willing recieve unlimited values upon subscription
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }

    /// .none, indicating that the subscriber will not adjust its demand
    func receive(_ input: WireFrame) -> Subscribers.Demand {
        present(currentRoute: input)
        return .none
    }

    /// Print the completion event
    func receive(completion: Subscribers.Completion<Error>) {
        print("Received completion", completion)
    }
}
