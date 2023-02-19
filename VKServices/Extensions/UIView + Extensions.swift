//
//  UIView + Extensions.swift
//  VKServices
//
//  Created by Yana Dudareva on 19.02.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach(addSubview(_:))
    }
}
