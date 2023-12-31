//
//  UIViewController+Extensionsa.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 05/12/23.
//

import UIKit

extension UIViewController {
    func disableView() {
        view.isUserInteractionEnabled = false
        view.alpha = 0.5
    }
    
    func setNavigationTitle(_ title: String) {
        navigationItem.title = title
    }
    
    func hideNavigationBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "")
    }
    
    func enableView() {
        view.isUserInteractionEnabled = true
        view.alpha = 1
    }
    
    func hideNavigationBar(isAnimatig: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: isAnimatig)
    }
    
    func showNavigationBar(isAnimatig: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: isAnimatig)
    }
    
    func showAlert(title: String = "",
                   message: String = "",
                   actionTitle: String = "OK",
                   completion: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { [weak self] _  in
            guard self != nil else { return }
            completion?()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func hideKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
