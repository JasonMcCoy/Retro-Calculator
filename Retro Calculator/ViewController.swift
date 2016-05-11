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

    
    var buttonSound: AVAudioPlayer!
    
    
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
        buttonSound.play()
    }

}

