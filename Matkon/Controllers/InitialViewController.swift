//
//  InitialViewController.swift
//  Matkon
//
//  Created by Niv Ohavi on 28/12/2019.
//  Copyright © 2019 Niv Ohavi. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        }
    override func viewDidAppear(_ animated: Bool) {
        if (ModelFirebaseAuth.instance.areUserLoggedIn()){
            let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TabBarViewController")
            tabBarVC.modalPresentationStyle = .fullScreen
            self.present(tabBarVC, animated: true, completion: nil)
            }
    }
        
}



