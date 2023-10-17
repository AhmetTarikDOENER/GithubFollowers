//
//  GFCustomAlertViewController.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 13.10.2023.
//

import UIKit

final class GFCustomAlertViewController: UIViewController {

    private let containerView = UIView()
    private let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    private let errorMessageLabel = GFBodyLabel(textAlignment: .center)
    private let errorActionButton = GFCustomButton(backgroundColor: .systemPink, title: "OK")
    
    public let padding: CGFloat = 20
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    //MARK: - Init
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubViews(containerView)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureBodyLabel()
        addConstraints()
    }
    
    
    //MARK: - Private
    
    private func configureContainerView() {
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong!"
    }
    
    private func configureActionButton() {
        containerView.addSubview(errorActionButton)
        errorActionButton.setTitle(buttonTitle ?? "OK", for: .normal)
        errorActionButton.addTarget(self, action: #selector(dismissCustomAlert), for: .touchUpInside)
    }
    
    private func configureBodyLabel() {
        containerView.addSubview(errorMessageLabel)
        errorMessageLabel.text = message ?? "Unable to complete request."
        errorMessageLabel.numberOfLines = 4
    }
    
    @objc private func dismissCustomAlert() {
        dismiss(animated: true)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            errorActionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            errorActionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            errorActionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            errorActionButton.heightAnchor.constraint(equalToConstant: 44),
            
            errorMessageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            errorMessageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            errorMessageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            errorMessageLabel.bottomAnchor.constraint(equalTo: errorActionButton.topAnchor, constant: -12)
        ])
    }
}
