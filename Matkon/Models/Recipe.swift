//
//  Recipe.swift
//  Matkon
//
//  Created by Niv Ohavi on 01/01/2020.
//  Copyright © 2020 Niv Ohavi. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Recipe {
    
    var id:String = ""
    var name: String = ""
    var createdBy: String = ""
    var category: String = ""
    var description: String = ""
    var ingredientsJson: String = ""
    var directions: String = ""
    var imgURL: String = ""
    var timestamp: Int64?
    
    init(){}
    
    init(id:String,name:String,createdBy:String,category:String,description:String,ingredientsJson: String,directions: String, imgURL:String, timestamp:Int64) {
        self.id = id
        self.name = name
        self.createdBy = createdBy
        self.category = category
        self.description = description
        self.ingredientsJson = ingredientsJson
        self.directions = directions
        self.imgURL = imgURL
        self.timestamp = timestamp
    }
    
    init(id:String,name:String,createdBy:String,category:String,description:String,ingredientsJson: String,directions: String, imgURL:String) {
        self.id = id
        self.name = name
        self.createdBy = createdBy
        self.category = category
        self.description = description
        self.ingredientsJson = ingredientsJson
        self.directions = directions
        self.imgURL = imgURL
    }
    
    init(name:String,createdBy:String,category:String,description:String,ingredientsJson: String,directions: String, imgURL:String, timestamp:Int64) {
        self.name = name
        self.category = category
        self.createdBy = createdBy
        self.description = description
        self.ingredientsJson = ingredientsJson
        self.directions = directions
        self.imgURL = imgURL
        self.timestamp = timestamp
    }
    
    
    init(json:[String:Any]){
        self.id = json["id"]! as! String;
        self.name = json["name"]! as! String;
        self.createdBy = json["createdBy"]! as! String;
        self.category = json["category"]! as! String;
        self.description = json["description"]! as! String;
        self.ingredientsJson = json["ingredientsJson"]! as! String;
        self.directions = json["directions"]! as! String;
        self.imgURL = json["imgURL"]! as! String;
        let ts  = json["timestamp"] as! Timestamp;
        self.timestamp = ts.seconds;
        
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]();
        json["id"] = id
        json["name"] = name
        json["createdBy"] = createdBy
        json["category"] = category
        json["description"] = description
        json["ingredientsJson"] = ingredientsJson
        json["directions"] = directions
        json["imgURL"] = imgURL
        json["timestamp"] = FieldValue.serverTimestamp()
        return json
    }
}
