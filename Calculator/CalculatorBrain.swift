//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Nawab Zada Asad Iqbal on 10/31/15.
//  Copyright © 2015 Nawab Zada Asad Iqbal. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    enum Op {
        case Operand(Double)
        case UnaryOperator(String, Double -> Double);
        case BinaryOperator(String, (Double, Double) -> Double);
        
    }
  
    init() {
//        func learnOp(sym: String, op: Op) {
//            knownOps[sym] = op;
//        }

        knownOps["×"] = Op.BinaryOperator("×", *);
        knownOps["÷"] = Op.BinaryOperator("÷") {$1 / $0};
        knownOps["+"] = Op.BinaryOperator("+", +);
        knownOps["−"] = Op.BinaryOperator("−") {$1 - $0};
        knownOps["√"] = Op.UnaryOperator("√", sqrt);
    }
    
    var historyStack = [Op]();
    var knownOps = [String:Op]();
    //Dictionary<String, Op>();
    
    func pushOperand(operand: Double) -> Double? {
        historyStack.append(Op.Operand(operand));
        return evaluate();
    }
    
    func pushOperator(symbol: String) -> Double? {
        historyStack.append(knownOps[symbol]!);
        return evaluate();
    }

    
    func evaluate(ops: [Op]) -> (result: Double?, reaminingOps: [Op]) {
        if (ops.count == 0) {
            return (nil, ops);
        }

        var remainingOps = ops;
        let op = remainingOps.removeLast();
        
        switch (op) {
        case .Operand(let x) :
            return (x, remainingOps);
        case .BinaryOperator(_, let operation):
            let v1 = evaluate(remainingOps);
            let v2 = evaluate(v1.reaminingOps);
            if let v1f = v1.result {
                if let v2f = v2.result {
                    return (operation(v1f, v2f), v2.reaminingOps);
                }
            }
            break;
            
        case .UnaryOperator(_, let operation):
            let v1 = evaluate(remainingOps);
            if let v1f = v1.result {
                return (operation(v1f), v1.reaminingOps);
            }
        }
        
        return (nil, ops);
    }
    
    func evaluate() -> Double? {
        let (result, remainder) = evaluate(historyStack)
        if (result == nil || remainder.count > 0) {
            return nil;
        }
        
        return result;
    }
    
    
};
