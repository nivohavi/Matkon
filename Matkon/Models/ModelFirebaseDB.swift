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
    
    // Singelton
    private init (){
    }
    
    func add(recipe:Recipe){
        let db = Firestore.firestore()
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("recipes").addDocument(data: recipe.toJson(), completion: { err in
                if let err = err
                {
                    print("Error adding document: \(err)")
                }
                else
                {
                    print("Document added with ID: \(ref!.documentID)")
                    
                    // Add the auto generated ID field for .this document
                    db.collection("recipes").document(ref!.documentID).setData(["id" : ref!.documentID], merge: true)
                    // Add timestamp to the post
                    db.collection("recipes").document(ref!.documentID).setData(["timestamp" : Model.instance.getCurrentTimestamp()], merge: true)
            }
        })
        ModelEvents.ReloadRecipesData.post()
    }
    
    func getCurrentUserInfo() -> User?{
        let user = Auth.auth().currentUser
        return user
    }

    func getRecipesByCategory(categoryToQuery: String?, callback: @escaping ([Recipe]?)->Void){
        let db = Firestore.firestore()
        db.collection("recipes").whereField("category", isEqualTo: categoryToQuery).getDocuments() { (querySnapshot, err) in
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
    
    func registerNewUserToRealtimeDB(email:String?) -> Void{
        let currentUserId = ModelFirebaseAuth.instance.getFIRUserID()
        let userAttrs = ["email": email]
        let ref = Database.database().reference().child("users").child(currentUserId!)
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }}
    }
    
    
}
