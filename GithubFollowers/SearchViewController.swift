//
//  SearchViewController.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 11.10.2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let githubImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "gh-logo")
        
        return imageView
    }()
    
    private let usernameTextField: GFCustomTextField = {
        let textField = GFCustomTextField()
        return textField
    }()
    
    private let customActionButton = GFCustomButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubViews(githubImageView, usernameTextField, customActionButton)
        addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    
    //MARK: - Private
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            githubImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            githubImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            githubImageView.heightAnchor.constraint(equalToConstant: 200),
            githubImageView.widthAnchor.constraint(equalToConstant: 200),
            
            usernameTextField.topAnchor.constraint(equalTo: githubImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            customActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            customActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            customActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            customActionButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}
