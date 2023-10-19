//
//  GFItemInfoViewController.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 19.10.2023.
//

import UIKit

class GFItemInfoViewController: UIViewController {

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    let firstItemInfoView = GFItemInfoView()
    let secondItemInfoView = GFItemInfoView()
    let actionButton = GFCustomButton()
    
    var user: GFUser!
    
    init(user: GFUser) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubViews(stackView, actionButton)
        stackView.addArrangedSubview(firstItemInfoView)
        stackView.addArrangedSubview(secondItemInfoView)
        configureBackgroundView()
        addConstraints()
    }
    
    
    //MARK: - Private
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func addConstraints() {
        let padding: CGFloat = 20
    
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }

}
