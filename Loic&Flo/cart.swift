//
//  cart.swift
//  Loic&Flo
//
//  Created by Florian Cartier on 11/05/2017.
//  Copyright © 2017 Florian Cartier. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Cart {
    private var cart = [LignePanier]()
    private var price: Float
    private var user = User()
    private var order = Order()
    
    private init(){
        price = Float(0)
    }
    
    static private var instance = Cart()
    
    static func sharedInstance() -> Cart{
        return instance
    }
    
    func addToCart(_ lp: LignePanier) {
        var found = false
        // Add the game to the cart in the database
        let parameters: Parameters = [
            "idJeu": lp.getGame().id,
            "idConsole": lp.consoleID,
            "qty": 1
        ]
        
        // Si le panier est vide
        if cart.count == 0 {
            cart.append(lp)
            // Ajout d'une ligne de commande dans la commande
            Alamofire.request("http://localhost:8080/FinalSR03Project/commande/"+Cart.sharedInstance().getOrder().getId()+"/ligne", method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
                switch response.result {
                    
                case .success(let value):
                    
                    let jsonCart = JSON(value)
                    // Pushing the json object into game objects
                    if jsonCart["status"] == 200 {
                        
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        else {
            // Sinon, on vérifie la présence d'un jeu identique pour une console identique
            var qty = 0
            for item in cart {
                if ((item.getGame().id == lp.getGame().id) && (item.consoleID == lp.consoleID)){
                    item.setQty(q: item.getQty()+1)
                    qty = item.getQty()
                    found = true
                }
            }
            // S'il n'y en a pas, on ajoute une nouvelle ligne de commande contenant le jeu en question
            if found == false {
                cart.append(lp)
                Alamofire.request("http://localhost:8080/FinalSR03Project/commande/"+Cart.sharedInstance().getOrder().getId()+"/ligne", method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let jsonCart = JSON(value)
                        // Pushing the json object into game objects
                        if jsonCart["status"] == 200 {
                            
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            else {
                // S'il y en a un, on le modifie en incrémentant sa quantité
                
                let Updateparameters: Parameters = [
                    "idJeu": lp.getGame().id,
                    "idConsole": lp.consoleID,
                    "qty": qty
                ]
                Alamofire.request("http://localhost:8080/FinalSR03Project/commande/"+Cart.sharedInstance().getOrder().getId()+"/ligne", method: .put, parameters: Updateparameters, encoding: JSONEncoding.default).validate().responseJSON { response in
                    switch response.result {
                        
                    case .success(let value):
                        let jsonCart = JSON(value)
                        if jsonCart["status"] == 200 {
                            
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
        
        price = price + lp.getPrice()
    }
    
    func decreaseQty(lp: LignePanier){
        let quantity = lp.getQty()-1
        
        if quantity == 0 {
            removeFromCart(lp: lp)
        }
        else {
            let Updateparameters: Parameters = [
                "idJeu": lp.getGame().id,
                "idConsole": lp.consoleID,
                "qty": lp.getQty()-1
            ]
            Alamofire.request("http://localhost:8080/FinalSR03Project/commande/"+Cart.sharedInstance().getOrder().getId()+"/ligne", method: .put, parameters: Updateparameters, encoding: JSONEncoding.default).validate().responseJSON { response in
                switch response.result {
                
                    case .success(let value):
                        let jsonCart = JSON(value)
                        if jsonCart["status"] == 200 {
                    
                        }
                    case .failure(let error):
                        print(error)
                }
            }
        }

    }
    
    func removeFromCart(lp: LignePanier) {
        Alamofire.request("http://localhost:8080/FinalSR03Project/commande/"+Cart.sharedInstance().getOrder().getId()+"/jeu/"+lp.getGame().id+"/console/"+lp.consoleID, method: .delete, parameters: nil, encoding: JSONEncoding.default).validate().responseJSON { response in
            switch response.result {
                
            case .success(let value):
                let jsonCart = JSON(value)
                if jsonCart["status"] == 200 {
                    
                    var index = 0
                    
                    for line in self.cart {
                        if ((line.consoleID == lp.consoleID) && (line.getGame().id == lp.getGame().id)){
                            break
                        }
                        else {
                            index += 1
                        }
                    }
                    self.cart.remove(at: index)
                    
                }
            case .failure(let error):
                print(error)
            }
        }

    }
    
    func get(game id: String) -> LignePanier? {
        if cart.count != 0 {
            for ligne in cart {
                if (ligne.getGame().id == id) {
                    return ligne
                }
            }
            return nil
        }
        else {return nil}
    }
    
    func count() -> Int {
        return cart.count
    }
    
    func empty() {
        cart.removeAll()
        price = Float(0)
    }
    
    func getPrice() -> Float {
        return price
    }
    
    func getCart() -> [LignePanier] {
        return cart
    }
    
    func getUser() -> User {
        return user
    }
    
    func getOrder() -> Order {
        return order
    }
    
    func setOrder(order: Order){
        self.order = order
    }
    
    
}
