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
    
    var modelFirebase:ModelFirebaseStorage = ModelFirebaseStorage()


    private init(){}
    
    func saveImage(image:UIImage, callback: @escaping (String)->Void){
        ModelFirebaseStorage.saveImage(image: image, callback: callback)
    }
    
    func getCurrentTimestamp() -> String{
        ModelFirebaseStorage.getCurrentTimeStampWOMiliseconds(dateToConvert: NSDate.now as NSDate)
    }
    
}
