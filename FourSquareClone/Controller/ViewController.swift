//
//  ViewController.swift
//  FourSquareClone
//
//  Created by Ислам Пулатов on 6/10/23.
//

/*
 
 MARK: NOTES
    Save Evantialy saves when can do it
 
    But saveInBackGround saves and if internet not conncted it will show the Error
 /*
 func writeToServer() {
     
     let parseObject = PFObject(className: "Fruits")
     
     parseObject["name"] = "Banana"
     parseObject["calories"] = 200
     
     parseObject.saveInBackground { success, Error in
         
         if Error != nil {
             
             print(Error?.localizedDescription ?? "Unknown Error")
             
         } else {
             
             print("Uploded")
             
         }
         
     }
     
 }
 
 
 func readDataFromServer() {
     
     let query = PFQuery(className: "Fruits")
     
//        MARK: Filter the response
     
//        query.whereKey("name", equalTo: "apple")
     
//        query.whereKey("calories", greaterThan: 100)
     
     query.findObjectsInBackground { Objects, Error in
         
         if Error != nil{
             
             print(Error?.localizedDescription ?? "Unknown Error")
             
         } else {
             
             guard let objects = Objects else { return }
             
             for object in objects {
                 
                 
                 
             }
             
         }
         
     }
     
 }

  */

 */

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        
        
    }
    
//    MARK: - @IBAction

    @IBAction func signInButtonClicked(_ sender: Any) {
    
        if userNameTextField.text != "" && passwordTextField.text != "" {
            
            PFUser.logInWithUsername(inBackground: userNameTextField.text!, password: passwordTextField.text!) { user, Error in
                
                if Error != nil {
                    
                    self.makeAlert(title: "Error", message: Error?.localizedDescription ?? "Unknown Error")
                    
                } else {
                    
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                    
                }
                
                
            }
            
            
        } else {
            
            makeAlert(title: "Error", message: "First write your UserName/Password")
            
        }
        
    }
    
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        if userNameTextField.text != "" && passwordTextField.text != "" {
            
            let user = PFUser()
            
            user.username = userNameTextField.text!
            user.password = passwordTextField.text!
            
            
            user.signUpInBackground { success, Error in
                
                if Error != nil {
                    
                    self.makeAlert(title: "Error", message: Error?.localizedDescription ?? "Unknown Error")
                    
                } else {
                    
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                    
                    print("Create user!")
                    
                }
                
            }
            
            
        } else {
            
            
            makeAlert(title: "Error", message: "First write your UserName/Password")
            
        }
        
    }
    
//    MARK: - Functions
    
//    MARK: SetUpView
    
    func setUpView() {
            
        view.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        
        
    }
    
    
    func makeAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
    
    @objc func hideKeyboard() {
        
        view.endEditing(true)
        
    }
    
    
}

