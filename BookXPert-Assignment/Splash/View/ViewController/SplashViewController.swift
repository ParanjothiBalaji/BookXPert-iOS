//
//  SplashViewController.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 20/06/25.
//

import UIKit

final class SplashViewController: UIViewController {

    private let viewModel = SplashViewModel()
    private let logoView = SplashLogoView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.delegate = self
        setupLogo()
        viewModel.startSplashTimer()
    }

    private func setupLogo() {
        view.addSubview(logoView)
        logoView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoView.widthAnchor.constraint(equalToConstant: 150),
            logoView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}

// MARK: - ViewModel Delegate

extension SplashViewController: SplashViewModelDelegate {
    func didFinishSplash() {
        let loginVC = LoginViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
}
