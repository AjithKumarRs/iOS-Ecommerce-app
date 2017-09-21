//
//  LignePanier.swift
//  Loic&Flo
//
//  Created by Florian Cartier on 11/05/2017.
//  Copyright © 2017 Florian Cartier. All rights reserved.
//

import Foundation

class LignePanier {
    
    // Variables de classes
    private var Game: Game
    private var quantity: Int
    private var price: Float
    var consoleID: String
    
    // Constructeur
    
    init(game: Game, qty: Int, p: Float, cID: String) {
        self.Game = game
        quantity = qty
        price = p
        consoleID = cID
    }
    
    // Getters
    
    func getGame() -> Game{
        return Game
    }
    
    func getQty() -> Int {
        return quantity
    }
    
    func getPrice() -> Float{
        return price
    }
    
    // Setters
    
    func setGameId(game: Game){
        self.Game = game
    }
    
    func setQty(q: Int){
        quantity = q
    }
    
    func setPrice(p: Float){
        price = p
    }
    
}
