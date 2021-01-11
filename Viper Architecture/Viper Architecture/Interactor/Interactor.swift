//
//  Interactor.swift
//  Viper Architecture
//
//  Created by Aylwing Olivas on 1/9/21.
//

import Foundation
import Combine

protocol Interactor {
    func loadEntity<S: URLRepresentable, E: Decodable>(for source: S, completion: @escaping (Result<E>) -> Void)
}

extension Interactor {

    func loadEntity<S: URLRepresentable, E: Decodable>(for source: S, completion: @escaping (Result<E>) -> Void) {

        // If previously fetched return that same data
        // Sample of business logic, can also be done with other persistance layers (CoreData etc.)
        // Early return function can exist here

        let builder = APIManager<E>()
        builder.loadEntity(for: source.url) { result in

            switch result {

                case .success(let entity):
                    // Can perform checks to see if data is old or any other business logic here within Interactor
                    // This case is just loading can return to completionBlock
                    completion(.success(entity))

                case .failure(let error):
                    /*

                     Here we can follow a VieweError pattern
                     Where api/local errors can get mapped and converted to a ViewError that get's bubbled to the view layer
                     and shown to the user with language or context they might understand can also be localized

                     */
                    completion(.failure(error))
                    debugPrint(error as Any)
            }
        }
    }
}
