//
//  SearchViewController.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 11.10.2023.
//

import UIKit

/// Search Screen Controller
final class GFSearchViewController: UIViewController {
    
    private let githubImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Images.githubLogo
        
        return imageView
    }()
    
    private let usernameTextField: GFCustomTextField = {
        let textField = GFCustomTextField()
        return textField
    }()
    
    private let customActionButton = GFCustomButton(color: .systemGreen, title: "Search For Followers", systemImageName: "person.3")
    
    var isUsernameTyped: Bool {
        return !usernameTextField.text!.isEmpty
    }
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubViews(githubImageView, usernameTextField, customActionButton)
        addConstraints()
        customActionButton.addTarget(self, action: #selector(didTapSearchFollowersButton), for: .touchUpInside)
        dismissKeyboard()
        textFieldDelegation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    //MARK: - Private
    
    private func addConstraints() {
        let topConstraintConstant: CGFloat = DeviceTypes.isIphoneSE || DeviceTypes.isIphone8Zoomed ? 20 : 80
        
        NSLayoutConstraint.activate([
            githubImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: topConstraintConstant),
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
    
    @objc private func didTapSearchFollowersButton() {
        guard isUsernameTyped else { 
            presentGFCustomAlert(title: "Empty Username", message: "Please enter a username", buttonTitle: "OK")
            return
        }
        
        usernameTextField.resignFirstResponder()
        
        let followersListVC = GFFollowersListViewController(username: usernameTextField.text!)
        navigationController?.pushViewController(followersListVC, animated: true)
    }
    
    private func textFieldDelegation() {
        usernameTextField.delegate = self
    }
    
    private func dismissKeyboard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
}

extension GFSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didTapSearchFollowersButton()
        return true
    }
}
