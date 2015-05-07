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
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userInTheMiddleOfTypingANumber = false
        }
    }
    
    // The model
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        if userInTheMiddleOfTypingANumber {
            display.text = self.display.text! + sender.currentTitle!
        } else {
            display.text = sender.currentTitle!
            userInTheMiddleOfTypingANumber = true
        }
    }

    @IBAction func appendDecimalPoint(sender: UIButton) {
        if (display.text!.rangeOfString(".") != nil) {
            if userInTheMiddleOfTypingANumber {
                // Add some text to the display here!
                println("Number already contains a decimal point")
            } else {
                // User is typing a new number with decimal point
                display.text = "\(0)" + "."
                userInTheMiddleOfTypingANumber = true
            }
        } else {
            display.text = display.text! + "."
            userInTheMiddleOfTypingANumber = true
        }
    }

    @IBAction func oeprate(sender: UIButton) {
        if userInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                // Change this for exercise 2
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        self.userInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue) {
            self.displayValue = result
        } else {
            // This needs to be modifed later in exercise 2
            self.displayValue = 0
        }
    }
}



