//
//  GameTableViewCell.swift
//  Loic&Flo
//
//  Created by Florian Cartier on 15/05/2017.
//  Copyright © 2017 Florian Cartier. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    
    
    @IBAction func AddButton(_ sender: UIButton) {
    }
    @IBOutlet weak var GameConsoles: UILabel!
    @IBOutlet weak var GamePrice: UILabel!
    @IBOutlet weak var GameTitre: UILabel!
    @IBOutlet weak var GameImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
