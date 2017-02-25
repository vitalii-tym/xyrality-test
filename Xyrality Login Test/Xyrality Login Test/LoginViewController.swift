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
    
    var aNetworkRequest: NetworkRequest?
    
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
        
        let payloadForWorlds = xyralityAPICalls.worlds.generatePayload(login: textFieldEmail.text!, password: textFieldPassword.text!)
        
        aNetworkRequest = NetworkRequest()

        aNetworkRequest?.getData(forURL: xyralityAPICalls.worlds.URL(), method: xyralityAPICalls.worlds.method(), payload: payloadForWorlds) { (data, response, error) -> Void in
            if error == nil && data != nil {
                if let theResponse = response as? HTTPURLResponse {
                    if theResponse.statusCode == 200 {
                        if let worldsList = xyralityWorldsList.init(data: data!),
                           let worldsListVC = UIStoryboard(name: "WorldsList", bundle: nil).instantiateViewController(withIdentifier: "initialWorldsList") as? WorldsListViewController {
                                worldsListVC.worldsList = worldsList
                                self.present(worldsListVC, animated: true)
                        } else if let isItAnError = xyralityError.init(data: data!) {
                            print("There was an error")
                        } else {
                            print("the received data is neither worlds list, not an error")
                        }
                    } else {
                        print("Error: \(theResponse.statusCode)")
                        // TODO: tell the user there was an error
                    }
                } else {
                    () // TODO: Looks like there was a malformed response from server
                }
            } else {
                () // TODO: Let user know there was a network problem
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        textFieldPassword.removeTarget(self, action: #selector(validateCredentialsAndEnableLogin), for: .valueChanged)
        textFieldEmail.removeTarget(self, action: #selector(validateCredentialsAndEnableLogin), for: .valueChanged)
        self.aNetworkRequest?.cancelSession()
        
        super.viewWillDisappear(animated)
    }
}
