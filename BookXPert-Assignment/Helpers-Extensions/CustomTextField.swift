//
//  CustomTextField.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 21/06/25.
//

import UIKit

final class CustomTextField: UITextField {
    init(placeholder: String) {
        super.init(frame: .zero)
        borderStyle = .roundedRect
        font = .systemFont(ofSize: 16)
        self.placeholder = placeholder
        self.clearButtonMode = .whileEditing
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
