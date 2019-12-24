//
//  LoginViewController.swift
//  Matkon
//
//  Created by Niv Ohavi on 22/12/2019.
//  Copyright © 2019 Niv Ohavi. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    
    @IBAction func loginAction(_ sender: Any)
    {
        self.indicatorView.startAnimating()
        Auth.auth().signIn(withEmail: email.text!, password: password.text!)
        { (user, error) in
            if error == nil
            {
                self.performSegue(withIdentifier: "LoginToHome", sender: self)
            }
            else
            {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                self.indicatorView.stopAnimating()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorView.hidesWhenStopped = true
        
        
        // Do any additional setup after loading the view.
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
