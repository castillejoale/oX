//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    
    @IBOutlet var boardView: UIView!
    
    var gameObject = OXGame()
    var lastRotation: Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // allow for user interaction
        view.userInteractionEnabled = true
        
        //Rotation
        
        // create an instance of UIRotationGestureRecognizer
        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action:#selector(BoardViewController.handleRotation(_:)))
        // add tap as a gestureRecognizer to tapView
        self.boardView.addGestureRecognizer(rotation)
        //Initialize lastRotation
        self.lastRotation = 0.0
        
        
        //Make sure we have the user available
        let user = (UserController.sharedInstance.logged_in_user)!
        
        let emailLoggedIn: String = user.email
        let passwordLoggedIn: String = user.password
        
        print(emailLoggedIn)
        print(passwordLoggedIn)
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func boardWasTapped(sender: AnyObject) {
        
        print("boardWasTapped at index: " + String(sender.tag))
        
        if(String(gameObject.typeAtIndex(sender.tag)) != "EMPTY"){
            return
        }
        
        let move = gameObject.playMove(sender.tag)
        
        if let moveToPrint = move   {
            sender.setTitle("\(moveToPrint)", forState: UIControlState.Normal)
        }
        
        if let moveToPrint = move   {
            sender.setTitle("\(moveToPrint)", forState: UIControlState.Normal)
        }
        
        let state = gameObject.state()
        
        if (state == OXGameState.complete_someone_won) {
            let winner = move
            let message = "\(winner) won the game"
            print(message)
            self.restartGame()
            //            let alert = UIAlertController(title: "Game Over", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            //            self.presentViewController(alert, animated: true, completion: nil)
            //            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(action) in
            //                self.restartGame()
            //            }))
        } else if (state == OXGameState.complete_no_one_won) {
            let message = "Game tied!"
            print(message)
            self.restartGame()
            //            let alert = UIAlertController(title: "Game Over", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            //            self.presentViewController(alert, animated: true, completion: nil)
            //            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(action) in
            //                self.restartGame()
            //            }))
        }
        
    }
    
    func handleRotation(sender: UIRotationGestureRecognizer? = nil) {
        
        
        //Update transformation
        self.boardView.transform = CGAffineTransformMakeRotation(sender!.rotation + CGFloat(self.lastRotation));
        
        //Rotation ends
        if (sender!.state == UIGestureRecognizerState.Ended)   {
            
            print("game rotation")
            
            UIView.animateWithDuration(NSTimeInterval(1), animations: {
                
                var rotation = CGFloat(self.lastRotation)
                
                if( abs(sender!.rotation) > CGFloat(M_PI)/6.0){
                    
                    rotation += CGFloat(M_PI)
                    self.lastRotation = self.lastRotation! + Float(M_PI)
                    
                    
                }
                
                self.boardView.transform = CGAffineTransformMakeRotation(rotation)
                
            })
            
        }
        
    }

    
    @IBAction func newGameWasTapped(sender: AnyObject) {
        
        print("newGameWasTapped")
        self.restartGame()
        
    }
    
    func restartGame()  {
        
        //reset model
        gameObject.reset()
        //reset UI
        for view in boardView.subviews  {
            if let button = view as? UIButton   {
                button.setTitle("", forState: UIControlState.Normal)
            }
        }
        
    }
    
    @IBAction func logoutWasPressed(sender: AnyObject) {
        
        print("pressing logout")
        
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "userIdLoggedIn")
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "passwordLoggedIn")
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.navigateToLoggedOutNavigationController()
        
    }
    
}
