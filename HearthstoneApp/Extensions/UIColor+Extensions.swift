//
//  UIColor+Extensions.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 12/12/23.
//

import UIKit

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red: .random(in: 0...0.58),
            green: .random(in: 0...0.58),
            blue: .random(in: 0...0.58), alpha: 1
        )
    }
}
