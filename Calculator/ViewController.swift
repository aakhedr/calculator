//
//  ViewController.swift
//  Calculator
//
//  Created by Ahmed Khedr on 4/7/15.
//  Copyright (c) 2015 Ahmed Khedr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!

    var userInTheMiddleOfTypingANumber = false
    
    @IBAction func appendDigit(sender: UIButton) {
        var digit = sender.currentTitle!
        if userInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
        }
    }
}

