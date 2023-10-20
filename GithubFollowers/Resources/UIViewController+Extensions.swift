//
//  Extensions.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 12.10.2023.
//

import UIKit
import SafariServices

extension UIView {
    func addSubViews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}

extension UIViewController {
    
    func presentGFCustomAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertViewController = GFCustomAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            alertViewController.modalPresentationStyle = .overFullScreen
            alertViewController.modalTransitionStyle = .crossDissolve
            self.present(alertViewController, animated: true)
        }
    }
    
    func presentSafariViewController(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}
