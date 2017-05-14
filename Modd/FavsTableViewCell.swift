//
//  FavsTableViewCell.swift
//  Modd
//
//  Created by Simon Narang on 5/14/16.
//  Copyright © 2016 Simon Narang. All rights reserved.
//

import UIKit

class FavsTableViewCell: UITableViewCell {

    @IBOutlet weak var favMod: UILabel!
    @IBOutlet weak var favsHeart: ModImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
