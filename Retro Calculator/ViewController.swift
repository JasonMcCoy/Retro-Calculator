//
//  ViewController.swift
//  Retro Calculator
//
//  Created by Jason McCoy on 5/7/16.
//  Copyright © 2016 Jason McCoy. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        case divideOperator = "/"
        case multiplyOperator = "*"
        case subtractOperator = "-"
        case additionOperator = "+"
        case empty = "Empty"
    }
    
    @IBOutlet weak var outputLabel: UILabel!
    
    var buttonSound: AVAudioPlayer!
    var numberBeingDisplayed = ""
    var leftNumber = ""
    var rightNumber = ""
    var currentOperation: Operation = Operation.empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try buttonSound = AVAudioPlayer(contentsOfURL: soundURL)
            buttonSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }

    }
    
    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        
        numberBeingDisplayed += "\(btn.tag)"
        outputLabel.text = numberBeingDisplayed
    }
    
    @IBAction func whenDivideButtonPressed(sender: AnyObject) {
        processOperation(Operation.divideOperator)
    }

    @IBAction func whenMultipyButtonPressed(sender: AnyObject) {
        processOperation(Operation.multiplyOperator)
    }
    
    @IBAction func whenSubtractButtonPressed(sender: AnyObject) {
        processOperation(Operation.subtractOperator)
    }
    
    @IBAction func whenAdditionButtonPressed(sender: AnyObject) {
        processOperation(Operation.additionOperator)
    }
    
    @IBAction func whenEqualButtonPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.empty {
            // Run some math
            
            if numberBeingDisplayed != "" {
            rightNumber = numberBeingDisplayed
            numberBeingDisplayed = ""
            
                    if currentOperation == Operation.divideOperator {
                        result = "\(Double(leftNumber))! / \(Double(rightNumber)!)"
                    } else if currentOperation == Operation.multiplyOperator {
                        result = "\(Double(leftNumber))! * \(Double(rightNumber)!)"
                    } else if currentOperation == Operation.subtractOperator {
                        result = "\(Double(leftNumber))! - \(Double(rightNumber)!)"
                    } else if currentOperation == Operation.additionOperator {
                        result = "\(Double(leftNumber))! + \(Double(rightNumber)!)"
                    }
                
                    leftNumber = result
                    outputLabel.text = result
                }
            
            
                currentOperation = op
            
            } else {
            // This is the first time an operator has been pressed
            leftNumber = numberBeingDisplayed
            numberBeingDisplayed = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if buttonSound.playing {
            buttonSound.stop()
        }
        buttonSound.play()
    }
    
}

