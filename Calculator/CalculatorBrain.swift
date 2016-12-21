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
    private var internalProgram = [AnyObject]()
    
    func setOperand(operand: Double){
        accumulator = operand
        internalProgram.append(operand as AnyObject)
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
        internalProgram.append(symbol as AnyObject)
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
    
    
    
    
//      private  func clear(accumulator: Double)->Double{
//        pending = nil
//        internalProgram.removeAll()
//        return accumulator
//        
//    }
    
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
    
    typealias PropertyList = AnyObject
    var program: PropertyList {
        get {
            return internalProgram as CalculatorBrain.PropertyList
            
        }
        set {
            clear()
            if let arrayOfOps = newValue as? [AnyObject]{
                for op in arrayOfOps {
                    if let operand = op as? Double {
                        setOperand(operand: operand)
                        
                    } else if let operations = op as? String{
                        performOperation(symbol: operations)
                    }
                    
                }
            }
            
        }
    }
    
    func clear(){
        accumulator = 0.0
        pending = nil
        internalProgram.removeAll()
    }
    
    var result: Double{
        get{
            return accumulator
        }
    }
    
    
    
    
}
