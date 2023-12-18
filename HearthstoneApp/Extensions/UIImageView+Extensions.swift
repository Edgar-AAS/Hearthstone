//
//  UIImageView+Extensions.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 08/12/23.
//

import UIKit

extension UIImageView {
    func downloadImageWith(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData)
                    self.image = image
                }
            }
        }
    }
}
