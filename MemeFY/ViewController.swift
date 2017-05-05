//
//  ViewController.swift
//  MemeFY
//
//  Created by Admin on 4/6/17.
//  Copyright © 2017 c4idiots. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let memeTextAttributes: [String: Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: 2.0
    ]
    
    //MARK: Properties
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var memeTextField: UITextField!
    @IBOutlet weak var memeTopTextField: UITextField!
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memeTextField.delegate = self
        memeTextField.defaultTextAttributes = memeTextAttributes
        memeTextField.textAlignment = .center
        
        memeTopTextField.delegate = self
        memeTopTextField.defaultTextAttributes = memeTextAttributes
        memeTopTextField.textAlignment = .center
    }
    
    // MARK: ImagePicker Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image: \(info)")
        }
        
        memeImage.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: TextfieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if (textField.text?.isEmpty)! {
            if textField == memeTextField {
                textField.text = "BOTTOM"
            } else {
                textField.text = "TOP"
            }
        }
        
        return true
    }
    
    // MARK: generate Meme
    func generatedMemedImage() -> UIImage {
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
    // MARK: Actions
    @IBAction func pickAction(_ sender: UIBarButtonItem) {
        
        let controller = UIImagePickerController()
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func showMemeAction(_ sender: UIButton) {
    }
}

