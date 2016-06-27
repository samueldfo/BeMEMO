//
//  SubTableViewCell.swift
//  beMEMO
//
//  Created by Samuel Dias Fernandes de Oliveira on 27/06/16.
//  Copyright © 2016 samueldfo. All rights reserved.
//

import UIKit

class SubTableViewCell: UITableViewCell {

    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var bkimage: UIImageView!
    
    override func awakeFromNib() {

        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
