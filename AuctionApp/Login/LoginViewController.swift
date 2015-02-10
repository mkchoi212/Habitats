//
//  LoginViewController.swift
//  AuctionApp
//
//  Created by Mike Choi on 17/11/2014.
//  Copyright (c) 2014 LifePlusDev. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController, UITextFieldDelegate, UIWebViewDelegate {

    @IBOutlet var da_view: UIView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet var emailTextField: UITextField!
    var webViewBG: UIWebView!
    var viewShaker:AFViewShaker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var filePath = NSBundle.mainBundle().pathForResource("long1", ofType: "gif")
        var gif = NSData(contentsOfFile: filePath!)
        
        webViewBG = UIWebView(frame: da_view.frame)
        webViewBG.delegate = self
        webViewBG.userInteractionEnabled = false
        webViewBG.contentMode = UIViewContentMode.ScaleToFill
        webViewBG.backgroundColor = UIColor .blackColor()
        webViewBG.alpha = 0.0
        webViewBG.loadData(gif, MIMEType: "image/gif", textEncodingName: nil, baseURL: nil)
        self.view.insertSubview(webViewBG, atIndex: 0)
        
        var filter = UIView()
        filter.frame = self.view.frame
        filter.backgroundColor = UIColor.blackColor()
        filter.alpha = 0.09
        self.view.insertSubview(filter, atIndex: 1)

        viewShaker = AFViewShaker(viewsArray: [nameTextField, emailTextField])
       nameTextField.delegate=self
        emailTextField.delegate = self
       self.img1.alpha = 0;
        self.img2.alpha = 0;
        
        nameTextField.attributedPlaceholder = NSAttributedString(string:"Name",
            attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        emailTextField.attributedPlaceholder = NSAttributedString(string:"Email",
            attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
    }
    
    
        override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(2.0, animations: { ()-> Void in
          self.img1.alpha = 1.0
            self.img2.alpha = 1.0
            self.webViewBG.alpha = 1.0
        })
    }


    @IBAction func loginPressed(sender: AnyObject) {
        //DECLARE LEGAL DOMAINS HERE!
        let legalDomain = ["tamu.edu"]
        if nameTextField.text != "" && emailTextField.text != "" {
            
            var user = PFUser()
            user["fullname"] = nameTextField.text.lowercaseString
            user.username = emailTextField.text.lowercaseString
            user.password = "test"
            user.email = emailTextField.text.lowercaseString
            var escapenow = false
            
        for daNames in legalDomain{
            if (user.email.hasSuffix(daNames)){
                escapenow = true
            }
        }
            
            
        if (escapenow == true){
                user.signUpInBackgroundWithBlock {
                    (succeeded: Bool!, error: NSError!) -> Void in
                    if succeeded == true {
                        self.registerForPush()
                        self.performSegueWithIdentifier("loginToItemSegue", sender: nil)
                        return
                    }
                    else {
                        let errorString = error.userInfo!["error"] as NSString
                        println("Error Signing up: \(error)")
                        PFUser.logInWithUsernameInBackground(user.username, password: user.password, block: { (user, error) -> Void in
                            if error == nil {
                                self.registerForPush()
                                self.performSegueWithIdentifier("loginToItemSegue", sender: nil)
                                return
                            }else{
                                self.viewShaker?.shake()
                            }
                        })
                    }
                }
            }
            else{
                viewShaker?.shake()
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
    func registerForPush() {
        let user = PFUser.currentUser()
        let currentInstalation = PFInstallation.currentInstallation()
        currentInstalation["email"] = user.email
        currentInstalation.saveInBackgroundWithBlock(nil)

        
        let application = UIApplication.sharedApplication()
        
        if application.respondsToSelector("registerUserNotificationSettings:") {
            let settings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Alert | UIUserNotificationType.Sound | UIUserNotificationType.Badge, categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        }else{
            let types: UIRemoteNotificationType = .Badge | .Alert | .Sound
            application.registerForRemoteNotificationTypes(types)
        }
        
    }
}
