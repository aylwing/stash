//
//  SmartInvesting.swift
//  Viper Architecture
//
//  Created by Aylwing Olivas on 1/9/21.
//

import Foundation

final class SmartInvesting: Codable {
    let success: Bool
    let status: Int
    let overview: Overview
    var achievements: [Achievement]
}
