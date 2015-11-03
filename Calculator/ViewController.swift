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
    
    
    var brain = CalculatorBrain();
    
    @IBOutlet weak var stackOutput: UILabel!
    
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
            let res = brain.pushOperator(operation)
            
            if let resf = res.result  {
                displayValue = resf
                stackOutput.text = "";
            } else {
                displayValue = 0
                stackOutput.text = "\(res.remainingOps)"
            }
        }
        
        
    }
    
    
    @IBAction func enter() {
        userIsInTheMiddleofTypingANumber = false;
        let res = brain.pushOperand(displayValue)
        if let resf = res.result  {
            displayValue = resf
            stackOutput.text = "";
        } else {
            displayValue = 0
            stackOutput.text = "\(res.remainingOps)"
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

