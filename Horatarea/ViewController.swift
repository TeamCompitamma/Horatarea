//
//  ViewController.swift
//  Horatarea
//
//  Created by Hiroki MATSUMOTO on 6/23/16.
//  Copyright © 2016 Hiroki MATSUMOTO. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(self.slideview), userInfo: nil, repeats: false)
    }
    
    func slideview(){
        performSegueWithIdentifier("start", sender: nil)
    }
    
    
}
