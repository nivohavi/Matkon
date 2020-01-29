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
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var recipeIngredients: UILabel!
    @IBOutlet weak var directionsLabel: UILabel!
    @IBOutlet weak var recipeDirections: UILabel!
    
    var recipeCategory: String?
    var recipeObj: Recipe?
    
    @IBOutlet weak var myScroll: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myScroll.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+300)

        
        self.recipeName.text = recipeObj?.name
        self.recipeImage.sd_setImage(with: URL(string: recipeObj!.imgURL), placeholderImage: UIImage(named: "placeholder.png"))
        self.recipeDescription.text = recipeObj?.description
        self.recipeDirections.text = recipeObj?.directions
        self.recipeIngredients.text = recipeObj?.ingredientsJson

        ingredientsLabel.layer.borderWidth = 0.5
        ingredientsLabel.layer.borderColor = UIColor.orange.cgColor
        
        directionsLabel.layer.borderWidth = 0.5
        directionsLabel.layer.borderColor = UIColor.orange.cgColor
        
        recipeImage.layer.masksToBounds = true
        recipeImage.layer.cornerRadius = recipeImage.bounds.width / 2
    }

}
