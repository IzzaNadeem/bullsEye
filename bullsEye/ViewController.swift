//
//  ViewController.swift
//  bullsEye
//
//  Created by C4Q on 11/22/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
var currentValue: Int = 0
var targetValue: Int = 0
var totalScore = 0
var round = 0
class ViewController: UIViewController {
    @IBOutlet weak var guessLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       currentValue = Int(slider.value)
       startNewRound()
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")    //UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted =  #imageLiteral(resourceName: "SliderThumb-Highlighted")   //UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")      //UIImage(named: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SmallButton")     //UIImage(named: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
    }
    func updateLabel() {
        roundLabel.text = round.description
        scoreLabel.text = totalScore.description
         guessLabel.text = String(targetValue)
        
    }

    func startNewRound() {
        targetValue = 1 + Int(arc4random_uniform(100))
       
        currentValue = 50
        slider.value = Float(currentValue)
        round += 1
       updateLabel()
       
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        currentValue = Int(sender.value)
    }
    
    @IBAction func startOver(_ sender: UIButton) {
     round = 0
     totalScore = 0
     targetValue = 1 + Int(arc4random_uniform(100))
     updateLabel()
    
    }
    @IBAction func showAlert(_ sender: UIButton) {
       let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        if difference == 0 {
            points += 100
        }
        else if difference == 1 {
            points += 50
        }
       
        totalScore += points
        updateLabel()
        let message = "you earned \(points) points!"
        let alert = UIAlertController(title: message, message: "you put the slider at \(currentValue)", preferredStyle: .alert)
        let action = UIAlertAction(title: "awesome", style: .default, handler: {
            action in
            self.startNewRound()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

