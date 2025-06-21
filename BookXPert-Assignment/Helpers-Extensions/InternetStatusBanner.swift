//
//  InternetStatusBanner.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 20/06/25.
//


import UIKit

final class InternetStatusBanner {
    
    let view: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .systemRed
        let label = UILabel()
        label.text = "No Internet Connection"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: v.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -16),
            v.heightAnchor.constraint(equalToConstant: 50)
        ])
        v.isHidden = true
        return v
    }()
    
    private var isSetup = false
    private var topConstraint: NSLayoutConstraint?
    
    func install(in container: UIViewController) {
        guard !isSetup else { return }
        isSetup = true
        
        let containerView = container.view!
        containerView.addSubview(view)
        topConstraint = view.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor)
        NSLayoutConstraint.activate([
            topConstraint!,
            view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    func setVisible(_ visible: Bool, animated: Bool = true) {
        guard view.isHidden == visible else { return }
        if animated {
            view.alpha = visible ? 0 : 1
            view.isHidden = false
            UIView.animate(withDuration: 0.25, animations: {
                self.view.alpha = visible ? 1 : 0
            }) { _ in
                self.view.isHidden = !visible
            }
        } else {
            view.isHidden = !visible
        }
    }
}
