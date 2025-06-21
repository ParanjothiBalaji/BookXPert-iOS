//
//  ProductDetailsViewController.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 21/06/25.
//

import UIKit
import Kingfisher

final class ProductDetailsViewController: BaseViewController {
    
    private let item: CDObjectItem
    
    init(item: CDObjectItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
        self.title = "Product Details"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let scrollView = UIScrollView()
    private let contentView = UIStackView()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupScrollView()
        configureNavBar(title: "Prducts Dertails")
        configureData()
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.axis = .vertical
        contentView.spacing = 16
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
        
        contentView.addArrangedSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    private func configureData() {
        let sampleImages = [
            "https://m.media-amazon.com/images/I/81vDZyJQ-4L._AC_SL1500_.jpg",
            "https://m.media-amazon.com/images/I/71ZDY57yTQL._AC_SL1500_.jpg"
        ]
        
        if !sampleImages.isEmpty {
            let hash = abs(item.id?.hashValue ?? 0)
            let index = hash % sampleImages.count
            let imageUrl = sampleImages[index]
            if let url = URL(string: imageUrl) {
                imageView.kf.setImage(with: url)
            }
        }
        
        addDetailRow("ID", item.id)
        addDetailRow("Name", item.name)
        addDetailRow("Color", item.color)
        addDetailRow("Capacity", item.capacity)
        addDetailRow("Capacity GB", item.capacityGB != 0 ? "\(item.capacityGB) GB" : nil)
        addDetailRow("Price", item.price != 0 ? "₹ \(item.price)" : nil)
        addDetailRow("Generation", item.generation)
        addDetailRow("Year", item.year != 0 ? "\(item.year)" : nil)
        addDetailRow("CPU Model", item.cpuModel)
        addDetailRow("Hard Disk Size", item.hardDiskSize)
        addDetailRow("Strap Colour", item.strapColour)
        addDetailRow("Case Size", item.caseSize)
        addDetailRow("Screen Size", item.screenSize != 0 ? "\(item.screenSize) inch" : nil)
        addDetailRow("Description", item.description)
    }
    
    
    private func addDetailRow(_ title: String, _ value: Any?) {
        guard let value = value else { return }
        
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 4
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.textColor = .secondaryLabel
        
        let valueLabel = UILabel()
        valueLabel.text = "\(value)"
        valueLabel.font = .systemFont(ofSize: 16)
        valueLabel.numberOfLines = 0
        valueLabel.textColor = .label
        
        container.addArrangedSubview(titleLabel)
        container.addArrangedSubview(valueLabel)
        
        contentView.addArrangedSubview(container)
    }
    
    
}

extension ProductDetailsViewController : CustomNavigationBarDelegate {
    func didTapBack() {
        popVc()
    }
}
