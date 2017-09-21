//
//  OrderTableViewCell.swift
//  Loic&Flo
//
//  Created by Florian Cartier on 15/05/2017.
//  Copyright © 2017 Florian Cartier. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {


    //@IBOutlet weak var Stepper: UIStepper!
    @IBOutlet weak var ItemTitle: UILabel!
    @IBOutlet weak var ItemPrice: UILabel!
    @IBOutlet weak var ItemPicture: UIImageView!
    @IBOutlet weak var ItemQty: UILabel!
    @IBOutlet weak var consoleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
