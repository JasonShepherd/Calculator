//
//  ViewController.swift
//  Calculator
//
//  Created by Jason Shepherd on 10/30/16.
//  Copyright © 2016 Jason Shepherd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet private weak var display: UILabel!
    
    private var userisInTheMiddleOfTyping = false
    
    @IBAction private func pressButton(_ sender: UIButton) {
        
        let button = sender.currentTitle!
        if userisInTheMiddleOfTyping {
            let textCurrentlyInDispay = display.text!
            display.text = textCurrentlyInDispay + button
        } else{
            display.text = button
        }
        userisInTheMiddleOfTyping = true  
    }
    
    
    private var displayValue: Double{
        get{
            return Double(display.text!)!
            
        }
        set{
            display.text = String(newValue)
            
        }
    }
    var savedProgram: CalculatorBrain.PropertyList?
    
    func save(){
        savedProgram = brain.program
    }
    
    
    func retore(){
        if savedProgram != nil{
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
    var brain  = CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userisInTheMiddleOfTyping{
            brain.setOperand(operand: displayValue)
            userisInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation(symbol: mathematicalSymbol)
            
            
        }
        displayValue = brain.result
        
    }
    
}
