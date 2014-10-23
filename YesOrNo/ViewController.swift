//
//  ViewController.swift
//  YesOrNo
//
//  Created by Justin Makaila on 10/23/14.
//  Copyright (c) 2014 Present. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var answerLabel: UILabel!
    private var backgroundColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "generateAnswer", name: UIApplicationWillEnterForegroundNotification, object: nil)
        generateAnswer()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        becomeFirstResponder()
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if event.subtype == .MotionShake {
            generateAnswer()
        }
    }
    
    func generateAnswer() {
        let randomNumber = arc4random()
        let remainder = randomNumber % 2

        if remainder == 0 {
            answerLabel.text = "Yes."
            answerLabel.textColor = UIColor.blackColor()
            backgroundColor = UIColor.whiteColor()
        } else {
            answerLabel.text = "No."
            answerLabel.textColor = UIColor.whiteColor()
            backgroundColor = UIColor.blackColor()
        }
        
        answerLabel.alpha = 0
        let textFade = CABasicAnimation(keyPath: "alpha")
        textFade.fromValue = 0
        textFade.toValue = 1.0
        textFade.duration = 0.25
        answerLabel.layer.addAnimation(textFade, forKey: "textFade")
        
        let backgroundCrossFade = CABasicAnimation(keyPath: "backgroundColor")
        backgroundCrossFade.delegate = self
        backgroundCrossFade.fromValue = view.backgroundColor?.CGColor
        backgroundCrossFade.toValue = backgroundColor.CGColor
        backgroundCrossFade.duration = 0.25
        view.layer.addAnimation(backgroundCrossFade, forKey: "backgroundCrossFade")
    }
}

extension ViewController {
    override func animationDidStart(anim: CAAnimation!) {
        view.backgroundColor = backgroundColor
        answerLabel.alpha = 1.0
    }
}
