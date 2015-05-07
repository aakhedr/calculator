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
    @IBOutlet weak var history: UILabel!

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
        let digit = sender.currentTitle!
        if userInTheMiddleOfTypingANumber {
            display.text = self.display.text! + digit
        } else {
            display.text = digit
            userInTheMiddleOfTypingANumber = true
        }
    }

    @IBAction func appendDecimalPoint(sender: UIButton) {
        let decimal = sender.currentTitle!
        if userInTheMiddleOfTypingANumber {
            if let decimal = display.text!.rangeOfString(decimal) {
                // Add some text to the display here!
                println("Number already contains a decimal point")
            } else {
                display.text = display.text! + decimal
            }
        } else {
            display.text = "\(0)" + decimal
            userInTheMiddleOfTypingANumber = true
        }
    }

    @IBAction func operate(sender: UIButton) {
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
            displayValue = result
        } else {
            // This needs to be modifed later in exercise 2
            displayValue = 0
        }
    }
    
    @IBAction func clear(sender: UIButton) {
        brain.clear()
        display.text = "\(0)"
    }
}
