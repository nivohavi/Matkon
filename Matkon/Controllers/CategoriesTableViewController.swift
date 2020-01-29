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
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CategoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell


        category = categories[indexPath.row]
        cell.categoryName?.text = category!.name
        cell.categoryImage.sd_setImage(with: URL(string: category!.imgURL!), placeholderImage: UIImage(named: "placeholder.png"))

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPathForSelectedRow
        let index = indexPath?.row
        let RecipesListTableViewController = segue.destination as! RecipesListTableViewController
        RecipesListTableViewController.currentCategoryNameFromView = categories[index!].name
    }
}
