//
//  UITableViewCell + Extensions.swift
//  VKServices
//
//  Created by Yana Dudareva on 19.02.2023.
//

import UIKit

protocol ReusableViewProtocol: AnyObject {}

extension ReusableViewProtocol where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableViewProtocol {}
