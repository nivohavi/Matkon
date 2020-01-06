//
//  Recipe.swift
//  Matkon
//
//  Created by Niv Ohavi on 01/01/2020.
//  Copyright © 2020 Niv Ohavi. All rights reserved.
//

import Foundation
import UIKit

class Recipe {
    
    var id: String?
    var name: String?
    var category: String?
    var recipeDescription: String?
    var ingredientsJson: String?
    var photoUrl: String?
    
    init(id:String,name:String?,category:String?,recipeDescription:String?,ingredientsJson: String?, photoUrl:String?) {
        self.id = id
        self.name = name
        self.category = category
        self.recipeDescription = recipeDescription
        self.ingredientsJson = ingredientsJson
        self.photoUrl = photoUrl
    }
    
    init(json:[String:Any]){
        self.id = json["id"] as? String;
        self.name = json["name"] as? String;
        self.category = json["category"] as? String;
        self.recipeDescription = json["recipeDescription"] as? String;
        self.ingredientsJson = json["ingredientsJson"] as? String;
        self.photoUrl = json["photoUrl"] as? String;

    }
    
    func toJson() -> [String:String] {
        var json = [String:String]();
        json["id"] = id
        json["name"] = name
        json["category"] = category
        json["recipeDescription"] = name
        json["ingredientsJson"] = ingredientsJson
        json["photoUrl"] = photoUrl
        return json
    }
}
