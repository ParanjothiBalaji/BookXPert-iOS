//
//  BaseViewController.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 20/06/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    let navBar = CustomNavigationBar(title: "")
    
    private let internetBanner = InternetStatusBanner()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomNavBar()
        internetBanner.install(in: self)
        ReachabilityManager.shared.startListening { [weak self] online in
            self?.internetBanner.setVisible(!online)
        }
    }
    
    private func setupCustomNavBar() {
        view.addSubview(navBar)
        navBar.delegate = self as? CustomNavigationBarDelegate
        navBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    func configureNavBar(title: String) {
        navBar.setTitle(title)
    }
    
    func popVc(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
    func pushVc(viewController: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func showCustomLoader() {
        let loader = LoadingIndicatorView(frame: view.bounds)
        loader.tag = 999
        view.addSubview(loader)
    }
    
    func hideCustomLoader() {
        view.viewWithTag(999)?.removeFromSuperview()
    }
}
