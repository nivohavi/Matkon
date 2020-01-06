//
//  CategoriesTableViewController.swift
//  Matkon
//
//  Created by Niv Ohavi on 30/12/2019.
//  Copyright © 2019 Niv Ohavi. All rights reserved.
//

import UIKit
import SDWebImage

class CategoriesTableViewController: UITableViewController {
    
    var category:Category?
    var categories = [
        Category(name: "Italian", imgURL: "http://getdrawings.com/free-icon-bw/taco-icon-5.png"),
        Category(name: "Mexican", imgURL: "http://getdrawings.com/free-icon-bw/taco-icon-5.png"),
        Category(name: "Israeli", imgURL: "http://getdrawings.com/free-icon-bw/taco-icon-5.png"),
        Category(name: "French", imgURL: "http://getdrawings.com/free-icon-bw/taco-icon-5.png")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        

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
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CategoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell


        // Configure the cell...
        category = categories[indexPath.row]
        cell.categoryName?.text = category!.name
        cell.categoryImage.sd_setImage(with: URL(string: category!.imgURL!), placeholderImage: UIImage(named: "placeholder.png"))

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let indexPath = tableView.indexPathForSelectedRow!
//        let currentCell = tableView.cellForRow(at: indexPath)! as! CategoryTableViewCell
//
//        let valueToPass = categories[indexPath.row].name
//        print("value: \(valueToPass)")
//
//        performSegue(withIdentifier: "toRecipesList", sender: valueToPass)
        
        
    }
    
    // This func is passing data to RecipesListTableViewController - the Category Name
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the index path from the cell that was tapped
        let indexPath = tableView.indexPathForSelectedRow
        // Get the Row of the Index Path and set as index
        let index = indexPath?.row
        // Get in touch with the DetailViewController
        let RecipesListTableViewController = segue.destination as! RecipesListTableViewController
        // Pass on the data to the Detail ViewController by setting it's indexPathRow value
        RecipesListTableViewController.currentCategoryNameFromView = categories[index!].name
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
