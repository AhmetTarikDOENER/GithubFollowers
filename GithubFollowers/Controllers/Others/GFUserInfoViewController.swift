//
//  GFUserInfoViewController.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 17.10.2023.
//

import UIKit

class GFUserInfoViewController: UIViewController {

    var username: String!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneBtn
        
        GFNetworkManager.shared.getUserInfo(for: username) {
            [weak self] result in
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                self?.presentGFCustomAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    
    //MARK: - Private
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }

}
