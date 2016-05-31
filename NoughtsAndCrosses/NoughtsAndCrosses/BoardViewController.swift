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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

}
