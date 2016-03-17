//
//  MBaseViewController.swift
//  Marvel App
//
//  Created by Prabhu Chandrasekaran 14/03/2016.
//  Copyright © 2016 My Own Company. All rights reserved.
//

class MBaseViewController: UIViewController {
    internal func showAlertWithMessage(message: String, title: String) {
        //__ Create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        //__ Add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        //__ Show the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
