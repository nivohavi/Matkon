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

// Alerts
let passwordAlertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
//let errorAlertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
var errorAlertController: UIAlertController? = nil

let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

class SignUp2ViewController: UIViewController {

    let fbAuth = ModelFirebaseAuth.instance;
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    
    
    @IBAction func signUpActionButton(_ sender: Any) {
                if password.text != passwordConfirm.text {

            passwordAlertController.addAction(defaultAction)
            self.present(passwordAlertController, animated: true, completion: nil)
        }
        else{
            fbAuth.createUserFirebase(email: email.text!, password: password.text!) { (error: String?) in
              if error != nil{
                    errorAlertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                errorAlertController!.addAction(defaultAction)
                self.present(errorAlertController!, animated: true, completion: nil)
              }
              else {
                    print("User Signed Up Successfully !!!")
                // TBD - Should transfer to Login
                let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "Login2ViewController")
                
                // use back the old iOS 12 modal full screen style
                loginVC.modalPresentationStyle = .fullScreen
                    
                self.present(loginVC, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
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
