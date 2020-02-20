//
//  ModelEvents.swift
//  Matkon
//
//  Created by Niv Ohavi on 22/01/2020.
//  Copyright © 2020 Niv Ohavi. All rights reserved.
//

import Foundation

class ModelEvents{
    
    static let ReloadRecipesData = ModelEventsTemplate(name: "app.Matkon.ReloadRecipesData");
    
    static func removeObserver(observer:Any){
        NotificationCenter.default.removeObserver(observer)
    }
    private init(){}
}
