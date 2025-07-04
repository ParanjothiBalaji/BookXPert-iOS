
//
//  GoogleSignInButtonViewDelegate.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 19/06/25.
//

import UIKit

class GoogleSignInButtonView: UIView {
    
    weak var delegate: GoogleSignInButtonViewDelegate?
    
    // MARK: - Views
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let googleIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "GoogleIcon-png")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        return imageView
    }()
    
    
    private let signInLabel = CustomLabelFactory.createLabel(
        text: "Sign in with Google",
        font: .systemFont(ofSize: 18, weight: .medium)
    )
    
    private lazy var signInStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [googleIconImageView, signInLabel])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let transparentButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        transparentButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout & Gradient
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradient()
    }
    
    private func applyGradient() {
        containerView.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.white.cgColor,
            UIColor.systemCyan.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.cornerRadius = 25
        gradient.frame = containerView.bounds
        containerView.layer.insertSublayer(gradient, at: 0)
    }
    
    // MARK: - Setup
    
    private func setupLayout() {
        addSubview(containerView)
        containerView.addSubview(signInStack)
        containerView.addSubview(transparentButton)
        
        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 56),
            containerView.widthAnchor.constraint(equalToConstant: 260),
            
            signInStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            signInStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            transparentButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            transparentButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            transparentButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            transparentButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    // MARK: - Action
    
    @objc private func handleTap() {
        delegate?.didTapGoogleSignIn()
    }
}

protocol GoogleSignInButtonViewDelegate: AnyObject {
    func didTapGoogleSignIn()
}
