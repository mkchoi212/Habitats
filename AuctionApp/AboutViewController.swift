//
//  AboutViewController.swift
//  Habitats
//
//  Created by Mike Choi on 2/3/15.
//  Copyright (c) 2015 LifePlusDev. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func am(sender: AnyObject) {
        var url : NSURL
        url = (NSURL(string: "http://www.tamu.edu")!)
        UIApplication.sharedApplication().openURL(url)
    }
    @IBAction func lifeplus(sender: AnyObject) {
        var url : NSURL
        url = (NSURL(string: "https://lifeplusdev.wordpress.com")!)
        UIApplication.sharedApplication().openURL(url)
    }
    @IBAction func habitat(sender: AnyObject) {
        var url : NSURL
        url = (NSURL(string: "http://www.aggiehabitat.com")!)
        UIApplication.sharedApplication().openURL(url)
    }
    
    @IBAction func exitScreen(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
