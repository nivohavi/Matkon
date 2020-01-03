//
//  RecipesListTableViewController.swift
//  Matkon
//
//  Created by Niv Ohavi on 01/01/2020.
//  Copyright © 2020 Niv Ohavi. All rights reserved.
//

import UIKit


class RecipesListTableViewController: UITableViewController {
    
    //let fbDB = ModelFirebaseDB.instance;
    var data = [Recipe]()

    
    var categories = [
        Category(name: "Italian", imgURL: "http://getdrawings.com/free-icon-bw/taco-icon-5.png"),
        Category(name: "Mexican", imgURL: "http://getdrawings.com/free-icon-bw/taco-icon-5.png"),
        Category(name: "Israeli", imgURL: "http://getdrawings.com/free-icon-bw/taco-icon-5.png"),
        Category(name: "French", imgURL: "http://getdrawings.com/free-icon-bw/taco-icon-5.png")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        ModelFirebaseDB.instance.getAllStudents { (_data:[Recipe]?) in
            if (_data != nil) {
                self.data = _data!;
                self.tableView.reloadData();
            }
        };
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        cell.recipeName.text = recipe.name
        cell.recipeDescription.text = recipe.recipeDescription
        cell.recipeImage.sd_setImage(with: URL(string: recipe.imgURL!), placeholderImage: UIImage(named: "placeholder.png"))
        
        //cell.id = recipe.id
        //cell.recipeImage.text = recipe.imgURL
        ModelFirebaseDB.instance.test()
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
