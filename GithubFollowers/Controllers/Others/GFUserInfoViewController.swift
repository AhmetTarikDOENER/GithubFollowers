//
//  GFUserInfoViewController.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 17.10.2023.
//

import UIKit

protocol GFUserInfoViewControllerDelegate: AnyObject {
    func gfDidRequestFollowers(for username: String)
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
    
    weak var delegate: GFUserInfoViewControllerDelegate?
    
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
        Task {
            do {
                let user = try await GFNetworkManager.shared.getUserInfo(for: username)
                configureUIElements(with: user)
            } catch {
                if let gfError = error as? GFError {
                    presentGFCustomAlert(title: "Something went wrong.", message: gfError.rawValue, buttonTitle: "OK")
                } else {
                    presentDefaultError()
                }
            }
        }
    }
    
    private func configureUIElements(with user: GFUser) {
        self.add(childVC: GFUserHeaderViewController(user: user), to: self.headerView)
        self.add(childVC: GFItemPRepoViewController(user: user, delegate: self), to: self.firstItemView)
        self.add(childVC: GFFollowersItemViewController(user: user, delegate: self), to: self.secondItemView)
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
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            firstItemView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            firstItemView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            secondItemView.topAnchor.constraint(equalTo: firstItemView.bottomAnchor, constant: padding),
            secondItemView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: secondItemView.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

extension GFUserInfoViewController: GFRepoItemInfoViewControllerDelegate {
    
    func gfDidTapGithubProfile(for user: GFUser) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFCustomAlert(title: "Invalid URL", message: "Invalid URL attached to this user", buttonTitle: "OK")
            return
        }
        presentSafariViewController(with: url)
    }

}

extension GFUserInfoViewController: GFFollowersItemInfoViewControllerDelegate {
    
    func gfDidTapGetFollowers(for user: GFUser) {
        delegate?.gfDidRequestFollowers(for: user.login)
        dismissViewController()
    }
}
