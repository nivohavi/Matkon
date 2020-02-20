//
//  Model.swift
//  Matkon
//
//  Created by Niv Ohavi on 01/01/2020.
//  Copyright © 2020 Niv Ohavi. All rights reserved.
//

import Foundation
import UIKit

class Model {
    static let instance = Model()
    
    let modelFirebase:ModelFirebaseStorage = ModelFirebaseStorage()
    let modelSql:ModelCacheSQL = ModelCacheSQL()
    
    
    private init(){
        modelSql.connect()
    }
    
    func saveImage(image:UIImage, callback: @escaping (String)->Void){
        ModelFirebaseStorage.saveImage(image: image, callback: callback)
    }
    
    func getCurrentTimestamp() -> Int64{
        ModelFirebaseStorage.getCurrentTimeStampWOMiliseconds(dateToConvert: NSDate.now as NSDate)
    }
    
    func getLastUpdateDate(name: String) -> Int64{
        return self.modelSql.getLastUpdateDate(name: name)
    }
    
    func getAllRecipes(callback:@escaping ([Recipe]?)->Void){
        
        let lud = getLastUpdateDate(name: "Recipies");
        
        ModelFirebaseDB.instance.getAllRecipes(since:lud) { (data) in
            var lud:Int64 = 0;
            for r in data!{
                self.modelSql.addRecipe(recipe: r)
                if r.timestamp! > lud {lud = r.timestamp!}
            }
            self.modelSql.setLastUpdate(name: "Recipes", lastUpdated: lud)
            
            let finalData = self.modelSql.getAllRecipes()
            callback(finalData);
        }
    }
    
    func getRecipeByCategory(categoryToQuery:String,callback:@escaping ([Recipe]?)->Void){
        
        let lud = getLastUpdateDate(name: categoryToQuery);
        
        ModelFirebaseDB.instance.getRecipesByCategory(since: lud, categoryToQuery: categoryToQuery) { (data) in
            if data != nil{
                var lud:Int64 = 0;
                for r in data!{
                    self.modelSql.addRecipe(recipe: r)
                    if r.timestamp! > lud {
                        lud = r.timestamp!
                    }
                    self.modelSql.setLastUpdate(name: categoryToQuery, lastUpdated: lud)
                }
                let finalData = self.modelSql.getRecipeByCategory(category: categoryToQuery);
                callback(finalData);
            }
        }
    }

    
    
    func getRecipeByCategory(categoryToQuery:String)->[Recipe]{
        
        let lud = getLastUpdateDate(name: categoryToQuery);
        
        ModelFirebaseDB.instance.getRecipesByCategory(since: lud, categoryToQuery: categoryToQuery) { (data) in
            if data != nil{
                var lud:Int64 = 0;
                for r in data!{
                    self.modelSql.addRecipe(recipe: r)
                    if r.timestamp! > lud {
                        lud = r.timestamp!
                    }
                    self.modelSql.setLastUpdate(name: categoryToQuery, lastUpdated: lud)
                }
                
                
            }
        }
        let finalData = self.modelSql.getRecipeByCategory(category: categoryToQuery)
        return finalData;
    }
    
    func deleteRecipeById(id:String){
        self.modelSql.deleteRecipeById(id: id)
    }
    
}

