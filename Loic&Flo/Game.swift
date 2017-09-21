//
//  Game.swift
//  Loic&Flo
//
//  Created by Florian Cartier on 04/05/2017.
//  Copyright © 2017 Florian Cartier. All rights reserved.
//

import Foundation

class Game {
    
    var id : String = ""
    var titre: String = ""
    var image: String = ""
    var prix: Double = 0.0
    var consoles = [Console]()
    
    init(id: String, titre: String, image: String, prix: Double, consoles: [Console]){
        self.id = id
        self.titre = titre
        self.prix = prix
        self.image = image
        self.consoles = consoles
    }
    
    init(titre: String, image: String, prix: Double, consoles: [Console]){
        self.titre = titre
        self.prix = prix
        self.image = image
        self.consoles = consoles
    }
    
    func getId(name n: String) -> String{
        var id = "-1"
        if consoles.count != 0 {
            for c in consoles {
                if c.nom == n {
                    id = c.id
                }
            }
        }
        return id
    }
    
    func getConsoleName(id n: String) -> String{
        var name = "-1"
        if consoles.count != 0 {
            for c in consoles {
                if c.id == n {
                    name = c.nom
                }
            }
        }
        return name
    }
    
}

