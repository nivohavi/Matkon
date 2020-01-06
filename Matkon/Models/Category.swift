//
//  Category.swift
//  Matkon
//
//  Created by Niv Ohavi on 30/12/2019.
//  Copyright © 2019 Niv Ohavi. All rights reserved.
//

import Foundation
import UIKit

class Category {
    
    var id: String?
    var name: String?
    var imgURL: String?
    
    init(name:String?, imgURL:String?) {
        self.name = name
        self.imgURL = imgURL
        
    }
}
