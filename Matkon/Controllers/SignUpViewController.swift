//
//  SignUpViewController.swift
//  Matkon
//
//  Created by Niv Ohavi on 22/12/2019.
//  Copyright © 2019 Niv Ohavi. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    let fbAuth = ModelFirebaseAuth.instance;
    
    @IBAction func signUpAction(_ sender: Any) {
        
        if password.text != passwordConfirm.text {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            fbAuth.createUserFirebase(email: email.text!, password: password.text!) { (error: String?) in
              if error != nil{
                    let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
              }
              else {
                    self.performSegue(withIdentifier: "SignUpToLogin", sender: self)
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.isSecureTextEntry = true
        passwordConfirm.isSecureTextEntry = true
        self.indicatorView.hidesWhenStopped = true

    }
    
    
}
