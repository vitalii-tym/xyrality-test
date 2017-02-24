//
//  ViewController.swift
//  Xyrality Login Test
//
//  Created by Vitaliy Tim on 2/24/17.
//  Copyright © 2017 Vitaliy Timoshenko. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if (textField.returnKeyType == UIReturnKeyType.next) && textField === textFieldEmail {
                textFieldEmail.resignFirstResponder()
                textFieldPassword.becomeFirstResponder()
        } else if (textField.returnKeyType == UIReturnKeyType.done) && textField === textFieldPassword {

            // TODO: Continue with the login process

        } else {
            print("unexpected KeyType and textField pair. Check the advancing functionality on login screen")
        }
        
        return true
    }
    
}

