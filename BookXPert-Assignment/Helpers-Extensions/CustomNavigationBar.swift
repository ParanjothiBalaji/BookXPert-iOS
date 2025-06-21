//
//  CustomNavigationBar.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 20/06/25.
//

import UIKit

class CustomNavigationBar: UIView {
    
    weak var delegate: CustomNavigationBarDelegate?
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = CustomLabelFactory.createLabel(
        text: "",
        font: .boldSystemFont(ofSize: 18),
        color: .label,
        alignment: .left
    )
    
    private lazy var titleStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [logoImageView, titleLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(title: String, showsBackButton: Bool = true) {
        super.init(frame: .zero)
        titleLabel.text = title
        backButton.isHidden = !showsBackButton
        backgroundColor = .systemBackground
        setupLayout()
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(backButton)
        addSubview(titleStack)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 56),
            
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            logoImageView.widthAnchor.constraint(equalToConstant: 24),
            logoImageView.heightAnchor.constraint(equalToConstant: 24),
            
            titleStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    @objc private func backTapped() {
        delegate?.didTapBack()
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}

protocol CustomNavigationBarDelegate: AnyObject {
    func didTapBack()
}
