//
//  Login2ViewController.swift
//  Matkon
//
//  Created by Niv Ohavi on 28/12/2019.
//  Copyright © 2019 Niv Ohavi. All rights reserved.
//

import UIKit
import Firebase




class Login2ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBAction func dismissEmail(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func dismissPassword(_ sender: UITextField) {
        sender.resignFirstResponder()
    }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func loginActionButton(_ sender: Any) {
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        ModelFirebaseAuth.instance.signInFirebase(email: emailTextField.text!, password: passwordTextField.text!) { (error: String?) in
          if error != nil{
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
                let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
          }
          else {
            let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TabBarViewController")
            
            tabBarVC.modalPresentationStyle = .fullScreen
                
            self.present(tabBarVC, animated: true, completion: nil)

            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spinner.isHidden = true
        passwordTextField.isSecureTextEntry = true
        emailTextField.placeholder = "Email"
        emailTextField.textAlignment = .center
        passwordTextField.placeholder = "Password"
        passwordTextField.textAlignment = .center
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

}
