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
UINavigationControllerDelegate {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UITextField!
    @IBOutlet weak var recipeDescription: UITextField!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var recipeIngredients: UITextField!
    @IBOutlet weak var directionsLabel: UILabel!
    @IBOutlet weak var recipeDirections: UITextField!
    @IBOutlet weak var myScroll: UIScrollView!
    @IBOutlet weak var submitButtonOutlet: UIBarButtonItem!
    var recipeCategory: String?
    var selectedImage:UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        myScroll.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+300)
        recipeName.layer.backgroundColor = UIColor.white.cgColor
        recipeName.layer.borderColor = UIColor.gray.cgColor
        recipeName.layer.borderWidth = 0.0
        recipeName.layer.cornerRadius = 5
        recipeName.layer.masksToBounds = false
        recipeName.layer.shadowRadius = 2.0
        recipeName.layer.shadowColor = UIColor.black.cgColor
        //recipeName.layer.shadowOffset = CGSizeMake(1.0, 1.0)
        recipeName.layer.shadowOpacity = 1.0
        recipeName.layer.shadowRadius = 1.0

        // Do any additional setup after loading the view.
        recipeName.placeholder = "Enter Recipe Name"
        recipeDescription.placeholder = "Enter yout recipe description here..."
        recipeIngredients.placeholder = "Enter the recipeDirections"
        recipeDirections.placeholder = "Enter yout recipe directions of coocking..."
    }
    
    @IBAction func submitButton(_ sender: Any)
    {
        if let image = selectedImage{
            Model.instance.saveImage(image: image)
            { (url) in
                print("saved image url \(url)");
                let r = Recipe(name: self.recipeName.text!,createdBy: ModelFirebaseAuth.instance.getFIRUserEmail()! ,category: self.recipeCategory!, description:
                    self.recipeDescription.text!, ingredientsJson: self.recipeIngredients.text!, directions: self.recipeDirections.text!, imgURL: url)
                        ModelFirebaseDB.instance.add(recipe: r);
                    // Need to Hide the 'Submit' button
                    self.navigationController?.popViewController(animated: true);
            }
        }
    }

    
    @IBAction func takePic(_ sender: UIButton) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
