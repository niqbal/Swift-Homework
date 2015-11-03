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
    
    
    var m1 : AnyObject;
    
    var brain = CalculatorBrain();
    
    @IBOutlet weak var stackOutput: UILabel!
    
    var userIsInTheMiddleofTypingANumber = false;

    required init?(coder aDecoder: NSCoder) {
        m1 = Array<String>();
        super.init(coder: aDecoder);
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        if (!userIsInTheMiddleofTypingANumber) {
            userIsInTheMiddleofTypingANumber = true;
            result.text = sender.currentTitle
        } else {
            result.text = result.text! + sender.currentTitle!;
        }
    }
    

    @IBAction func clearCurrentStack() {
        displayValue = 0;
        brain.clearStack();
    }
    
    @IBAction func memorize(sender: UIButton) {
        m1 = brain.program;
    }
    
    
    @IBAction func recall(sender: UIButton) {
        brain.program = m1;
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

