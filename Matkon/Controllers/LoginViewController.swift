//
//  LoginViewController.swift
//  Matkon
//
//  Created by Niv Ohavi on 22/12/2019.
//  Copyright © 2019 Niv Ohavi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let fbAuth = ModelFirebaseAuth.instance;
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func loginAction(_ sender: Any)
    {
        self.indicatorView.startAnimating()
        fbAuth.signInFirebase(email: email.text!, password: password.text!) { (error: String?) in
          if error != nil{
                let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
          }
          else {
                self.performSegue(withIdentifier: "LoginToHome", sender: self)

            }
        }
        self.indicatorView.stopAnimating()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.isSecureTextEntry = true
        indicatorView.hidesWhenStopped = true
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
