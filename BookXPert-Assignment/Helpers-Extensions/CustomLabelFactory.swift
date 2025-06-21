//
//  CustomLabelFactory.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 20/06/25.
//

import UIKit

final class CustomLabelFactory {
    
    static func createLabel(
        text: String,
        font: UIFont,
        color: UIColor = dynamicTextColor(),
        alignment: NSTextAlignment = .center,
        lines: Int = 1
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = color
        label.textAlignment = alignment
        label.numberOfLines = lines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private static func dynamicTextColor() -> UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .white : .black
        }
    }
}
