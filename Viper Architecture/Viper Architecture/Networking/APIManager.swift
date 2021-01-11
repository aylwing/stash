//
//  Builder.swift
//  Viper Architecture
//
//  Created by Aylwing Olivas on 1/9/21.
//

import Foundation
import Combine

enum Result<T> {
    case success(T)
    case failure(Error?)
}

final class APIManager<T: Decodable> {

    func loadEntity(for url: URL, completion: @escaping (Result<T>) -> Void) {

        // URLSession data transfer tasks, exposes a Combine publisher.
        // But in this case for this simple task this is much cleaner than setting up a publisher
        // One exception where it would not be cleaner is when having to publish/notify network data to multiple subscribers

        /* Example Combine decoder

         let subscription = URLSession.shared.dataTaskPublisher(for: url)
         .tryMap { data, _ in try JSONDecoder().decode(T.self, from: data) }
         .sink(receiveCompletion: { completion in if case .failure(let err) = completion {
            print("Retrieving data failed with error \(err)")
             }
           }, receiveValue: { object in
             print("Retrieved object \(object)")
         })

         when using Codable can also replace the tryMap operator with the following lines:

         .map(\.data)
         .decode(type: T.self, decoder: JSONDecoder())

        */

        URLSession.shared.dataTask(with: url) { data, response, error in

            let decoder = JSONDecoder()

            guard
                let entityData = data,
                let decodedEntity = try? decoder.decode(T.self, from: entityData), error == nil else {
                completion(.failure(error))
                return
            }

            completion(.success(decodedEntity))

        }.resume()
    }
}
