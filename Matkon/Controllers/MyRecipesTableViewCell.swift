//
//  MyRecipesTableViewCell.swift
//  Matkon
//
//  Created by Niv Ohavi on 17/02/2020.
//  Copyright © 2020 Niv Ohavi. All rights reserved.
//

import UIKit

class MyRecipesTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeDescription: UILabel!
    var recipeCategory: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
