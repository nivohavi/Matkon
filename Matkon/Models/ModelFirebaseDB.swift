//
//  ModelFirebaseDB.swift
//  Matkon
//
//  Created by Niv Ohavi on 01/01/2020.
//  Copyright © 2020 Niv Ohavi. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class ModelFirebaseDB{
    
    static let instance = ModelFirebaseDB()
    
    private init (){
    }
    
    func add(recipe:Recipe){
        let db = Firestore.firestore()
        
        var ref: DocumentReference? = nil
        ref = db.collection("recipes").addDocument(data: recipe.toJson(), completion: { err in
                if let err = err
                {
                    print("Error adding document: \(err)")
                }
                else
                {
                    print("Document added with ID: \(ref!.documentID)")
                    
                    db.collection("recipes").document(ref!.documentID).setData(["id" : ref!.documentID], merge: true)
                    db.collection("recipes").document(ref!.documentID).setData(["timestamp" : Model.instance.getCurrentTimestamp()], merge: true)
            }
        })
        ModelEvents.ReloadRecipesData.post()
    }

    func getRecipesByCategory(categoryToQuery: String?, callback: @escaping ([Recipe]?)->Void){
        let db = Firestore.firestore()
        db.collection("recipes").whereField("category", isEqualTo: categoryToQuery!).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                callback(nil);
            } else {
                var data = [Recipe]();
                for document in querySnapshot!.documents {
                    data.append(Recipe(json: document.data() as! [String : String]));
                }
                callback(data);
            }
        };
    }
    
    
    func getAllRecipes(callback: @escaping ([Recipe]?)->Void){
        let db = Firestore.firestore()
        db.collection("recipes").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                callback(nil);
            } else {
                var data = [Recipe]();
                for document in querySnapshot!.documents {
                    data.append(Recipe(json: document.data() as! [String : String]));
                }
                callback(data);
            }
        };
    }
    
    func getUserRecipes(callback: @escaping ([Recipe]?)->Void){
        let db = Firestore.firestore()
        let userEmail = ModelFirebaseAuth.instance.getFIRUserEmail()
        db.collection("recipes").whereField("createdBy", isEqualTo: userEmail!).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                callback(nil);
            } else {
                var data = [Recipe]();
                for document in querySnapshot!.documents {
                    data.append(Recipe(json: document.data() as! [String : String]));
                }
                callback(data);
            }
        };
    }
    
    func getRecipeById(recipeId: String, callback: @escaping (Recipe?)->Void){
        let db = Firestore.firestore()
        db.collection("recipes").document(recipeId).getDocument {
            (document, error) in
            if let document = document, document.exists {
                let data = Recipe(json: document.data() as! [String : String])
                callback(data)
             } else {
                print("Document does not exist")
                callback(nil)
             }
        };
    }
   
    func deleteRecipeById(recipeId: String) {
        let db = Firestore.firestore()
        db.collection("recipes").document(recipeId).delete() {
            err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        };
    }
    
    func updateRecipe(recipe: Recipe){
        let db = Firestore.firestore()
        db.collection("recipes").document(recipe.id).updateData([
            "name": recipe.name,
            "description": recipe.description,
            "ingredientsJson": recipe.ingredientsJson,
            "directions": recipe.directions,
            "imgURL": recipe.imgURL
            ])
            { err in
                  if let err = err {
                      print("Error removing document: \(err)")
                  } else {
                      print("Document successfully removed!")
                  }
              };
    }
 
}
