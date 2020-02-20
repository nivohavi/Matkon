//
//  RecipeViewController.swift
//  Matkon
//
//  Created by Niv Ohavi on 01/01/2020.
//  Copyright © 2020 Niv Ohavi. All rights reserved.
//

import UIKit
import SDWebImage

class RecipeViewController: UIViewController {

    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeDescription: UILabel!
    @IBOutlet weak var directionsTextView: UITextView!
    @IBOutlet weak var ingTextView: UITextView!
    
    var recipeCategory: String?
    var recipeObj: Recipe?
    
    @IBOutlet weak var myScroll: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.recipeName.text = recipeObj?.name
        self.recipeImage.sd_setImage(with: URL(string: recipeObj!.imgURL), placeholderImage: UIImage(named: "placeholder.png"))
        self.recipeDescription.text = recipeObj?.description
        self.ingTextView.text = recipeObj?.ingredientsJson
        self.directionsTextView.text = recipeObj?.directions
        
        recipeImage.layer.masksToBounds = true

    }

}
