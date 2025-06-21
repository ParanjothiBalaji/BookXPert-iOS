//
//  ImagePickerViewModel.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 20/06/25.
//

import UIKit

final class ImagePickerViewModel {
    weak var delegate: ImagePickerViewModelDelegate?

    func processSelectedImage(_ image: UIImage) {
        delegate?.didUpdateImage(image)
    }
}

protocol ImagePickerViewModelDelegate: AnyObject {
    func didUpdateImage(_ image: UIImage)
}
