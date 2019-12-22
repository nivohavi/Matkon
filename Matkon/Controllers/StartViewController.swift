//
//  StartViewController.swift
//  Matkon
//
//  Created by Niv Ohavi on 22/12/2019.
//  Copyright © 2019 Niv Ohavi. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    
    @IBAction func loginButton(_ sender: Any) {
        performSegue(withIdentifier: "LoginViewController", sender: sender)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        performSegue(withIdentifier: "SignUpViewController", sender: sender)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
