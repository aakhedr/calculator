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
            userInTheMiddleOfTypingANumber = true
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
            default: break
        }
    }

    func performBinaryOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userInTheMiddleOfTypingANumber = false
        }
    }
}

