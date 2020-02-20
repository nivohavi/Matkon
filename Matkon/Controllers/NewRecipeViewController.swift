//
//  NewRecipeViewController.swift
//  Matkon
//
//  Created by Niv Ohavi on 01/01/2020.
//  Copyright © 2020 Niv Ohavi. All rights reserved.
//

import UIKit

class NewRecipeViewController: UIViewController,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UITextField!
    @IBOutlet weak var recipeDescription: UITextField!
    @IBOutlet weak var ingredientsLabel: UILabel!

    @IBOutlet weak var directionsLabel: UILabel!
    @IBOutlet weak var myScroll: UIScrollView!
    @IBOutlet weak var submitButtonOutlet: UIBarButtonItem!
    
    @IBOutlet weak var directionsTextView: UITextView!
    @IBOutlet weak var ingTextView: UITextView!
    var recipeCategory: String?
    var selectedImage:UIImage?

    @IBAction func dismissRecipeName(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func dismissRecipeDisc(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func dismissIng(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func dismissDirections(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Please enter your input..." {
            textView.text = ""
            textView.textColor = UIColor.black
            textView.font = UIFont(name: "verdana", size: 18.0)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Please enter your input..."
            textView.textColor = UIColor.lightGray
            textView.font = UIFont(name: "verdana", size: 13.0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        directionsTextView.text = "Please enter your input..."
        directionsTextView.textColor = UIColor.lightGray
        directionsTextView.font = UIFont(name: "verdana", size: 13.0)
        directionsTextView.returnKeyType = .done
        directionsTextView.delegate = self
        ingTextView.text = "Please enter your input..."
        ingTextView.textColor = UIColor.lightGray
        ingTextView.font = UIFont(name: "verdana", size: 13.0)
        ingTextView.returnKeyType = .done
        ingTextView.delegate = self
        
        
        myScroll.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+300)

        recipeName.placeholder = "Enter Recipe Name"
        recipeDescription.placeholder = "Enter yout recipe description here..."

    
    }
    
    @IBAction func submitButton(_ sender: Any)
    {
        
        if let image = selectedImage{
            self.submitButtonOutlet.isEnabled = false
            Model.instance.saveImage(image: image)
            { (url) in
                print("saved image url \(url)");
                let r = Recipe(name: self.recipeName.text!, createdBy: ModelFirebaseAuth.instance.getFIRUserEmail()! ,category: self.recipeCategory!, description: self.recipeDescription.text!, ingredientsJson: self.ingTextView.text!, directions: self.directionsTextView.text!, imgURL: url,timestamp: 9999999999999999)
                        ModelFirebaseDB.instance.add(recipe: r);
                    self.navigationController?.popViewController(animated: true);
            }
        }
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
        self.recipeImage.image = selectedImage;
        dismiss(animated: true, completion: nil);
    }

}
