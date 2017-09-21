//
//  OrderTableViewController.swift
//  Loic&Flo
//
//  Created by Florian Cartier on 15/05/2017.
//  Copyright © 2017 Florian Cartier. All rights reserved.
//

import UIKit
import Moltin
import Alamofire
import SwiftyJSON

class OrderTableViewController: UITableViewController {
    
    //MARK: Properties
    var cart = Cart.sharedInstance().getCart()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let checkoutButton = UIBarButtonItem(title: "Commander", style: UIBarButtonItemStyle.plain, target: self, action: #selector(OrderTableViewController.checkout))
        
        self.navigationItem.rightBarButtonItem = checkoutButton
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkout()  {
        // Display a message to the user that the checkout was successful
        let alert = UIAlertController(title: "Order complete!", message: "Your order in complete and your order has been processed! Thank you for shopping with us !", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "OrderTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? OrderTableViewCell  else {
            fatalError("The dequeued cell is not an instance of OrderTableViewCell.")
        }
        
        // Configure the cell...
        let ligne = cart[indexPath.row]
        
        cell.ItemTitle.text = ligne.getGame().titre
        cell.ItemPicture.setImageWith(URL(string: ligne.getGame().image)!)
        cell.ItemPrice.text = String(ligne.getGame().prix)
        cell.ItemQty.text = String(ligne.getQty())
        cell.consoleLabel.text = ligne.getGame().getConsoleName(id: ligne.consoleID)
        //cell.Stepper.value = Double(ligne.getQty())
        return cell
    }
    /*
    func stepperButton(sender: OrderTableViewCell) {
        if let indexPath = tableView.indexPath(for: sender){
            print(indexPath)
            //XXX[sender.tag].value = sender.counterStepper.value
            //cart[sender.tag].setQty(q: Int(sender.Stepper.value))
        }
    }
 
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            // Remove the game from the Cart in the DB
            Cart.sharedInstance().removeFromCart(lp: LignePanier(game: cart[indexPath.row].getGame(), qty: cart[indexPath.row].getQty(), p: Float(cart[indexPath.row].getPrice()), cID: cart[indexPath.row].consoleID))
            
            
            cart.remove(at: indexPath.row)
            // Remove the row from the tableview
            tableView.deleteRows(at: [indexPath], with: .fade)

        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
