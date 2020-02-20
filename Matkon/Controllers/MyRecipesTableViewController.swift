//
//  MyRecipesTableViewController.swift
//  Matkon
//
//  Created by Niv Ohavi on 29/01/2020.
//  Copyright © 2020 Niv Ohavi. All rights reserved.
//

import UIKit
import SDWebImage

class MyRecipesTableViewController: UITableViewController {
    var data = [Recipe]()
    var currentCategoryNameFromView: String?
    var observer:Any?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadData()
        
        observer = ModelEvents.ReloadRecipesData.observe{
            self.reloadData()
        }
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(self.reloadData), for: .valueChanged)
        
    }

    @objc func reloadData(){
        
        if self.refreshControl?.isRefreshing == false{
             self.refreshControl?.beginRefreshing()
         }
         
        ModelFirebaseDB.instance.getUserRecipes { (data) in
                if data != nil{
                    self.data = [Recipe]()
                    for r in data!{
                        self.data.append(r)
                    }
                    self.tableView.reloadData();
                    self.refreshControl?.endRefreshing()

                }
            }

         };
     
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MyRecipesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyRecipesTableViewCell", for: indexPath) as! MyRecipesTableViewCell

        
        let recipe = data[indexPath.row]
        cell.recipeName.text = recipe.name
        cell.recipeDescription.text = recipe.description
        cell.recipeImage.sd_setImage(with: URL(string: recipe.imgURL), placeholderImage: UIImage(named: "placeholder.png"))
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToEditRecipeViewController"
        {
            let indexPath = tableView.indexPathForSelectedRow
            let index = indexPath?.row
            let recipe = data[index!]
            let EditRecipeViewController = segue.destination as! EditRecipeViewController
            EditRecipeViewController.recipe = recipe
            

        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController
    }


}
