//
//  ViewController.swift
//  Calculator
//
//  Created by Nawab Zada Asad Iqbal on 10/30/15.
//  Copyright © 2015 Nawab Zada Asad Iqbal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var result: UILabel!
    var numberStack = Array<Double>()
    
    var userIsInTheMiddleofTypingANumber = false;

    @IBAction func appendDigit(sender: UIButton) {
        if (!userIsInTheMiddleofTypingANumber) {
            userIsInTheMiddleofTypingANumber = true;
            result.text = sender.currentTitle
        } else {
            result.text = result.text! + sender.currentTitle!;
        }
    }
    

    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if (userIsInTheMiddleofTypingANumber) {
            enter()
        }
        if (numberStack.count < 2) {
            return;
        }

        switch(operation) {
        case "×":
            displayValue = performOperation(numberStack.removeLast(), op2: numberStack.removeLast(), op: *);
            break;
        case "÷":
            displayValue = performOperation(numberStack.removeLast(), op2: numberStack.removeLast(), op: /);
            break;
        case "+":
            displayValue = performOperation(numberStack.removeLast(), op2: numberStack.removeLast(), op: +);
            break;
        case "−":
            displayValue = performOperation(numberStack.removeLast(), op2: numberStack.removeLast(), op: -);
            break;
        default:
            break;
        }
        
        enter()
    }
    
    func performOperation(op1 : Double, op2 : Double, op : (Double,Double) -> Double) -> Double {
        return op(op2, op1);
    }
    
    
    
    @IBAction func enter() {
        userIsInTheMiddleofTypingANumber = false;
        numberStack.append(displayValue)
        print("operandStack = \(numberStack)")
    }

    // computer property
    var displayValue : Double {
        get {
            //return Double.init(result.text!)!
            return NSNumberFormatter().numberFromString(result.text!)!.doubleValue
        }
        set {
            result.text = "\(newValue)"
            userIsInTheMiddleofTypingANumber = false;
        }
    }
}

