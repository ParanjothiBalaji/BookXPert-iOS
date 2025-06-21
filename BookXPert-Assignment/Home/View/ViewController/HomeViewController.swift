//
//  HomeViewController.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 20/06/25.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    private let options: [HomeOption] = [
        HomeOption(title: "📄 Report Viewer", subtitle: "View your PDFs", icon: "doc.richtext", color: .systemBlue.withAlphaComponent(0.5)),
        HomeOption(title: "📸 Image Tools", subtitle: "Capture or pick images", icon: "camera.fill", color: .systemCyan.withAlphaComponent(0.75)),
        HomeOption(title: "📦 Object Manager", subtitle: "Manage and track items", icon: "tray.full.fill", color: .systemOrange.withAlphaComponent(0.25))
    ]
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 24
        layout.sectionInset = UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .systemBackground
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavBar(title: "Dashboard")
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeOptionCell.self, forCellWithReuseIdentifier: HomeOptionCell.identifier)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeOptionCell.identifier, for: indexPath) as? HomeOptionCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: options[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 32
        return CGSize(width: width, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            pushVc(viewController: PDFViewerViewController())
        case 1:
            pushVc(viewController: ImagePickerViewController())
        case 2:
            pushVc(viewController: ObjectListViewController())
        default: break
        }
    }
}

extension HomeViewController: CustomNavigationBarDelegate {
    func didTapBack() {
        popVc()
    }
}
