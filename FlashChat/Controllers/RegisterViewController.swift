//
//  RegisterViewController.swift
//  FlashChat
//
//  Created by a-robota on 4/19/22.
//



import UIKit
import Firebase
class RegisterViewController: UIViewController {
    
    @IBOutlet var Email: UITextField!
    @IBOutlet var Pass: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = Email.text, let password = Pass.text {
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                // if error print results, else move to next view
                if let e = error {
                    print("Error in creating user (register view controler) \(e)")
                }
                else {
                    self.performSegue(withIdentifier: "Register", sender: self)
                }
            }
        }
        }
        
    }
