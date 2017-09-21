//
//  DetailViewController.swift
//  Loic&Flo
//
//  Created by Florian Cartier on 03/05/2017.
//  Copyright © 2017 Florian Cartier. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Moltin

class DetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var consolePicker: UIPickerView!
    @IBOutlet weak var detailTitre: UILabel!
    @IBOutlet weak var detailPrix: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    @IBOutlet weak var detailImage: UIImageView?
    
    var consoleType = [String]()
    var consoleSelected = ""
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            
            // Set the product title
            detailTitre.text = detail.titre
            
            // Set the price label
            detailPrix.text = String(detail.prix)
            
            // Deals with the game picture
            var imageUrl = ""
            if (!detail.image.isEmpty) {
                imageUrl = detail.image
            }
            
            detailImage?.setImageWith(URL(string: imageUrl)!)
            
            // Gets and displays the available consoles for the game
            for console in detail.consoles{
                consoleType.append(console.nom)
            }
            
            consolePicker.delegate = self
            consolePicker.dataSource = self
            
            consoleSelected = detail.consoles.first!.id
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Game!
    
    @IBAction func addToCart(_ sender: UIButton) {
        
        // Get the current product id
        Cart.sharedInstance().addToCart(LignePanier(game: detailItem, qty: 1, p: Float(detailItem.prix), cID: consoleSelected))
        
        
            // Display a message to the user
            let alert = UIAlertController(title: "C'est dans le panier !", message: "Nombre d'articles dans le panier : \(Cart.sharedInstance().getCart().count) \r Montant du panier : \(String(Cart.sharedInstance().getPrice()))", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Merci Chef !", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)

        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return consoleType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return consoleType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Do something when a row of the picker is selected
        consoleSelected = detailItem.getId(name: consoleType[row])
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

}
