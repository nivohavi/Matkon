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
    let modelSQL = ModelCacheSQL()
    
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
                    ModelEvents.ReloadRecipesData.post()
                    print("Document added with ID: \(ref!.documentID)")
                    db.collection("recipes").document(ref!.documentID).setData(["id" : ref!.documentID], merge: true)
                    
            }
        })
    }
    
    
    func addUser(user:ClassUser){
        let db = Firestore.firestore()
        
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: user.toJson(), completion: { err in
                if let err = err
                {
                    print("Error adding document: \(err)")
                }
                else
                {
                    db.collection("users").document(ref!.documentID).setData(["uid" : ref!.documentID], merge: true)
                    print("Document added with ID: \(ref!.documentID)")
            }
        })
    }
    
    
    
    func updateUser(user: ClassUser){
        let db = Firestore.firestore()
        db.collection("users").document(user.uid!).updateData([
            "imgURL": user.imgURL!
            ])
            { err in
                  if let err = err {
                      print("Error updating document: \(err)")
                  } else {
                    ModelEvents.ReloadRecipesData.post()
                      print("Document successfully updated!")
                  }
              };
    }

    func getRecipesByCategory(since: Int64, categoryToQuery: String?, callback: @escaping ([Recipe]?)->Void){
        let db = Firestore.firestore()
        db.collection("recipes").order(by: "timestamp").start(at: [Timestamp(seconds: since, nanoseconds: 0)]).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                callback(nil);
            } else {
                var data = [Recipe]();
                for document in querySnapshot!.documents {
                    data.append(Recipe(json: document.data()));
                }
                callback(data);
            }
        };
    }
    
    func getAllRecipes(since:Int64, callback: @escaping ([Recipe]?)->Void){
        let db = Firestore.firestore()
        db.collection("recipes").order(by: "timestamp").start(at: [Timestamp(seconds: since, nanoseconds: 0)]).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                callback(nil);
            } else {
                var data = [Recipe]();
                for document in querySnapshot!.documents {
                    data.append(Recipe(json: document.data()));
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
                    data.append(Recipe(json: document.data()));
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
                let data = Recipe(json: document.data()!)
                callback(data)
             } else {
                print("Document does not exist")
                callback(nil)
             }
        };
    }
    
    func getImageUrlByEmail(userEmail: String, callback: @escaping (ClassUser?)->Void){
        let db = Firestore.firestore()
        db.collection("users").whereField("email", isEqualTo: userEmail).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                callback(nil);
            } else {
                let data = ClassUser()
                for document in querySnapshot!.documents {
                    data.email = document.data()["email"] as? String
                    data.imgURL = document.data()["imgURL"] as? String
                    data.uid = document.data()["uid"] as? String
                }
                callback(data);
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
                ModelEvents.ReloadRecipesData.post()
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
            "imgURL": recipe.imgURL,
            "timestamp": FieldValue.serverTimestamp()
            ])
            { err in
                  if let err = err {
                      print("Error updating document: \(err)")
                  } else {
                    ModelEvents.ReloadRecipesData.post()
                      print("Document successfully updated!")
                  }
              };
    }
 
}
