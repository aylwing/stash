//
//  AppRouter.swift
//  Viper Architecture
//
//  Created by Aylwing Olivas on 1/9/21.
//

import Combine

enum WireFrame {
    case smartInvestingListView, showArticleImageView
}

protocol AppRouter {
    var subjectTransitions: PassthroughSubject<WireFrame, Error> { get }
    func start()
    func articleSelected()
}

final class ScreenRouter: AppRouter {
    let subjectTransitions = PassthroughSubject<WireFrame, Error>()

    func start() {
        subjectTransitions.send(.smartInvestingListView)
    }

    func articleSelected() {
        subjectTransitions.send(.showArticleImageView)
    }
}

