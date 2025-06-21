//
//  HomeItemManager.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 20/06/25.
//

import UIKit

final class HomeItemManager {
    
    func fetchHomeItems() -> [HomeItem] {
        return [
            HomeItem(
                title: "Report (PDF Viewer)",
                iconName: "doc.text",
                gradientColors: [UIColor.systemPurple, UIColor.systemBlue],
                actionType: .openPDFViewer
            ),
            HomeItem(
                title: "Image Picker",
                iconName: "camera.viewfinder",
                gradientColors: [UIColor.systemGreen, UIColor.systemTeal],
                actionType: .openImagePicker
            ),
            HomeItem(
                title: "Object List & Notifications",
                iconName: "tray.full",
                gradientColors: [UIColor.systemOrange, UIColor.systemRed],
                actionType: .openObjectList
            )
        ]
    }
}
