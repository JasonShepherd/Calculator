//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Jason Shepherd on 10/30/16.
//  Copyright © 2016 Jason Shepherd. All rights reserved.
//

import Foundation

class CalculatorBrain{
    
    private var accumulator = 0.0
    
    
    func setOperand(operand: Double){
        accumulator = operand
    }
    
    var operations: Dictionary<String, Operation> = [
        "π": Operation.Constant(M_PI),
        "e": Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        "×": Operation.BinaryOperation({$0 * $1 }),
        "÷": Operation.BinaryOperation({$0 / $1 }),
        "+": Operation.BinaryOperation({$0 + $1 }),
        "-": Operation.BinaryOperation({$0 - $1 }),
        "±" : Operation.UnaryOperation({-$0}),
        "tan": Operation.UnaryOperation(tan),
        "sin":Operation.UnaryOperation(sin),
        "C"  : Operation.UnaryOperation({$0-$0}),
        "=": Operation.Equals
    ]
    
    enum Operation{
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double)->Double)
        case Equals
        
    } 
    
    func performOperation(symbol: String){
        if let operation = operations[symbol]{
            switch operation{
            case  .Constant(let value):
                accumulator = value
            case  .UnaryOperation(let function) :
                accumulator = function(accumulator)
            case  .BinaryOperation (let function) :
                executePendingBinaryOPeration()
                pending = pendingBinaryOperation(binaryFunction: function, firstOperand: accumulator)
            case  .Equals :
                executePendingBinaryOPeration()
                
                
            }
            
        }
    }
    
    
    private func clear(accumulator: Double)->Double{
        
        return accumulator
        
    }
    
    private func executePendingBinaryOPeration(){
        if pending != nil{
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
        
    }
    
    private var pending: pendingBinaryOperation?
    
    
    
    private struct pendingBinaryOperation{
        var binaryFunction: (Double, Double)->Double
        var firstOperand: Double
    }
    
   var result: Double{
        get{
            return accumulator
        }
    }
    
    
    
    
}
