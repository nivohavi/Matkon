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
    
    var id: Int?
    var name: String?
    var Ingredients: [String?] = []
    var imgURL: String?
    
    init(id:Int,name:String?,Ingredients:[String?], imgURL:String?) {
        self.id = id
        self.name = name
        self.Ingredients = Ingredients
        self.imgURL = imgURL
    }
}
