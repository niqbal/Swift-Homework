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
    
    var brain = CalculatorBrain();
    
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
        if (userIsInTheMiddleofTypingANumber) {
            enter()
        }

        if let operation = sender.currentTitle {
            if let res = brain.pushOperator(operation) {
                displayValue = res
            } else {
                displayValue = 0
            }
        }
        
        // todo: why did we remove the enter?
//        enter()
    }
    
    func doBinaryOp(op : (Double,Double) -> Double) -> Double {
        if (numberStack.count >= 2) {
            return op(numberStack.removeLast(), numberStack.removeLast());
        }
        
        return 0;
    }
    
    func doUnaryOp(op : Double -> Double) -> Double {
        if (numberStack.count >= 1) {
            return op(numberStack.removeLast());
        }
        return 0;
    }
    
    
    
    @IBAction func enter() {
        userIsInTheMiddleofTypingANumber = false;
        if let resf = brain.pushOperand(displayValue) {
            displayValue = resf
        } else {
            displayValue = 0
        }
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

