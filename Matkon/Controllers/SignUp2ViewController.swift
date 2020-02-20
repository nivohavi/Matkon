//
//  SignUp2ViewController.swift
//  Matkon
//
//  Created by Niv Ohavi on 29/12/2019.
//  Copyright © 2019 Niv Ohavi. All rights reserved.
//

import UIKit


let storyboard = UIStoryboard(name: "Main", bundle: nil)
let viewController = storyboard.instantiateViewController(identifier: "Login2ViewController")

let passwordAlertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)

var errorAlertController: UIAlertController? = nil

let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

class SignUp2ViewController: UIViewController {

    let fbAuth = ModelFirebaseAuth.instance;
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBAction func dismissEmail(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func dismissPassword(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func dismissConfirm(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpActionButton(_ sender: Any) {
        self.spinner.isHidden = false
        self.spinner.startAnimating()
                if password.text != passwordConfirm.text {

            passwordAlertController.addAction(defaultAction)
            self.present(passwordAlertController, animated: true, completion: nil)
        }
        else{
            fbAuth.createUserFirebase(email: email.text!, password: password.text!) { (error: String?) in
              if error != nil{
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
                    errorAlertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                errorAlertController!.addAction(defaultAction)
                self.present(errorAlertController!, animated: true, completion: nil)
              }
              else {
                    print("User Signed Up Successfully !!!")

                let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "Login2ViewController")
                loginVC.modalPresentationStyle = .fullScreen
                    
                self.present(loginVC, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spinner.isHidden = true
        email.placeholder = "Email"
        email.textAlignment = .center
        password.placeholder = "Password"
        password.isSecureTextEntry = true
        password.textAlignment = .center
        passwordConfirm.placeholder = "Password"
        passwordConfirm.isSecureTextEntry = true
        passwordConfirm.textAlignment = .center

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

}
