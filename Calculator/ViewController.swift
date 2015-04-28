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
    var operandStack = Array<Double>()
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(self.display.text!)!.doubleValue
        }
        set {
            self.display.text = "\(newValue)"
            self.userInTheMiddleOfTypingANumber = false
        }
    }
    
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
        let operation = sender.currentTitle!
        if userInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
            case "×": performBinaryOperation { $0 * $1 }
            case "÷": performBinaryOperation { $1 / $0 }
            case "+": performBinaryOperation { $0 + $1 }
            case "-": performBinaryOperation { $1 - $0 }
            case "√": performOperation { sqrt($0) }
            case "sin": performOperation { sin(Double($0)) }
            case "cos": performOperation { cos(Double($0)) }
            default: break
        }
    }

    func performBinaryOperation(operation: (Double, Double) -> Double) {
        if self.operandStack.count >= 2 {
            self.displayValue = operation(self.operandStack.removeLast(), self.operandStack.removeLast())
            self.enter()
        }
    }
    
    func performOperation(operation: Double -> Double) {
        if self.operandStack.count >= 1 {
            self.displayValue = operation(operandStack.removeLast())
            self.enter()
        }
    }
    
    @IBAction func enter() {
        self.userInTheMiddleOfTypingANumber = false
        self.operandStack.append(self.displayValue)
        println("operandStack = \(self.operandStack)")
    }
}

