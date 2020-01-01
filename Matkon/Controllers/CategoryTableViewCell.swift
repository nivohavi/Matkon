//
//  CategoryTableViewCell.swift
//  Matkon
//
//  Created by Niv Ohavi on 30/12/2019.
//  Copyright © 2019 Niv Ohavi. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
