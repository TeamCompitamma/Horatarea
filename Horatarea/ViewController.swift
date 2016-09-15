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
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.slideview), userInfo: nil, repeats: false)
    }
    
    func slideview(){
        performSegue(withIdentifier: "start", sender: nil)
    }
    
    
}
