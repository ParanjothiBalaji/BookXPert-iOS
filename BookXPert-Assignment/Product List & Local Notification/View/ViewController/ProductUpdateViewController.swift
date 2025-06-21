//
//  ProductUpdateViewController.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 21/06/25.
//

import UIKit

final class ProductUpdateViewController: BaseViewController {
    
    private let item: CDObjectItem
    var onUpdate: ((CDObjectItem) -> Void)?
    
    private var nameField = CustomTextField(placeholder: "Name")
    private var colorField = CustomTextField(placeholder: "Color")
    private var priceField = CustomTextField(placeholder: "Price")
    
    private let stackView = UIStackView()
    
    init(item: CDObjectItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
        self.title = "Update Product"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavBar(title: "Edit Product")
        setupForm()
        populateFields()
    }
    
    private func setupForm() {
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Update Product", for: .normal)
        submitButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        
        view.addSubview(stackView)
        [nameField, colorField, priceField, submitButton].forEach { stackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 124),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func populateFields() {
        nameField.text = item.name
        colorField.text = item.color
        priceField.text = item.price > 0 ? "\(item.price)" : ""
    }
    
    @objc private func handleSubmit() {
        item.name = nameField.text
        item.color = colorField.text
        item.price = Double(priceField.text ?? "") ?? 0
        onUpdate?(item)
        let doneAlert = UIAlertController(title: "Success", message: "Update done successfully.", preferredStyle: .alert)
        doneAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.popVc()
        }))
        self.present(doneAlert, animated: true)
    }
    
}

extension ProductUpdateViewController: CustomNavigationBarDelegate {
    func didTapBack() {
        popVc()
    }
}
