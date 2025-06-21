//
//  LoginViewController.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 19/06/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let viewModel = LoginViewModel()
    private let signInButton = GoogleSignInButtonView()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let welcomeLabel = CustomLabelFactory.createLabel(
        text: "Welcome to BookXPert",
        font: .systemFont(ofSize: 28, weight: .bold)
    )
    
    private let descriptionLabel = CustomLabelFactory.createLabel(
        text: "Simplify your accounting reports\nwith instant access to balance sheets.",
        font: .systemFont(ofSize: 16, weight: .regular),
        color: .secondaryLabel,
        lines: 0
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.delegate = self
        setupLayout()
        bindActions()
    }
    
    private func setupLayout() {
        view.addSubview(logoImageView)
        view.addSubview(welcomeLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(signInButton)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            logoImageView.heightAnchor.constraint(equalToConstant: 120),
            
            welcomeLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 24),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            descriptionLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 25),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            signInButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 60),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.widthAnchor.constraint(equalToConstant: 260),
            signInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    private func bindActions() {
        signInButton.transparentButton.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
    }
    
    @objc private func handleSignIn() {
        viewModel.signInWithGoogle(from: self)
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func didLoginSuccessfully() {
        let pdfVC = HomeViewController()
        navigationController?.pushViewController(pdfVC, animated: true)
    }
    
    func didFailToLogin(with error: Error) {
        let alert = UIAlertController(title: "Login Failed", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

protocol LoginViewModelDelegate: AnyObject {
    func didLoginSuccessfully()
    func didFailToLogin(with error: Error)
}
