//
//  ProfileViewController.swift
//  Matkon
//
//  Created by Niv Ohavi on 25/12/2019.
//  Copyright © 2019 Niv Ohavi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userEmail: UILabel!
    
    
    @IBAction func logout(_ sender: Any) {
        let error: String? = ModelFirebaseAuth.instance.signOutFirebase()
        if(error == nil){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initial = storyboard.instantiateInitialViewController()
            UIApplication.shared.keyWindow?.rootViewController = initial
        }
        else{
            let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userEmail = ModelFirebaseAuth.instance.getFIRUserEmail()
        self.userEmail.text = userEmail
    }

}
