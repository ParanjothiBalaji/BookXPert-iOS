//
//  ObjectTableViewCell.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 20/06/25.
//

import UIKit
import Kingfisher

protocol ObjectTableViewCellDelegate: AnyObject {
    func didTapDelete(at index: Int)
    func didTapEdit(at index: Int)
    func didTapMoreDetails(at index: Int)
}

final class ObjectTableViewCell: UITableViewCell {
    
    static let identifier = "ObjectTableViewCell"
    
    weak var delegate: ObjectTableViewCellDelegate?
    private var index: Int?
    
    // MARK: - UI Elements
    
    private let productImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .lightGray.withAlphaComponent(0.3)
        return iv
    }()
    
    private let nameLabel = CustomLabelFactory.createLabel(
        text: "", font: .boldSystemFont(ofSize: 18), alignment: .center
    )
    
    private let idLabel = CustomLabelFactory.createLabel(
        text: "", font: .systemFont(ofSize: 14), color: .secondaryLabel, alignment: .center
    )
    
    private let moreDetailsButton = CustomLabelFactory.createLabel(
        text: "View More Details...", font: .systemFont(ofSize: 10), color: .systemCyan, alignment: .left
    )
    
    private let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
        button.tintColor = .systemGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash.circle.fill"), for: .normal)
        button.tintColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.systemGray3.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    func configure(with item: CDObjectItem, index: Int, delegate: ObjectTableViewCellDelegate) {
        self.index = index
        self.delegate = delegate
        nameLabel.text = item.name ?? "-"
        idLabel.text = "ID: \(item.id ?? "-")"
        
        let sampleImages = [
            "https://m.media-amazon.com/images/I/81vDZyJQ-4L._AC_SL1500_.jpg",
            "https://m.media-amazon.com/images/I/71ZDY57yTQL._AC_SL1500_.jpg"
        ]
        
        let imageUrlString = sampleImages[index % sampleImages.count]
        if let url = URL(string: imageUrlString) {
            productImageView.kf.setImage(
                with: url,
                placeholder: UIImage(systemName: "photo"),
                options: [
                    .transition(.fade(0.3)),
                    .cacheOriginalImage
                ]
            )
        }
    }
    
    
    // MARK: - Setup Views
    
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(productImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(idLabel)
        containerView.addSubview(moreDetailsButton)
        containerView.addSubview(editButton)
        containerView.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            productImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            productImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            productImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            productImageView.widthAnchor.constraint(equalToConstant: 60),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: editButton.leadingAnchor, constant: -8),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            idLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            idLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 12),
            idLabel.heightAnchor.constraint(equalToConstant: 20),
            
            moreDetailsButton.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 4),
            moreDetailsButton.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 12),
            moreDetailsButton.widthAnchor.constraint(equalToConstant: 150),
            moreDetailsButton.heightAnchor.constraint(equalToConstant: 20),
            
            editButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            editButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            editButton.widthAnchor.constraint(equalToConstant: 30),
            editButton.heightAnchor.constraint(equalToConstant: 30),
            
            deleteButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            deleteButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            deleteButton.widthAnchor.constraint(equalToConstant: 30),
            deleteButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        nameLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        editButton.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMoreDetails))
        moreDetailsButton.translatesAutoresizingMaskIntoConstraints = false
        moreDetailsButton.isUserInteractionEnabled = true
        moreDetailsButton.addGestureRecognizer(tapGesture)
        
    }
    
    // MARK: - Actions
    
    @objc private func handleDelete() {
        guard let index = index else { return }
        delegate?.didTapDelete(at: index)
    }
    
    @objc private func handleEdit() {
        guard let index = index else { return }
        delegate?.didTapEdit(at: index)
    }
    
    @objc private func handleMoreDetails() {
        guard let index = index else { return }
        delegate?.didTapMoreDetails(at: index)
    }
    
}
