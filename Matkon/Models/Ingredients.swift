//
//  Ingredients.swift
//  Matkon
//
//  Created by Niv Ohavi on 01/01/2020.
//  Copyright © 2020 Niv Ohavi. All rights reserved.
//

import Foundation

class Ingredients {
    
    var ingredientsList: [String:Any] = [:]

    init(json:String) {
        self.ingredientsList = (json.toJSON() as? [String:AnyObject])!
    }

}

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
