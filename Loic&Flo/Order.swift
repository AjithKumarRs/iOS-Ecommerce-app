//
//  Order.swift
//  Loic&Flo
//
//  Created by Florian Cartier on 12/05/2017.
//  Copyright © 2017 Florian Cartier. All rights reserved.
//

import Foundation

class Order {
    private var id: String
    //private var user: User
    private var price: Float
    private var items = [LignePanier]()
    private var status = ""
    
    init(id: String, p: Float, items: [LignePanier]?) {
        self.id = id
        self.price = p
        if let items = items {
            self.items = items
        }
        status = "En cours"
    }
    
    init() {
        id = ""
        price = 0 as Float
        status = "En cours"
    }
    
    
    
    func get(item id: String) -> LignePanier? {
        if items.count != 0 {
            for item in items {
                if (item.getGame().id == id) {
                    return item
                }
            }
            return nil
        }
        else {return nil}
    }
    
    func getId() -> String {
        return id
    }
    
/*
    func getUser() -> User {
        return user
    }
*/
    
    func getPrice() -> Float {
        return price
    }
    
    func getItems() -> [LignePanier] {
        return items
    }
    
    func addItem(item i: LignePanier) {
        items.append(i)
    }
    
    func getStatus() -> String {
        return status
    }
    
    func setStatus(s: String) {
        status = s
    }
    
    func setPrice(p: Float){
        price = p
    }
    
    func setId(i: String) {
        id = i
    }
}
