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
            return NSNumberFormatter().numberFromString(self.display.text!)!.doubleValue
        }
        set {
            self.display.text = "\(newValue)"
            self.userInTheMiddleOfTypingANumber = false
        }
    }
    
    // The model
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        if sender.currentTitle! != "." {
            var digit = sender.currentTitle!
            if self.userInTheMiddleOfTypingANumber {
                self.display.text = self.display.text! + digit
            } else {
                self.display.text = digit
                self.userInTheMiddleOfTypingANumber = true
            }
        } else {
            var decimal = sender.currentTitle!
            if self.display.text!.rangeOfString(".") == nil {
                self.display.text = self.display.text! + decimal
                self.userInTheMiddleOfTypingANumber = true
            }
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



