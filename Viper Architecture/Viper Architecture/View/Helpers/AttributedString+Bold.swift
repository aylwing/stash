//
//  AttributedString+Bold.swift
//  Viper Architecture
//
//  Created by Aylwing Olivas on 1/10/21.
//

import Foundation

import UIKit

extension NSMutableAttributedString {

    // No Unit Test needed for this
    // This can be interpreted as UI logic
    // Perhaps a UI Unit Test?

    @discardableResult func bold(_ text: String, size: CGFloat, weight: CGFloat = UIFont.Weight.medium.rawValue) -> NSMutableAttributedString {
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size, weight: UIFont.Weight(rawValue: weight))]
        let boldString = NSMutableAttributedString(string: text, attributes: attributes)
        self.append(boldString)
        return self
    }

    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal =  NSAttributedString(string: text)
        self.append(normal)
        return self
    }
}
