//
//  HomeOptionCell.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 20/06/25.
//

import UIKit

final class HomeOptionCell: UICollectionViewCell {
    
    static let identifier = "HomeOptionCell"
    
    private let iconView = UIImageView()
    private let titleLabel: UILabel = CustomLabelFactory.createLabel(
        text: "",
        font: .boldSystemFont(ofSize: 20),
        alignment: .left
    )
    
    private let subtitleLabel: UILabel = CustomLabelFactory.createLabel(
        text: "",
        font: .systemFont(ofSize: 14),
        color: UIColor { trait in
            trait.userInterfaceStyle == .dark
            ? UIColor.white.withAlphaComponent(0.8)
            : UIColor.black.withAlphaComponent(0.6)
        },
        alignment: .left
    )
    
    private let card = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with option: HomeOption) {
        iconView.image = UIImage(systemName: option.icon)
        iconView.tintColor = .white
        titleLabel.text = option.title
        subtitleLabel.text = option.subtitle
        card.backgroundColor = option.color
    }
    
    private func setup() {
        card.layer.cornerRadius = 20
        card.clipsToBounds = true
        card.translatesAutoresizingMaskIntoConstraints = false
        
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        card.addSubview(iconView)
        card.addSubview(titleLabel)
        card.addSubview(subtitleLabel)
        contentView.addSubview(card)
        
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: contentView.topAnchor),
            card.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            card.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            card.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            iconView.topAnchor.constraint(equalTo: card.topAnchor, constant: 20),
            iconView.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 20),
            iconView.widthAnchor.constraint(equalToConstant: 32),
            iconView.heightAnchor.constraint(equalToConstant: 32),
            
            titleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: iconView.leadingAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: card.trailingAnchor, constant: -20)
        ])
    }
}

