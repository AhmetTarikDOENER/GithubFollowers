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
        print(username!)
    }
    
    
    //MARK: - Private
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }

}
