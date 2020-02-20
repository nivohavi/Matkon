//
//  EditRecipeViewController.swift
//  Matkon
//
//  Created by Niv Ohavi on 17/02/2020.
//  Copyright © 2020 Niv Ohavi. All rights reserved.
//

import UIKit
import SDWebImage

class EditRecipeViewController: UIViewController,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,UITextViewDelegate {

    @IBOutlet weak var directionsTextView: UITextView!
    @IBOutlet weak var ingTextView: UITextView!
    @IBOutlet weak var recipeName: UITextField!
    @IBOutlet weak var recipeDescription: UITextField!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var myScroll: UIScrollView!
    @IBOutlet weak var editButtonOutlet: UIBarButtonItem!
    var recipe:Recipe?
    var selectedImage:UIImage?
    
    @IBAction func dismissName(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func dismissDesc(_ sender: UITextField) {
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

        myScroll.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+300)

        directionsTextView.returnKeyType = .done
        directionsTextView.delegate = self

        ingTextView.returnKeyType = .done
        ingTextView.delegate = self
        self.recipeName.text = self.recipe?.name
        self.recipeDescription.text = self.recipe?.description
        self.directionsTextView.text = self.recipe?.directions
        self.ingTextView.text = self.recipe?.ingredientsJson
        self.recipeImage.sd_setImage(with: URL(string: self.recipe!.imgURL), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    @IBAction func editRecipe(_ sender: Any) {
        if let image = selectedImage{
                  self.editButtonOutlet.isEnabled = false
                  Model.instance.saveImage(image: image)
                  { (url) in
                      print("saved image url \(url)");
                    let r = Recipe(id: self.recipe!.id, name: self.recipeName.text!, createdBy: ModelFirebaseAuth.instance.getFIRUserEmail()! ,category: self.recipe!.category, description: self.recipeDescription.text!, ingredientsJson: self.ingTextView.text!, directions: self.directionsTextView.text!, imgURL: url,timestamp: 9999999999999999)
                              ModelFirebaseDB.instance.updateRecipe(recipe: r);
                          self.navigationController?.popViewController(animated: true);
                  }
              }
        else {
            self.editButtonOutlet.isEnabled = false
            let r = Recipe(id: self.recipe!.id ,name: self.recipeName.text!, createdBy: ModelFirebaseAuth.instance.getFIRUserEmail()! ,category: self.recipe!.category, description: self.recipeDescription.text!, ingredientsJson: self.ingTextView.text!, directions: self.directionsTextView.text!, imgURL: recipe!.imgURL,timestamp: 9999999999999999)
                ModelFirebaseDB.instance.updateRecipe(recipe: r);
            self.navigationController?.popViewController(animated: true);
        }
    }
    
    
    @IBAction func editImage(_ sender: Any) {
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
    
    @IBAction func deleteRecipe(_ sender: Any) {
        ModelFirebaseDB.instance.deleteRecipeById(recipeId: self.recipe!.id)
        Model.instance.deleteRecipeById(id: self.recipe!.id)
        ModelEvents.ReloadRecipesData.post()
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage;
        self.recipeImage.image = selectedImage;
        dismiss(animated: true, completion: nil);
    }
}
