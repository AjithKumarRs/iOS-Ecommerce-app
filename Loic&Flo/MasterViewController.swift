//
//  MasterViewController.swift
//  Loic&Flo
//
//  Created by Florian Cartier on 03/05/2017.
//  Copyright © 2017 Florian Cartier. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Moltin

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Game]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Connect the application to the server with Alamofire
        let url = "http://localhost:8080/FinalSR03Project/games"
        
        // Make a call to retrieve the store games
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
                case .success(let value):
                    let json = JSON(value)
                
                    // Pushing the json object into game objects
                    let array = json.arrayValue
                    
                    for game in array {
                        
                        let consoleArray = game["consoles"].arrayValue
                        
                        var console = [Console]()
                        
                        for cons in consoleArray {
                            
                            console.append(Console(id: cons["id"].stringValue, nom: cons["nomConsole"].stringValue))
                        }
                        
                        self.objects.append(Game(id: game["id"].stringValue, titre: game["titre"].stringValue, image: game["url_image"].stringValue, prix: game["prix"].doubleValue, consoles: console))
                    }
                    self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }

        /*
        let checkoutButton = UIBarButtonItem(title: "Panier", style: UIBarButtonItemStyle.plain, target: self, action: #selector(MasterViewController.checkout))
        
        self.navigationItem.rightBarButtonItem = checkoutButton
 */

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Checkout Methods
    
    func checkout()  {
        
        // Create an order
        //var order: Order = OrderManager.
        /*for item in Cart.sharedInstance().getCart() {
            order.addItem(item: item)
        }
 */
        // Empty the cart
//        Cart.sharedInstance().empty()
        
        // Display a message to the user that the checkout was successful
//        let alert = UIAlertController(title: "Order complete!", message: "Your order in complete and your order has been processed! Thank you for shopping with us !", preferredStyle: UIAlertControllerStyle.alert)
//        
//        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
//        
//        self.present(alert, animated: true, completion: nil)
        
        
        
        
        /*
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrderTableViewController") as! OrderTableViewController
        let navigation = UINavigationController(rootViewController: vc)
        present(navigation, animated: true)
         */
        
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let object = objects[indexPath.row]
                
                let controller = (segue.destination) as! DetailViewController
                
                controller.detailItem = object
                
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "GameTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? GameTableViewCell  else {
            fatalError("The dequeued cell is not an instance of GameTableViewCell.")
        }

        let object = objects[indexPath.row]
        
        var consoles = ""
        let nbConsoles =  object.consoles.count
        //if nbConsoles > 0 { consoles = object.consoles[0].nom }
        
        for console in object.consoles {
            if nbConsoles == 1 {
                consoles += console.nom
            }
            else {
                if console.id != object.consoles[nbConsoles-1].id {
                    consoles += console.nom
                }
                else {
                    consoles += ", " + console.nom
                }
            }
        }
        
        cell.GameTitre.text = object.titre
        cell.GameConsoles.text = consoles
        cell.GamePrice.text = String(object.prix)
        cell.GameImage.setImageWith(URL(string: object.image)!)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

