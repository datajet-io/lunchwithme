//
//  ViewController.swift
//  LunchWithMe
//
//  Created by zeus on 01/09/15.
//  Copyright (c) 2015 disco. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {
    
    let serviceType = "LunchWithMe"
    
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var startLookingForUsersButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startLookingForUsersButton.enabled = false
                
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dest = segue.destinationViewController as? UserNameListTableViewController {
            dest.userName = self.userNameText.text
        }
    }
    
    @IBAction func onTextChange(sender: UITextField) {
    
        self.startLookingForUsersButton.enabled = self.userNameText.text.isEmpty == false
    }

}

