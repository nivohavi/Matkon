//
//  ModelFirebaseAuth.swift
//  Matkon
//
//  Created by Niv Ohavi on 27/12/2019.
//  Copyright © 2019 Niv Ohavi. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class ModelFirebaseAuth{
    static let instance = ModelFirebaseAuth()
    
    private init (){
    }
    
    func signInFirebase(email: String,password: String, callback: @escaping (String?) -> ()) {
      Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
        if(error == nil) {
            callback(nil)
        }
        else{callback(error!.localizedDescription)}
      }
    }
    
    func signOutFirebase() -> String?{
        do{
            try Auth.auth().signOut()
            }
        catch{
            return "Error signing Out..."
        }
        return nil
    }
    
    func getFIRUserEmail() -> String?{
        return Auth.auth().currentUser?.email
    }
    
    func getFIRUserID() -> String?{
        return Auth.auth().currentUser?.uid
    }
    
    func getCurrentUserInfo() -> User?{
        let user = Auth.auth().currentUser
        return user
    }
    
    func createUserFirebase(email: String,password: String, callback: @escaping (String?) -> ()) {
      Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
        if(error == nil)
        {
            callback(nil)
        }
        else
        {
            callback(error!.localizedDescription)
        }
      }
    }
    
    func areUserLoggedIn() -> Bool{
        if (Auth.auth().currentUser != nil){
            return true
        }
        return false
    }
}
