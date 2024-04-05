//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by Wanderson Dias Ferreira on 4/5/24.
//

import UIKit

class ViewController: UIViewController {

    var score = 0
    var timer = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    @IBOutlet weak var TimeLabel: UILabel!
    
    @IBOutlet weak var ScoreLabel: UILabel!
    
    @IBOutlet weak var HighScoreLabel: UILabel!
    
    @IBOutlet weak var Kenny1: UIImageView!
    @IBOutlet weak var Kenny2: UIImageView!
    @IBOutlet weak var Kenny3: UIImageView!
    @IBOutlet weak var Kenny4: UIImageView!
    @IBOutlet weak var Kenny5: UIImageView!
    @IBOutlet weak var Kenny6: UIImageView!
    @IBOutlet weak var Kenny7: UIImageView!
    @IBOutlet weak var Kenny8: UIImageView!
    @IBOutlet weak var Kenny9: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ScoreLabel.text = "Score: \(score)"
        
        // Highscore check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighScore == nil{
            highScore = 0
            HighScoreLabel.text = "HIghscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            HighScoreLabel.text = "Hishscore: \(highScore)"
        }
        
        Kenny1.isUserInteractionEnabled = true
        Kenny2.isUserInteractionEnabled = true
        Kenny3.isUserInteractionEnabled = true
        Kenny4.isUserInteractionEnabled = true
        Kenny5.isUserInteractionEnabled = true
        Kenny6.isUserInteractionEnabled = true
        Kenny7.isUserInteractionEnabled = true
        Kenny8.isUserInteractionEnabled = true
        Kenny9.isUserInteractionEnabled = true

        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        Kenny1.addGestureRecognizer(recognizer1)
        Kenny2.addGestureRecognizer(recognizer2)
        Kenny3.addGestureRecognizer(recognizer3)
        Kenny4.addGestureRecognizer(recognizer4)
        Kenny5.addGestureRecognizer(recognizer5)
        Kenny6.addGestureRecognizer(recognizer6)
        Kenny7.addGestureRecognizer(recognizer7)
        Kenny8.addGestureRecognizer(recognizer8)
        Kenny9.addGestureRecognizer(recognizer9)
        
        kennyArray = [Kenny1, Kenny2, Kenny3, Kenny4, Kenny5, Kenny6, Kenny7, Kenny8, Kenny9]
                
        
        //Timers
        
        counter = 10
        TimeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hidekenny), userInfo: nil, repeats: true)
        hidekenny()
        
    }
    
    @objc func hidekenny(){
        for kenny in kennyArray{
            kenny.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
        
        
    }
    
    @objc func increaseScore(){
        score+=1
        ScoreLabel.text = "Score: \(score)"
        
    }
    
    @objc func countDown(){
        counter-=1
        TimeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            for kenny in kennyArray{
                kenny.isHidden = true
            }
            
            //High Score
            if self.score > self.highScore{
                self.highScore = self.score
                HighScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.setValue(self.highScore, forKey: "highscore")
            }
            
            
            
            //Alert
            
            let alert = UIAlertController(title: "Time's up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayBUtton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.score = 0
                self.ScoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.TimeLabel.text = String(self.counter)
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hidekenny), userInfo: nil, repeats: true)
                
            }
            alert.addAction(okButton)
            alert.addAction(replayBUtton)
            self.present(alert, animated: true, completion: nil)
        }
        
    }


}

