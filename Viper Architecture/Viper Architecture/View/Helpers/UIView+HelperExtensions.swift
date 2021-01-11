//
//  UIView+HelperExtensions.swift
//  Viper Architecture
//
//  Created by Aylwing Olivas on 1/10/21.
//

import UIKit

extension UIView {

    /// Adds a view as a subview and constrains it to the edges
    ///
    /// - Parameter subview: view to add as subview and constrain
    internal func addSubViewWithFillConstraints(_ subview: UIView, margin: CGFloat = 0) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false

        subview.topAnchor.constraint(equalTo: topAnchor, constant: margin).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin).isActive = true
        subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
        subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
    }
}

@IBDesignable extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}
