//
//  ImagePickerViewController.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 20/06/25.
//

import UIKit

final class ImagePickerViewController: BaseViewController {
    
    private let viewModel = ImagePickerViewModel()
    private var imagePickerManager: ImagePickerManager?
    
    private let selectedImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .secondarySystemBackground
        iv.layer.cornerRadius = 20
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var cameraOption = ImageSelectionOptionView(
        icon: UIImage(systemName: "camera"),
        title: "Camera",
        bgColor: .systemBlue
    )
    
    private lazy var galleryOption = ImageSelectionOptionView(
        icon: UIImage(systemName: "photo"),
        title: "Gallery",
        bgColor: .systemGreen
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.delegate = self
        imagePickerManager = ImagePickerManager(presentingVC: self)
        imagePickerManager?.delegate = self
        configureNavBar(title: "Choose Image Source")
        setupUI()
        setupTapGestures()
    }
    
    private func setupUI() {
        view.addSubview(cameraOption)
        view.addSubview(galleryOption)
        view.addSubview(selectedImageView)
        
        NSLayoutConstraint.activate([
            
            cameraOption.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            cameraOption.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            cameraOption.widthAnchor.constraint(equalToConstant: 140),
            cameraOption.heightAnchor.constraint(equalToConstant: 120),
            
            galleryOption.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            galleryOption.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            galleryOption.widthAnchor.constraint(equalToConstant: 140),
            galleryOption.heightAnchor.constraint(equalToConstant: 120),
            
            selectedImageView.topAnchor.constraint(equalTo: cameraOption.bottomAnchor, constant: 40),
            selectedImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            selectedImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            selectedImageView.heightAnchor.constraint(equalToConstant: 260)
        ])
    }
    
    private func setupTapGestures() {
        let cameraTap = UITapGestureRecognizer(target: self, action: #selector(didTapCamera))
        cameraOption.addGestureRecognizer(cameraTap)
        
        let galleryTap = UITapGestureRecognizer(target: self, action: #selector(didTapGallery))
        galleryOption.addGestureRecognizer(galleryTap)
    }
    
    @objc private func didTapCamera() {
        imagePickerManager?.presentCamera()
    }
    
    @objc private func didTapGallery() {
        imagePickerManager?.presentGallery()
    }
}

extension ImagePickerViewController: ImagePickerViewModelDelegate {
    func didUpdateImage(_ image: UIImage) {
        selectedImageView.image = image
    }
}

extension ImagePickerViewController: ImagePickerManagerDelegate {
    func didSelectImage(_ image: UIImage) {
        viewModel.processSelectedImage(image)
    }
}

extension ImagePickerViewController: CustomNavigationBarDelegate {
    func didTapBack() {
        popVc()
    }
}
