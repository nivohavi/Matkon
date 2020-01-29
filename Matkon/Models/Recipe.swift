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
    
    var id:String = ""
    var name: String = ""
    var createdBy: String = ""
    var category: String = ""
    var description: String = ""
    var ingredientsJson: String = ""
    var directions: String = ""
    var imgURL: String = ""
    
    init(id:String,name:String,createdBy:String,category:String,description:String,ingredientsJson: String,directions: String, imgURL:String) {
        self.id = id
        self.name = name
        self.category = category
        self.description = description
        self.ingredientsJson = ingredientsJson
        self.directions = directions
        self.imgURL = imgURL
    }
    
    init(name:String,createdBy:String,category:String,description:String,ingredientsJson: String,directions: String, imgURL:String) {
        self.name = name
        self.category = category
        self.createdBy = createdBy
        self.description = description
        self.ingredientsJson = ingredientsJson
        self.directions = directions
        self.imgURL = imgURL
    }
    
    init(json:[String:String]){
        self.id = json["id"]!;
        self.name = json["name"]!;
        self.createdBy = json["createdBy"]!;
        self.category = json["category"]!;
        self.description = json["description"]!;
        self.ingredientsJson = json["ingredientsJson"]!;
        self.directions = json["directions"]!;
        self.imgURL = json["imgURL"]!;

    }
    
    func toJson() -> [String:String] {
        var json = [String:String]();
        json["id"] = id
        json["name"] = name
        json["createdBy"] = createdBy
        json["category"] = category
        json["description"] = description
        json["ingredientsJson"] = ingredientsJson
        json["directions"] = directions
        json["imgURL"] = imgURL
        return json
    }
}
