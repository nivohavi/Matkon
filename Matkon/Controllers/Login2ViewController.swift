//
//  Login2ViewController.swift
//  Matkon
//
//  Created by Niv Ohavi on 28/12/2019.
//  Copyright © 2019 Niv Ohavi. All rights reserved.
//

import UIKit




class Login2ViewController: UIViewController {
    
    let fbAuth = ModelFirebaseAuth.instance;
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //
    // Back button - Action
    //
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //
    // Login button - Action
    //
    @IBAction func loginActionButton(_ sender: Any) {
        fbAuth.signInFirebase(email: emailTextField.text!, password: passwordTextField.text!) { (error: String?) in
          if error != nil{
                let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
          }
          else {
                //self.performSegue(withIdentifier: "LoginToHome", sender: self)
            let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TabBarViewController")
            
            // use back the old iOS 12 modal full screen style
            tabBarVC.modalPresentationStyle = .fullScreen
                
            self.present(tabBarVC, animated: true, completion: nil)
            print("Logged In Successfully !!!")

            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
        emailTextField.placeholder = "Email"
        emailTextField.textAlignment = .center
        passwordTextField.placeholder = "Password"
        passwordTextField.textAlignment = .center


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
