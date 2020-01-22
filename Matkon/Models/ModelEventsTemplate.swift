//
//  ModelEventsTemplate.swift
//  Matkon
//
//  Created by Niv Ohavi on 22/01/2020.
//  Copyright © 2020 Niv Ohavi. All rights reserved.
//

import Foundation

class ModelEventsTemplate {
    let notificationName:String;
    
    init(name:String){
        notificationName = name;
    }
    func observe(callback:@escaping ()->Void)->Any{
        return NotificationCenter.default.addObserver(forName: NSNotification.Name(notificationName),object: nil, queue: nil) {(data) in
                callback();
        }
    }
    
    func post(){
        NotificationCenter.default.post(name: NSNotification.Name(notificationName), object: self,userInfo:nil);
    }

}
