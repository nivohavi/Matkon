//
//  ProfileViewController.swift
//  Matkon
//
//  Created by Niv Ohavi on 25/12/2019.
//  Copyright © 2019 Niv Ohavi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    var selectedImage:UIImage?

    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBAction func logout(_ sender: Any) {
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        let error: String? = ModelFirebaseAuth.instance.signOutFirebase()
        if(error == nil){
            self.spinner.isHidden = false
            self.spinner.startAnimating()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initial = storyboard.instantiateInitialViewController()
            UIApplication.shared.keyWindow?.rootViewController = initial
        }
        else{
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
            let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Make recipe image round (not suare)
        
        userImage.layer.cornerRadius = 10
        userImage.clipsToBounds = true
        userImage.layer.borderColor = UIColor.orange.cgColor
        userImage.layer.borderWidth = 1
        let userEmail = ModelFirebaseAuth.instance.getFIRUserEmail()
        self.userEmail.text = userEmail
        
        ModelFirebaseDB.instance.getImageUrlByEmail(userEmail: userEmail!) { (data) in
                if data?.email != nil
                {
                    self.userImage.sd_setImage(with: URL(string: data!.imgURL!), placeholderImage: UIImage(named: "placeholder.png"))
                }
            }
        

        self.spinner.isHidden = true
    }
    
    
    @IBAction func addImage(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.photoLibrary) {
           let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
           imagePicker.sourceType =
            UIImagePickerController.SourceType.photoLibrary;
           imagePicker.allowsEditing = true
           self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage;
        self.userImage.image = selectedImage;
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        ModelFirebaseDB.instance.getImageUrlByEmail(userEmail: self.userEmail.text!) { (data) in
            if data?.email != nil
            {
                Model.instance.saveImage(image: self.selectedImage!) {(url) in
                    ModelFirebaseDB.instance.updateUser(user: ClassUser(email: data?.email, imgURL: url, uid: data?.uid))
                    self.userImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"))
                    self.spinner.isHidden = true
                    self.spinner.stopAnimating()
                }
                
                
            }
            else
            {
                Model.instance.saveImage(image: self.selectedImage!) {(url) in
                    ModelFirebaseDB.instance.addUser(user:ClassUser(email: self.userEmail!.text, imgURL: url))
                    self.userImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"))
                    self.spinner.isHidden = true
                    self.spinner.stopAnimating()
                }

            }
        }
            dismiss(animated: true, completion: nil);
        }
        
                        
        
    }



