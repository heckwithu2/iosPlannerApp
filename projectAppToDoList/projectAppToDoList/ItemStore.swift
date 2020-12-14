//
//  ItemStore.swift
//  projectAppToDoList
//
//  Created by Jeremiah and Alyssa on 12/11/20. 
//
//
import UIKit

class ItemStore: NSObject {
    
    public var items = [Item]()
    
    // ItemStore is a Singleton
    static let shared = ItemStore()
                
    // Prevent another ItemStore from being created
    public override init() { super.init() }
    
    func addItem() {
        let item = Item()
        items.append(item)
    }
    
    func getItem(index : Int) -> Item {
        return items[index]
    }
    
    func setItem(_ item: Item, number index: Int) {
        items[index] = item
    }

    func removeItem(at index : Int) {
        items.remove(at: index)
    }

    func itemsCount() -> Int {
        return items.count
    }
    
    // Move an item
    func moveItem(first: Int, second: Int) {
        // Get a reference to the item
        let item = items[first]
            
        // Remove from first, insert at second
        items.remove(at: first)
        items.insert(item, at: second)
    }

}
