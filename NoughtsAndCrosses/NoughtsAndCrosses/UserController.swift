//
//  UserManager.swift
//  Onboarding
//
//  Created by Josh Broomberg on 2016/05/28.
//  Copyright © 2016 iXperience. All rights reserved.
//

import Foundation

class UserController {
    class var sharedInstance: UserController {
        struct Static {
            static var instance:UserController?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token)    {
            Static.instance = UserController()
        }
        return Static.instance!
    }
    
    struct User {
        var email: String
        var password: String
    }
    
    private var users: [User] = []
    
    var logged_in_user: User?
    
    func registerUser(newEmail: String, newPassword: String) -> (failureMessage: String?, user: User?) {
        for user in users {
            if user.email == newEmail {
                return ("Username taken", nil)
            }
        }
        let user = User(email: newEmail, password: newPassword)
        users.append(user)
        logged_in_user = user
        print("User with email: \(newEmail) has been registered by the UserManager.")
        return (nil, user)
    }
    
    func loginUser(suppliedUsername: String, suppliedPassword: String) -> (failureMessage: String?, user: User?){
        
        for user in users {
            if user.email == suppliedUsername {
                if user.password == suppliedPassword {
                    logged_in_user = user
                    print("User with email: \(suppliedUsername) has been logged in by the UserManager.")
                    return (nil, user)
                } else {
                    return ("Password incorrect", nil)
                }
            }
        }
        
        return ("No user with that email", nil)
    }
    
    func setCurrentUserId(email:String, password:String) {
        
        let user = User(email: email, password: password)
        users.append(user)
        logged_in_user = user
        
    }
    
}
