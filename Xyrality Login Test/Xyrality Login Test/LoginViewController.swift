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
    
    @IBAction func actionLogin(_ sender: UIButton) {
        login()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textFieldPassword.addTarget(self, action: #selector(validateCredentialsAndEnableLogin), for: .allEvents)
        textFieldEmail.addTarget(self, action: #selector(validateCredentialsAndEnableLogin), for: .allEvents)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if (textField.returnKeyType == UIReturnKeyType.next) && textField === textFieldEmail {
            textFieldEmail.resignFirstResponder()
            textFieldPassword.becomeFirstResponder()
        } else if (textField.returnKeyType == UIReturnKeyType.done) && textField === textFieldPassword {
            textFieldPassword.resignFirstResponder()
            login()
        } else {
            print("unexpected KeyType and textField pair. Check the advancing functionality on login screen")
        }
        return false
    }
    
    func validateCredentialsAndEnableLogin() {
        if let emailString = textFieldEmail.text, !emailString.isEmpty,
            let passwordString = textFieldPassword.text, !passwordString.isEmpty,
            emailString.contains("@") && emailString.contains(".") {
            buttonLogin.isEnabled = true
        } else {
            buttonLogin.isEnabled = false
        }
    }
    
    func login() {
        present( UIStoryboard(name: "WorldsList", bundle: nil).instantiateViewController(withIdentifier: "initialWorldsList") as UIViewController, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        textFieldPassword.removeTarget(self, action: #selector(validateCredentialsAndEnableLogin), for: .valueChanged)
        textFieldEmail.removeTarget(self, action: #selector(validateCredentialsAndEnableLogin), for: .valueChanged)
        
        super.viewWillDisappear(animated)
    }
}
