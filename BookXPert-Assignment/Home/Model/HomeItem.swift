//
//  HomeItem.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 20/06/25.
//

import UIKit

struct HomeItem {
    let title: String
    let iconName: String
    let gradientColors: [UIColor]
    let actionType: HomeActionType
}

enum HomeActionType {
    case openPDFViewer
    case openImagePicker
    case openObjectList
}

struct HomeOption {
    let title: String
    let subtitle: String
    let icon: String
    let color: UIColor
}
