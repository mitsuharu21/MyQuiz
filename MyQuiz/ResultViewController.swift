//
//  ResultViewController.swift
//  MyQuiz
//
//  Created by admin on 2020/04/15.
//  Copyright © 2020 kt. All rights reserved.
//

import Foundation
import UIKit

class ResultViewController : UIViewController{
    
    @IBOutlet weak var correctPercentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let questionCount = QuestionDataManager.sharedInstance.questionDataArray.count
        
        var correctCount : Int = 0
        
        for questionData in QuestionDataManager.sharedInstance.questionDataArray {
            if questionData.isCorrect(){
                correctCount += 1
            }
        }
        
        let correctPercent : Float = (Float(correctCount) / Float(questionCount)) * 100
        
        correctPercentLabel.text = String(format: "%.1f", correctPercent) + "%"
    }
}
