//
//  GFUserInfoViewController.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 17.10.2023.
//

import UIKit

final class GFUserInfoViewController: UIViewController {

    var username: String!
    private var itemViews: [UIView] = []
    private let padding: CGFloat = 12
    private let itemHeight: CGFloat = 140
    
    private let headerView = UIView()
    private let firstItemView = UIView()
    private let secondItemView = UIView()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureViewController()
        view.addSubViews(headerView, firstItemView, secondItemView)
        addConstraints()
        getUserInfo()
    }
    
    
    //MARK: - Private
    
    private func configureViewController() {
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneBtn
    }
    
    private func getUserInfo() {
        GFNetworkManager.shared.getUserInfo(for: username) {
            [weak self] result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self?.add(childVC: GFUserHeaderViewController(user: user), to: self!.headerView)
                    self?.add(childVC: GFItemPRepoViewController(user: user), to: self!.firstItemView)
                    self?.add(childVC: GFFollowersItemViewController(user: user), to: self!.secondItemView)
                }
            case .failure(let error):
                self?.presentGFCustomAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    private func addConstraints() {
        itemViews = [headerView, firstItemView, secondItemView]
        for itemView in itemViews {
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }
        
        headerView.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            firstItemView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            firstItemView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            secondItemView.topAnchor.constraint(equalTo: firstItemView.bottomAnchor, constant: padding),
            secondItemView.heightAnchor.constraint(equalToConstant: itemHeight),
        ])
    }

}
