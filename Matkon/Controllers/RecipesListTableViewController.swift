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
        
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(self.reloadData), for: .valueChanged)
        
        observer = ModelEvents.ReloadRecipesData.observe{
            self.reloadData()
        }
        self.reloadData()
        
    }
    
    @objc func reloadData(){
        if self.refreshControl?.isRefreshing == false{
            self.refreshControl?.beginRefreshing()
        }
        
        Model.instance.getRecipeByCategory(categoryToQuery: currentCategoryNameFromView!){ (recpieCallback) in
            self.data = recpieCallback!
            self.tableView.reloadData();
            self.refreshControl?.endRefreshing()
        }
        
    };
    

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
