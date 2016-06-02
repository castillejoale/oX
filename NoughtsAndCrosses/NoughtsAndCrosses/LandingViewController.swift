//
//  AuthorisationMenuViewController.swift
//  Onboarding
//
//  Created by Josh Broomberg on 2016/05/27.
//  Copyright © 2016 iXperience. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Auth Menu"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        self.navigationController?.pushViewController(LoginViewController(nibName: "LoginViewController", bundle: nil), animated: true)
    }

    @IBAction func registerButtonTapped(sender: UIButton) {
        self.navigationController?.pushViewController(RegistrationViewController(nibName: "RegistrationViewController", bundle: nil), animated: true)
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
