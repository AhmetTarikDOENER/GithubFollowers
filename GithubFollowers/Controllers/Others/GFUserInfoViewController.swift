//
//  GFUserInfoViewController.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 17.10.2023.
//

import UIKit

protocol GFUserInfoViewControllerDelegate: AnyObject {
    func gfDidTapGithubProfile(for user: GFUser)
    func gfDidTapGetFollowers(for user: GFUser)
}

final class GFUserInfoViewController: GFDataLoadingViewController {

    var username: String!
    
    private var itemViews: [UIView] = []
    private let padding: CGFloat = 12
    private let itemHeight: CGFloat = 140
    private let dateLabel = GFBodyLabel(textAlignment: .center)
    private let headerView = UIView()
    private let firstItemView = UIView()
    private let secondItemView = UIView()
    
    weak var delegate: GFFollowersListViewControllerDelegate?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureViewController()
        view.addSubViews(headerView, firstItemView, secondItemView, dateLabel)
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
                    self?.configureUIElements(with: user)
                }
            case .failure(let error):
                self?.presentGFCustomAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    private func configureUIElements(with user: GFUser) {
        let repoItemVC = GFItemPRepoViewController(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC = GFFollowersItemViewController(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: GFUserHeaderViewController(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.firstItemView)
        self.add(childVC: followerItemVC, to: self.secondItemView)
        self.dateLabel.text = "Github since, \(user.createdAt.convertToMonthYearFormat())"
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
        itemViews = [headerView, firstItemView, secondItemView, dateLabel]
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
            
            dateLabel.topAnchor.constraint(equalTo: secondItemView.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
}

extension GFUserInfoViewController: GFUserInfoViewControllerDelegate {
   
    func gfDidTapGithubProfile(for user: GFUser) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFCustomAlertOnMainThread(title: "Invalid URL", message: "Invalid URL attached to this user", buttonTitle: "OK")
            return
        }
        presentSafariViewController(with: url)
    }
    
    func gfDidTapGetFollowers(for user: GFUser) {
        delegate?.gfDidRequestFollowers(for: user.login)
        dismissViewController()
    }
}
