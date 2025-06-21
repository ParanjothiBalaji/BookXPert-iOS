//
//  ImagePickerManager.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 20/06/25.
//


import UIKit

final class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    weak var delegate: ImagePickerManagerDelegate?
    private weak var presentingVC: UIViewController?

    init(presentingVC: UIViewController) {
        self.presentingVC = presentingVC
    }

    // MARK: - Public Methods for Custom UI

    func presentCamera() {
        presentImagePicker(sourceType: .camera)
    }

    func presentGallery() {
        presentImagePicker(sourceType: .photoLibrary)
    }

    // MARK: - Internal Picker Logic

    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
            print("Source type \(sourceType.rawValue) not available")
            return
        }

        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        presentingVC?.present(picker, animated: true)
    }

    // MARK: - UIImagePickerControllerDelegate

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        picker.dismiss(animated: true)

        if let image = info[.originalImage] as? UIImage {
            delegate?.didSelectImage(image)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

protocol ImagePickerManagerDelegate: AnyObject {
    func didSelectImage(_ image: UIImage)
}
