//
//  User.swift
//  
//
//  Created by Niv Ohavi on 03/01/2020.
//

import Foundation
import FirebaseDatabase

class ClassUser {
    var email: String?
    var imgURL: String?
    var uid: String?


    init() {}
    
    init(email:String?, imgURL:String?,uid:String?) {
        self.email = email
        self.imgURL = imgURL
        self.uid = uid

    }
    init(email:String?, imgURL:String?) {
        self.email = email
        self.imgURL = imgURL
        self.uid = ""

    }
    
    
    init(json:[String:Any]){
        self.email = json["email"] as? String;
        self.imgURL = json["imgURL"] as? String;
        self.uid = json["uid"] as? String;


    }
    
    init(withSnapshot: DataSnapshot) {
        let dict = withSnapshot.value as! [String:AnyObject]

        email = dict["email"] as! String
        imgURL = dict["imgURL"] as! String
        uid = dict["uid"] as! String;

    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]();
        json["email"] = email
        json["imgURL"] = imgURL
        json["uid"] = uid

        return json
    }
}
