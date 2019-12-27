//
//  ProfileViewController.swift
//  Matkon
//
//  Created by Niv Ohavi on 25/12/2019.
//  Copyright © 2019 Niv Ohavi. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var userEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
        let user = Auth.auth().currentUser
        print(user?.email)
        self.userEmail.text = user?.email

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
