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
    
    var isFirstDigit = true;

    @IBAction func appendDigit(sender: UIButton) {
        if (isFirstDigit) {
            isFirstDigit = false;
            result.text = sender.currentTitle
        } else {
            result.text = result.text! + sender.currentTitle!;
        }
    }
    

}

