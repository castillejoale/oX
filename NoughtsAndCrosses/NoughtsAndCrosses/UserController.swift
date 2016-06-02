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
        var username: String
        var password: String
    }
    
    private var users: [User] = []
    
    var logged_in_user: User?
    
    func registerUser(newUsername: String, newPassword: String) -> (failureMessage: String?, user: User?) {
        for user in users {
            if user.username == newUsername {
                return ("Username taken", nil)
            }
        }
        let user = User(username: newUsername, password: newPassword)
        users.append(user)
        logged_in_user = user
        print("User with username: \(newUsername) has been registered by the UserManager.")
        return (nil, user)
    }
    
    func loginUser(suppliedUsername: String, suppliedPassword: String) -> (failureMessage: String?, user: User?){
        for user in users {
            if user.username == suppliedUsername {
                if user.password == suppliedPassword {
                    logged_in_user = user
                    print("User with username: \(suppliedUsername) has been logged in by the UserManager.")
                    return (nil, user)
                } else {
                    return ("Password incorrect", nil)
                }
            }
        }
        
        return ("No user with that username", nil)
    }
}
