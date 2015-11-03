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
    enum Op : CustomStringConvertible {
        case Operand(Double)
        case UnaryOperator(String, Double -> Double);
        case BinaryOperator(String, (Double, Double) -> Double);
        
        var description: String {
            get {
                switch self {
                case .Operand(let x) :
                    return "\(x)"
                case .UnaryOperator(let x, _):
                    return x;
                case .BinaryOperator(let x, _):
                    return x;
                }
            }
        }
    }
  
    init() {
        func learnOp(op: Op) {
            knownOps[op.description] = op;
        }

        learnOp(Op.BinaryOperator("×", *));
        learnOp(Op.BinaryOperator("÷") {$1 / $0});
        learnOp(Op.BinaryOperator("+", +));
        learnOp(Op.BinaryOperator("−") {$1 - $0});
        learnOp(Op.UnaryOperator("√", sqrt));
    }
    
    func makeOp(symbol: String) -> Op? {
        if let opertion = knownOps[symbol] {
            return opertion
        } else if let operand = NSNumberFormatter().numberFromString(symbol)?.doubleValue {
            return Op.Operand(operand);
        }
        
        return nil
    }
    
    var program : AnyObject {
        get {
            return historyStack.map { $0.description};
        }
        set {
            if let newOpStack = newValue as? Array<String> {
                let newHistory = (newOpStack.map {makeOp($0)});
                self.historyStack = newHistory.flatMap {$0};
            }
        }
    }
    
    var historyStack = [Op]();
    var knownOps = [String:Op]();
    //Dictionary<String, Op>();
    
    func pushOperand(operand: Double) -> (result: Double?, remainingOps: [Op])  {
        historyStack.append(Op.Operand(operand));
        return evaluate();
    }
    
    func pushOperator(symbol: String) -> (result: Double?, remainingOps: [Op])  {
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
    
    func evaluate() -> (result: Double?, remainingOps: [Op])  {
        let (result, remainder) = evaluate(historyStack)
        print("result = \(result) with remainder = \(remainder)");
        
        if (result == nil) {
            return (nil, remainder);
        }
        
        return (result, remainder);
    }
    
    
};

