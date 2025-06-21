//
//  PDFViewerViewController.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 19/06/25.
//

import UIKit
import PDFKit

class PDFViewerViewController: BaseViewController {
    
    private let viewModel = PDFViewerViewModel()
    private var pdfView: PDFView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavBar(title: "Balance Sheet")
        setupPDFView()
        loadPDF()
    }
    
    // MARK: - Setup UI
    
    private func setupPDFView() {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .secondarySystemBackground
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        containerView.layer.shadowRadius = 6
        view.addSubview(containerView)
        
        pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(pdfView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            
            pdfView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            pdfView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            pdfView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            pdfView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    // MARK: - Load PDF
    
    private func loadPDF() {
        showCustomLoader()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.viewModel.loadPDF { [weak self] result in
                DispatchQueue.main.async {
                    self?.hideCustomLoader()
                    switch result {
                    case .success(let data):
                        self?.pdfView.document = PDFDocument(data: data)
                    case .failure(let error):
                        self?.showErrorAlert(message: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error Loading PDF", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension PDFViewerViewController: CustomNavigationBarDelegate {
    func didTapBack() {
        popVc()
    }
}

