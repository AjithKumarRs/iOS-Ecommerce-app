//
//  ConnexionViewController.swift
//  Loic&Flo
//
//  Created by Florian Cartier on 15/05/2017.
//  Copyright © 2017 Florian Cartier. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class ConnexionViewController: UIViewController {

    
    @IBOutlet weak var Login: UITextField!
    
    @IBOutlet weak var Password: UITextField!
    
    @IBOutlet weak var PasswordErrorMessage: UILabel!
    @IBOutlet weak var LoginErrorMessage: UILabel!
    
    @IBAction func ConnectionButton(_ sender: UIButton) {
        
        if Login.text!.isEmpty {
            PasswordErrorMessage.isHidden = false
            LoginErrorMessage.text = "Login Empty."
            LoginErrorMessage.isHidden = false
            
        } else if Password.text!.isEmpty {
            LoginErrorMessage.isHidden = true
            PasswordErrorMessage.text = "Password Empty."
            PasswordErrorMessage.isHidden = false
            
        } else {
            
            // Call the server to check the user identity
            let url = "http://localhost:8080/FinalSR03Project/users/auth"
            let parameters: Parameters = [
                "login": Login.text!,
                "password": Password.text!
            ]
 
            // Make a call to retrieve the store games
            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
                switch response.result {
                    
                case .success(let value):
                    
                    let json = JSON(value)
                    
                    // Pushing the json object into game objects
                    if json["status"] == 200 {
                        
                        // Set the user ID in the cart
                        Cart.sharedInstance().getUser().setId(id: json["id"].stringValue)
                        
                        let cartParameters: Parameters = [
                            "id": Cart.sharedInstance().getUser().getId(),
                            "password": "",
                            "login": ""
                        ]
                        
                        // Get the current order for the user from the server
                        Alamofire.request("http://localhost:8080/FinalSR03Project/commande/getCurrent", method: .post, parameters: cartParameters, encoding: JSONEncoding.default).validate().responseJSON { response in
                            switch response.result {
                                
                            case .success(let value):
                                
                                let jsonCart = JSON(value)
                                let array = jsonCart["commande"]["ligneCommandes"].arrayValue
                                // Pushing the json object into game objects
                                if jsonCart["status"] == 200 {
                                    
                                    // Set the user ID in the cart
                                    //Cart.sharedInstance().getUser().setId(id: jsonCart["id"].stringValue)
                                    let odr = Order()
                                    odr.setId(i: jsonCart["commande"]["id"].stringValue)
                                    odr.setPrice(p: jsonCart["commande"]["price"].floatValue)
                                    
                                    Cart.sharedInstance().setOrder(order: odr)

                                    for ligne in array{
                                        
                                        var game = ligne["jeu_id"]
                                        
                                        var consoleArray = game["consoles"].arrayValue
                                        var console = [Console]()
                                        for cons in consoleArray {
                                            console.append(Console(id: cons["id"].stringValue, nom: cons["nomConsole"].stringValue))
                                        }
                                        
                                       Cart.sharedInstance().addToCart(LignePanier(
                                        game: Game(id: game["id"].stringValue, titre: game["titre"].stringValue, image: game["url_image"].stringValue, prix: game["prix"].doubleValue, consoles: console),
                                        qty: ligne["quantity"].intValue,
                                        p: ligne["linePrice"].floatValue,
                                        cID: ligne["console_id"].stringValue))

                                    }
                                    
                                    // Move to the app content
                                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                    
                                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MasterViewController") as! MasterViewController
                                    
                                    let navigation = UINavigationController(rootViewController: nextViewController)
                                    self.present(navigation, animated:true)
 
                                }
                            case .failure(let error):
                                print(error)
                            }
                        }
                    }
                    else {
                        self.PasswordErrorMessage.text = "Mauvais identifiants"
                        self.PasswordErrorMessage.isHidden = false
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Login.text = "bodylan"
        Password.text = "secret"
        PasswordErrorMessage.isHidden = true
        LoginErrorMessage.isHidden = true
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
