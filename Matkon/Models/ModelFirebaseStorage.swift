//
//  ModelFirebaseStorage.swift
//  Matkon
//
//  Created by Niv Ohavi on 07/01/2020.
//  Copyright © 2020 Niv Ohavi. All rights reserved.
//

import Foundation
import Firebase
import UIKit


class ModelFirebaseStorage {
    
    static func saveImage(image:UIImage, callback:@escaping (String)->Void){
        let storageRef = Storage.storage().reference(forURL:
            "gs://matkon-5d8d7.appspot.com")
        
        let data = image.jpegData(compressionQuality: 0.8)
        
        let imageName:String = "image" + String(self.getCurrentTimeStampWOMiliseconds(dateToConvert: NSDate())) + String(Int.random(in: 1..<99999999999));
        let imageRef = storageRef.child(imageName)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        imageRef.putData(data!, metadata: metadata) { (metadata, error) in
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    return
                }
                print("url: \(downloadURL)")
                callback(downloadURL.absoluteString)
            }
        }
    }
    
    static func getCurrentTimeStampWOMiliseconds(dateToConvert: NSDate) -> Int64 {
        let objDateformat: DateFormatter = DateFormatter()
        objDateformat.dateFormat = "yyyy-MM-dd"
        let strTime: String = objDateformat.string(from: dateToConvert as Date)
        let objUTCDate: NSDate = objDateformat.date(from: strTime)! as NSDate
        let milliseconds: Int64 = Int64(objUTCDate.timeIntervalSince1970)
        return milliseconds
    }
    
}
