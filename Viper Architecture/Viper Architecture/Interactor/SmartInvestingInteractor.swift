//
//  SmartInvestingInteractor.swift
//  Viper Architecture
//
//  Created by Aylwing Olivas on 1/9/21.
//

import Foundation

final class SmartInvestingInteractor: Interactor {

    private var cache = NSCache<NSURL, SmartInvesting>()

    func loadSmartInvestingEntity(for endpoint: Endpoint, completion: @escaping (Result<SmartInvesting>) -> Void) {

        if let entity = cache.object(forKey: endpoint.url as NSURL) {
            completion(.success(entity))
        } else {

            loadEntity(for: Endpoint.localSmartInvestingArticlesData) { [weak self] (result: Result<SmartInvesting>) in

                switch result {

                    case .success(let entity):
                        entity.achievements.sort { $0.level < $1.level }
                        self?.cache.setObject(entity, forKey: endpoint.url as NSURL)
                        completion(.success(entity))

                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        }
    }
}
