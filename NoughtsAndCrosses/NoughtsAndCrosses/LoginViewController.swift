//
//  LoginViewController.swift
//  Onboarding
//
//  Created by Josh Broomberg on 2016/05/27.
//  Copyright © 2016 iXperience. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log in"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        let loginResult = UserController.sharedInstance.loginUser(username, suppliedPassword: password)
        
        let (failure_message, user) = loginResult
        
        if let _ = user {
            print ("User logged in")
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToLoggedInNavigationController()
        } else {
            if let failure_message = failure_message {
                print ("Failed to login user: \(failure_message)")
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
