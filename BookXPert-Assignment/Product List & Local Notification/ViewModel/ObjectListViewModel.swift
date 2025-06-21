//
//  ObjectListViewModel.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 20/06/25.
//

import Foundation

final class ObjectListViewModel {
    weak var delegate: ObjectListViewModelDelegate?
    private(set) var items: [CDObjectItem] = []
    
    func loadItemsFromAPI() {
        delegate?.showLoader()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            NetworkManager.shared.request([APIObjetItems].self,
                                          url: AppConfig.apiBaseURL) { [weak self] result in
                guard let self = self else { return }
                self.delegate?.hideLoader()
                switch result {
                case .success(let apiItems):
                    CoreDataManager.shared.save(items: apiItems)
                    self.loadItemsFromCoreData()
                case .failure(let error):
                    self.delegate?.didFailWithError(error.localizedDescription)
                }
            }
        })
    }
    
    func loadItemsFromCoreData() {
        self.items = CoreDataManager.shared.fetchItems()
        delegate?.didUpdateItems()
    }
    
    func updateItemInCoreData(id: String, newName: String) {
        guard !newName.trimmingCharacters(in: .whitespaces).isEmpty else {
            delegate?.didFailWithError("Name cannot be empty")
            return
        }
        
        CoreDataManager.shared.updateItem(id: id, with: newName)
        fetchItemsFromCoreData()
    }
    
    func fetchItemsFromCoreData() {
        self.items = CoreDataManager.shared.fetchItems()
        delegate?.didUpdateItems()
    }
    
    func deleteItem(at index: Int) {
        let item = items[index]
        let name = item.name ?? "Unknown"
        let id = item.id ?? "N/A"
        CoreDataManager.shared.deleteItem(by: item.id ?? "")
        items.remove(at: index)
        fetchItemsFromCoreData()
        NotificationManager.shared.sendDeleteNotification(name: name, id: id)
    }
    
}

struct AppConfig {
    static var apiBaseURL: String {
        guard let url = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String else {
            fatalError("API_BASE_URL not set in Info.plist")
        }
        return url
    }
}

protocol ObjectListViewModelDelegate: AnyObject {
    func didUpdateItems()
    func didFailWithError(_ message: String)
    func showLoader()
    func hideLoader()
}
