//
//  MemeGenViewController.swift
//  MemeFY
//
//  Created by Admin on 5/5/17.
//  Copyright © 2017 c4idiots. All rights reserved.
//

import UIKit

class MemeGenViewController: UIViewController {
    
    // MARK:- Properties
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var buttonButtomConstraint: NSLayoutConstraint!
    
    let customTextAttributes: [String: Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -8.0
    ]
    
    // MARK:- View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(keyboardWillShow(notification:)),
                         name: .UIKeyboardWillChangeFrame, object: nil)
    }
    
    // MARK:- View DId Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTextField.delegate = self
        topTextField.defaultTextAttributes = customTextAttributes
        topTextField.textAlignment = .center
        
        bottomTextField.delegate = self
        bottomTextField.defaultTextAttributes = customTextAttributes
        bottomTextField.textAlignment = .center
    }
    
    // MARK:- Actions
    @IBAction func picImageAction(_ sender: UIBarButtonItem) {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK:- destructor
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK:- Textfield Delegates
extension MemeGenViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK:- Keyboard handling
extension MemeGenViewController{
    func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let duration: TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
        let animationCurve = UIViewAnimationOptions(rawValue: animationCurveRaw)
        
        if (keyboardFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
            self.buttonButtomConstraint.constant = 0.0
        } else {
            self.buttonButtomConstraint.constant = keyboardFrame?.size.height ?? 0.0
        }
        
        UIView.animate(withDuration: duration,
                       delay: TimeInterval(0),
                       options: animationCurve,
                       animations: {self.view.layoutIfNeeded()},
                       completion: nil)
    }
}

// MARK:- ImagePicker delegates
extension MemeGenViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image: \(info)")
        }
        
        self.image.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}
