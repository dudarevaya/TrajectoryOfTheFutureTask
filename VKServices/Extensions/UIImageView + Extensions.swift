//
//  UIImageView + Extensions.swift
//  VKServices
//
//  Created by Yana Dudareva on 18.02.2023.
//

import UIKit

extension UIImageView {
    func load(url: String) {
        guard let url = URL(string: url) else {
            print("Failed to load image")
            return
        }
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
