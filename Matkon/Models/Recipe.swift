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
    var recipeDescription: String?
    //var ingredientsCollectionRefId: String?
    var ingredientsJson: String?
    var imgURL: String?
    
    init(id:String,name:String?,recipeDescription:String?,ingredientsJson: String?, imgURL:String?) {
        self.id = id
        self.name = name
        self.recipeDescription = recipeDescription
        self.ingredientsJson = ingredientsJson
        self.imgURL = imgURL
    }
    
    init(json:[String:Any]){
        self.id = json["id"] as? String;
        self.name = json["name"] as? String;
        self.recipeDescription = json["recipeDescription"] as? String;
        self.ingredientsJson = json["ingredientsJson"] as? String;
        self.imgURL = json["imgURL"] as? String;

    }
    
    func toJson() -> [String:String] {
        var json = [String:String]();
        json["id"] = id
        json["name"] = name
        json["recipeDescription"] = name
        json["ingredientsJson"] = ingredientsJson
        json["imgURL"] = imgURL
        return json
    }
}
