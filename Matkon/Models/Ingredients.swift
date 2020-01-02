//
//  Ingredients.swift
//  Matkon
//
//  Created by Niv Ohavi on 01/01/2020.
//  Copyright © 2020 Niv Ohavi. All rights reserved.
//

import Foundation

class Ingredients {
    
    //var name: String
    //var quantity: String
    var ingredientsList: [String:Any] = [:]

    init(json:String) {
        //self.name = json["name"] as? String;
        //self.quantity = json["quantity"] as? String;
        //let json = try? JSONSerialization.jsonObject(with: json!, options: []) as? NSDictionary
        
        //self.ingredientsList["name"] = json["name"] as? String;
        self.ingredientsList = (json.toJSON() as? [String:AnyObject])!

    }

}

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
