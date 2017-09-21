//
//  OrderManager.swift
//  Loic&Flo
//
//  Created by Florian Cartier on 12/05/2017.
//  Copyright © 2017 Florian Cartier. All rights reserved.
//

import Foundation

class OrderManager {
    //private var user: User
    static private var orders = [Order]()
    
    // Faire un constructeur par défaut
    static private var order = Order(id: "", p: Float(0), items: nil)
    
    init() {
        
    }
    
    static func getCurrentOrder() -> Order {
        return order
    }
    
    static func createNewOrder(order obj: Order){
        orders.append(order)
        order = obj
    }
}
