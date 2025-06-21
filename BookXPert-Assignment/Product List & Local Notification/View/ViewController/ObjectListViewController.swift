//
//  ObjectListViewController.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 20/06/25.
//


import UIKit

final class ObjectListViewController: BaseViewController {
    
    private let viewModel = ObjectListViewModel()
    
    private let tableView = UITableView()
    private let notificationSwitch = UISwitch()
    
    private let notificationLabel: UILabel = CustomLabelFactory.createLabel(
        text: "Enable Notifications",
        font: .systemFont(ofSize: 18),
        alignment: .left
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.delegate = self
        setupUI()
        viewModel.loadItemsFromAPI()
        configureNavBar(title:  "Product List")
    }
    
    private func setupUI() {
        
        notificationLabel.translatesAutoresizingMaskIntoConstraints = false
        notificationSwitch.isOn = NotificationManager.shared.isNotificationsEnabled()
        notificationSwitch.addTarget(self, action: #selector(toggleNotifications), for: .valueChanged)
        notificationSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        let headerStack = UIStackView(arrangedSubviews: [notificationLabel, notificationSwitch])
        headerStack.axis = .horizontal
        headerStack.spacing = 12
        headerStack.distribution = .equalSpacing
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(headerStack)
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ObjectTableViewCell.self, forCellReuseIdentifier: ObjectTableViewCell.identifier)
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            headerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func toggleNotifications() {
        if notificationSwitch.isOn {
            NotificationManager.shared.requestAuthorization { [weak self] granted in
                if granted {
                    NotificationManager.shared.setNotificationsEnabled(true)
                } else {
                    NotificationManager.shared.setNotificationsEnabled(false)
                    self?.notificationSwitch.setOn(false, animated: true)
                    NotificationManager.shared.showSettingsAlert()
                }
            }
        } else {
            NotificationManager.shared.setNotificationsEnabled(false)
        }
    }
    
    
    private func showUpdateAlert(for index: Int) {
        let item = self.viewModel.items[index]
        let updateVC = ProductUpdateViewController(item: item)
        
        updateVC.onUpdate = { [weak self] updatedItem in
            guard let self = self else { return }
            self.viewModel.updateItemInCoreData(
                id: updatedItem.id ?? "",
                newName: updatedItem.name ?? ""
            )
        }
        self.navigationController?.pushViewController(updateVC, animated: true)
    }
    
}

// MARK: - UITableViewDelegate & DataSource

extension ObjectListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ObjectTableViewCell.identifier, for: indexPath) as? ObjectTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: item, index: indexPath.row, delegate: self)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            guard let self = self else { return }
            
            let alert = UIAlertController(
                title: "Delete Item",
                message: "Are you sure you want to delete \"\(self.viewModel.items[indexPath.row].name ?? "Unknown")\"?",
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
                completion(false)
            })
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
                self.viewModel.deleteItem(at: indexPath.row)
                completion(true)
            })
            
            self.present(alert, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: -tableView.bounds.width, y: 0)
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.03 * Double(indexPath.row),
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.3,
            options: .curveEaseInOut,
            animations: {
                cell.transform = .identity
            },
            completion: nil
        )
    }

}

extension ObjectListViewController: ObjectListViewModelDelegate {
    func didUpdateItems() {
        tableView.reloadData()
    }
    
    func didFailWithError(_ message: String) {
        let alert = UIAlertController(title: "Validation Failed", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showLoader() {
        showCustomLoader()
    }
    
    func hideLoader() {
        hideCustomLoader()
    }
    
}

extension ObjectListViewController: ObjectTableViewCellDelegate {
    func didTapEdit(at index: Int) {
        showUpdateAlert(for: index)
    }
    
    func didTapMoreDetails(at index: Int) {
        let selectedItem = viewModel.items[index]
        let detailVC = ProductDetailsViewController(item: selectedItem)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    func didTapDelete(at index: Int) {
        let item = viewModel.items[index]
        let alert = UIAlertController(
            title: "Delete Item",
            message: "Are you sure you want to delete \"\(item.name ?? "")\"?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.viewModel.deleteItem(at: index)
        })
        present(alert, animated: true)
    }
}

extension ObjectListViewController: CustomNavigationBarDelegate {
    func didTapBack() {
        popVc()
    }
}
