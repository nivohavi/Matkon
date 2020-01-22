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
    
    // Here we set the Recipes data
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        
        let cell:RecipeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell

        
        let recipe = data[indexPath.row]
        //cate
        cell.recipeName.text = recipe.name
        cell.recipeDescription.text = recipe.description
        cell.recipeImage.sd_setImage(with: URL(string: recipe.imgURL), placeholderImage: UIImage(named: "placeholder.png"))
        //print(RecipesListTableViewController.)
        //cell.temp.text = currentCategoryNameFromView
        //print(currentCategoryNameFromView)
        //cell.id = recipe.id
        //cell.recipeImage.text = recipe.imgURL
        
        return cell
    }
    
    // This func is passing data to RecipesViewController - Recipe object
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToRecipeViewController"
        {
            // Get the index path from the cell that was tapped
            let indexPath = tableView.indexPathForSelectedRow
            // Get the Row of the Index Path and set as index
            let index = indexPath?.row
            // Get in touch with the DetailViewController
            let RecipeViewController = segue.destination as! RecipeViewController
            // Pass on the data to the Detail ViewController by setting it's indexPathRow value
            RecipeViewController.recipeObj = data[index!]
            
        }
        
        if segue.identifier == "ToNewRecipeViewController"
        {
            // Pass the category name for the New recipe controller
            let NewRecipeViewController = segue.destination as! NewRecipeViewController
            NewRecipeViewController.recipeCategory = currentCategoryNameFromView
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController
    }

}
