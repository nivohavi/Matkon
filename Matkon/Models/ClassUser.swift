//
//  User.swift
//  
//
//  Created by Niv Ohavi on 03/01/2020.
//

import Foundation
import FirebaseDatabase

class ClassUser {
    var usersname: String?
    var email: String?
    var password: String?
    var photoUrl: String?
    var uid: String?

    init(usersname:String?,email:String?,password:String?, photoUrl:String?,uid:String?) {
        self.usersname = usersname
        self.email = email
        self.password = password
        self.photoUrl = photoUrl
        self.uid = uid
    }
    
    init(usersname:String?) {
        self.usersname = usersname
    }
    
    init(json:[String:Any]){
        self.usersname = json["usersname"] as? String;
        self.email = json["email"] as? String;
        self.password = json["password"] as? String;
        self.photoUrl = json["photoUrl"] as? String;
        self.uid = json["uid"] as? String;

    }
    
    init(withSnapshot: DataSnapshot) {
        let dict = withSnapshot.value as! [String:AnyObject]

        uid = withSnapshot.key
        usersname = dict["usersname"] as? String
        email = dict["email"] as! String
        password = dict["password"] as! String
        photoUrl = dict["photoUrl"] as! String
    }
}
