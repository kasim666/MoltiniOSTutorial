//
//  ViewController.swift
//  iStoreApp
//
//  Created by Zaiyang Li on 01/11/2016.
//  Copyright © 2016 Zaiyang Li. All rights reserved.
//

import UIKit
import Moltin

class LoginController: UIViewController {
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.addTarget(self, action: #selector(doLogin), for: .touchUpInside)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func doLogin(sender: UIButton) -> Void
    {
        let email = emailField.text!
        let password = passwordField.text!
        Moltin.sharedInstance().customer.login(withEmail: email, andPassword: password, success: { (response: [AnyHashable : Any]?) in
            self.showAlert(title: "Success", message: "Successfully logged you in.")
            if(response != nil){
                let result = response?["result"] as! Dictionary<String, Any>
                UserDefaults.standard.set(result["token"],forKey:"customerToken")
                UserDefaults.standard.synchronize()
            }
            let navigationController =
                self.storyboard?.instantiateViewController(withIdentifier: "RootNavigationController")
            UIApplication.shared.keyWindow?.rootViewController = navigationController
            
        }) { (response: [AnyHashable : Any]?, error: Error?) in
            self.showAlert(title: "Can't log you in", message: "Email/Password combination is not found.")
        }
    }
    func showAlert(title: String, message: String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

