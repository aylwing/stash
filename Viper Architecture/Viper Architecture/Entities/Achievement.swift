//
//  Achievement.swift
//  Viper Architecture
//
//  Created by Aylwing Olivas on 1/9/21.
//

import Foundation

struct Achievement: Codable {
    let id: Int
    let level: String
    let progress: Int
    let total: Int
    let bg_image_url: String
    let accessible: Bool
}

extension Achievement: Hashable {

    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }

    static func == (lhs: Achievement, rhs: Achievement) -> Bool {
      lhs.id == rhs.id
    }
}
