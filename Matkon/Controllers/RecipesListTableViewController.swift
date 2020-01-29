//
//  RecipesListTableViewController.swift
//  Matkon
//
//  Created by Niv Ohavi on 01/01/2020.
//  Copyright © 2020 Niv Ohavi. All rights reserved.
//

import UIKit
import SDWebImage


class RecipesListTableViewController: UITableViewController {
    
    var data = [Recipe]()
    var currentCategoryNameFromView: String?
    var observer:Any?;

    override func viewDidLoad() {
        super.viewDidLoad()
            
        ModelFirebaseDB.instance.getRecipesByCategory(categoryToQuery: currentCategoryNameFromView) { (_data:[Recipe]?) in
            if (_data != nil) {
                self.data = _data!;
                self.tableView.reloadData();
            }
        };
        
        observer = ModelEvents.ReloadRecipesData.observe{
            ModelFirebaseDB.instance.getRecipesByCategory(categoryToQuery: self.currentCategoryNameFromView) { (_data:[Recipe]?) in
                    if (_data != nil) {
                        self.data = _data!;
                        self.tableView.reloadData();
                        }
            };
        }
        
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RecipeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell

        
        let recipe = data[indexPath.row]
        cell.recipeName.text = recipe.name
        cell.recipeDescription.text = recipe.description
        cell.recipeImage.sd_setImage(with: URL(string: recipe.imgURL), placeholderImage: UIImage(named: "placeholder.png"))
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToRecipeViewController"
        {
            let indexPath = tableView.indexPathForSelectedRow
            let index = indexPath?.row
            let RecipeViewController = segue.destination as! RecipeViewController
            RecipeViewController.recipeObj = data[index!]
            
        }
        
        if segue.identifier == "ToNewRecipeViewController"
        {
            let NewRecipeViewController = segue.destination as! NewRecipeViewController
            NewRecipeViewController.recipeCategory = currentCategoryNameFromView
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController
    }

}
