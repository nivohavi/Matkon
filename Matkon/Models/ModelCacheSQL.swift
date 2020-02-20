//
//  ModelCacheSQL.swift
//  Matkon
//
//  Created by Niv Ohavi on 25/01/2020.
//  Copyright © 2020 Niv Ohavi. All rights reserved.
//

import Foundation
class ModelCacheSQL{
    var database: OpaquePointer? = nil
    
    func connect(){
        let dbFileName = "database.db"
        if let dir = FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask).first{
            let path = dir.appendingPathComponent(dbFileName)
            print(path.absoluteString)
            if sqlite3_open(path.absoluteString, &database) != SQLITE_OK {
                print("Failed to open db file: \(path.absoluteString)")
                return
            }
        }
        createRecipesTable()
        createLastUpdateTable()
    }
    func createRecipesTable(){
        var errormsg: UnsafeMutablePointer<Int8>? = nil
        
        let res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS RECIPES (R_ID TEXT PRIMARY KEY, NAME TEXT,CREATEDBY TEXT,CATEGORY TEXT,DESCRIPTION TEXT,INGREDIENTSJSON TEXT,DIRECTIONS TEXT,IMAGEURL TEXT)", nil, nil, &errormsg);
        if(res != 0){
            print("error creating table");
            return
        }
    }
    func createLastUpdateTable(){
        var errormsg: UnsafeMutablePointer<Int8>? = nil
        let res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS LAST_UPADATE_DATE (NAME TEXT PRIMARY KEY, DATE DOUBLE)", nil, nil, &errormsg);
        if(res != 0){
            print("error creating table");
            return
        }
    }
    
    func addRecipe(recipe: Recipe){
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO RECIPES (R_ID,NAME,CREATEDBY ,CATEGORY,DESCRIPTION,INGREDIENTSJSON,DIRECTIONS,IMAGEURL) VALUES (?,?,?,?,?,?,?,?);",-1,
                               &sqlite3_stmt,nil) == SQLITE_OK){
            let r_id = recipe.id.cString(using: .utf8)
            let name = recipe.name.cString(using: .utf8)
            let createdBy = recipe.createdBy.cString(using: .utf8)
            let category = recipe.category.cString(using: .utf8)
            let description = recipe.description.cString(using: .utf8)
            let ingredientsJson = recipe.ingredientsJson.cString(using: .utf8)
            let directions = recipe.directions.cString(using: .utf8)
            let imageURL = recipe.imgURL.cString(using: .utf8)
            
            sqlite3_bind_text(sqlite3_stmt, 1, r_id,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 2, name,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 3, createdBy,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 4, category,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 5, description,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 6, ingredientsJson,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 7, directions,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 8, imageURL,-1,nil);
            
            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("")
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        
    }
    
    func getAllRecipes() -> [Recipe]{
        var sqlite3_stmt: OpaquePointer? = nil
        var data = [Recipe]()
        if (sqlite3_prepare_v2(database,"SELECT * from RECIPES;",-1,&sqlite3_stmt,nil) == SQLITE_OK){
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let r_id = String(cString:sqlite3_column_text(sqlite3_stmt,0)!)
                let name = String(cString:sqlite3_column_text(sqlite3_stmt,1)!)
                let createdBy = String(cString:sqlite3_column_text(sqlite3_stmt,2)!)
                let category = String(cString:sqlite3_column_text(sqlite3_stmt,3)!)
                let description = String(cString:sqlite3_column_text(sqlite3_stmt,4)!)
                let ingredientsJson = String(cString:sqlite3_column_text(sqlite3_stmt,5)!)
                let directions = String(cString:sqlite3_column_text(sqlite3_stmt,6)!)
                let imageURL = String(cString:sqlite3_column_text(sqlite3_stmt,7)!)
                
                let recipe = Recipe(id: r_id, name: name, createdBy: createdBy, category: category, description: description, ingredientsJson: ingredientsJson, directions: directions, imgURL: imageURL)
                
                data.append(recipe)
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        return data
    }
    
    func setLastUpdate(name:String, lastUpdated:Int64){
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO LAST_UPADATE_DATE( NAME, DATE) VALUES (?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
            
            sqlite3_bind_text(sqlite3_stmt, 1, name,-1,nil);
            sqlite3_bind_int64(sqlite3_stmt, 2, lastUpdated);
            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("")
            }
        }
        sqlite3_finalize(sqlite3_stmt)
    }
    
    func getLastUpdateDate(name:String)->Int64{
        var date:Int64 = 0;
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(database,"SELECT * from LAST_UPADATE_DATE WHERE NAME = ?;",-1,&sqlite3_stmt,nil)
            == SQLITE_OK){
            let n = name as NSString
            sqlite3_bind_text(sqlite3_stmt, 1, n.utf8String,-1,nil);
            
            if(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                date = Int64(sqlite3_column_int64(sqlite3_stmt,1))
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        return date
    }
    
    func getRecipeByCategory(category:String) -> [Recipe] {
        var sqlite3_stmt: OpaquePointer? = nil
        var data = [Recipe]()
        if (sqlite3_prepare_v2(database,"SELECT * from RECIPES where category = ?;",-1,&sqlite3_stmt,nil) == SQLITE_OK){
            
            let cat = category as NSString
            sqlite3_bind_text(sqlite3_stmt, 1, cat.utf8String,-1,nil);
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let recipe = Recipe()
                recipe.id =  String(cString:sqlite3_column_text(sqlite3_stmt,0))
                recipe.name = String(cString:sqlite3_column_text(sqlite3_stmt,1))
                recipe.createdBy = String(cString:sqlite3_column_text(sqlite3_stmt,2))
                recipe.category = String(cString:sqlite3_column_text(sqlite3_stmt,3))
                recipe.description = String(cString:sqlite3_column_text(sqlite3_stmt,4))
                recipe.ingredientsJson = String(cString:sqlite3_column_text(sqlite3_stmt,5))
                recipe.directions = String(cString:sqlite3_column_text(sqlite3_stmt,6))
                recipe.imgURL = String(cString:sqlite3_column_text(sqlite3_stmt,7))
                
                data.append(recipe)
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        return data
        
    }
    func deleteRecipeById(id:String){
        var sqlite3_stmt: OpaquePointer? = nil
        
        if (sqlite3_prepare_v2(database,"DELETE FROM RECIPES WHERE R_ID=?;",
                               -1,&sqlite3_stmt,nil) == SQLITE_OK){
            sqlite3_bind_text(sqlite3_stmt, 1, id,-1,nil);
            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("Successfully deleted")
            }
        }
        sqlite3_finalize(sqlite3_stmt)
    }
}
