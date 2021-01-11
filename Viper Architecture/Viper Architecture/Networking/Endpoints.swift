//
//  Endpoints.swift
//  Viper Architecture
//
//  Created by Aylwing Olivas on 1/9/21.
//

import Foundation

protocol URLRepresentable {
    var url: URL { get }
}

extension URL: URLRepresentable {
    var url: URL { return self}
}

enum Endpoint: URLRepresentable {

    case localSmartInvestingArticlesData
    case remoteImage(URL)

    var url: URL {
        switch self {
            // Force unwrapped - should always exist otherwise something is wrong, IBOutlet style.
            case .localSmartInvestingArticlesData: return Bundle.main.url(forResource: "achievements", withExtension: "json")!
            case .remoteImage(let url): return url
        }
    }
}
