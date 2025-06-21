//
//  HomeViewModel.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 20/06/25.
//

final class HomeViewModel {
    
    private let manager = HomeItemManager()
    private(set) var items: [HomeItem] = []
    
    func loadItems() {
        items = manager.fetchHomeItems()
    }
    
    func item(at index: Int) -> HomeItem {
        return items[index]
    }
    
    var count: Int {
        return items.count
    }
}
