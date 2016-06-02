//
//  RegistrationViewController.swift
//  Onboarding
//
//  Created by Josh Broomberg on 2016/05/27.
//  Copyright © 2016 iXperience. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var emailField: EmailValidatedTextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtontapped(sender: UIButton) {
        
        let email = emailField.text!
        let password = passwordField.text!
        
        if !emailField.validate() {
            return
        }
        
        let (failureMessage, user) = UserController.sharedInstance.registerUser(email, newPassword: password)
        
        if let _ = user {
            print ("User registered")
            
            NSUserDefaults.standardUserDefaults().setValue(email, forKey: "userIdLoggedIn")
            NSUserDefaults.standardUserDefaults().setValue(password, forKey: "passwordLoggedIn")
            
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToLoggedInNavigationController()
        } else {
            if let message = failureMessage {
                print ("Failed to register user: \(message)")
            }
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
