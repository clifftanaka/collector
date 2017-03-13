//
//  MainViewController.swift
//  Collector
//
//  Created by Cliff Tanaka on 2017/03/10.
//  Copyright © 2017 kurifu. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!

    var imagePicker = UIImagePickerController()
    var item : ItemEntity? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        
        if item != nil {
            imageView.image = UIImage(data: item!.image! as Data)
            titleTextField.text = item!.title!
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)

    }
    
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        if item != nil {
            item!.title = titleTextField.text!
            item!.image = UIImagePNGRepresentation(imageView.image!) as NSData?
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let item = ItemEntity(context: context)
            item.title = titleTextField.text!
            item.image = UIImagePNGRepresentation(imageView.image!) as NSData?

        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(item!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
}
