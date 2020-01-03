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
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
        })
    }
    
    func getCurrentUserInfo() -> DatabaseReference{
        var userRef: DatabaseReference?
        if let user = Auth.auth().currentUser {
            // 2
            let rootRef = Database.database().reference()
            // 3
            userRef = rootRef.child("users").child(user.uid)
            
            // 4 read from database with userRef
        }
        return userRef!
    }
    
    func test(){
        if let user = Auth.auth().currentUser {
            // 2
            let rootRef = Database.database().reference()
            // 3
            let userRef = rootRef.child("users").child(user.uid)

            // 4 read from database with userRef
        }
    }
    
    
    func getAllStudents(callback: @escaping ([Recipe]?)->Void){
        let db = Firestore.firestore()
        db.collection("recipes").getDocuments { (querySnapshot, err) in
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
    
    
    
//    func getCategorieRecipesList(callback: @escaping ([Recipe]?)->Void){
//        let db = Firestore.firestore()
//        db.collection("recipes").getDocuments { (querySnapshot, err) in
//            if let err = err
//            {
//                print("Error getting documents: \(err)")
//                callback(nil);
//            }
//            else
//            {
//                var data = [Recipe]();
//                for document in querySnapshot!.documents
//                {
//                    let json = try? JSONSerialization.jsonObject(with: document.data(), options: [])
//                    let documentCategorie = document.data()["categorie"]
//                    let requestedCategorie = "German"
//                    if let isEqual = (String(documentCategorie) == requestedCategorie)
//                    {
//                        data.append(Recipe(json: document.data()));
//                    }
//                }
//                callback(data);
//            }
//        };
//    }
}
