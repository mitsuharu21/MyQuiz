//
//  QuestionViewContoroller.swift
//  MyQuiz
//
//  Created by admin on 2020/04/15.
//  Copyright © 2020 kt. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox

class QuestionViewController : UIViewController {
    
    var questionData : QuestionData!
    
    
    @IBOutlet weak var questionNoLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    
    @IBOutlet weak var correctImageView: UIImageView!
    @IBOutlet weak var incorrectImageView: UIImageView!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        questionNoLabel.text = "Q.\(questionData.questionNo)"
        questionTextView.text = questionData.question
        answer1Button.setTitle(questionData.answer1, for: UIControl.State.normal)
        answer2Button.setTitle(questionData.answer2, for: UIControl.State.normal)
        answer3Button.setTitle(questionData.answer3, for: UIControl.State.normal)
        answer4Button.setTitle(questionData.answer4, for: UIControl.State.normal)

        answer1Button.backgroundColor = UIColor.lightGray
        answer2Button.backgroundColor = UIColor.lightGray
        answer3Button.backgroundColor = UIColor.lightGray
        answer4Button.backgroundColor = UIColor.lightGray

    }
    
    @IBAction func tapAnswer1Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 1
        goNextQuestionWithAnimation()
    }
    
    @IBAction func tapAnswer2Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 2
        goNextQuestionWithAnimation()
    }
    
    @IBAction func tapAnswer3Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 3
        goNextQuestionWithAnimation()
    }
    
    @IBAction func tapAnswer4Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 4
        goNextQuestionWithAnimation()
    }
    
    func goNextQuestionWithAnimation(){
        if questionData.isCorrect(){
            goNextQuestionWithCorrectAnimation()
        }else{
            goNextQuestionWithIncorrectAnimation()
            
            setInCorrectAnswerBackColor()
        }
        
        setCorrectAnswerBackColor()
    }

    func setCorrectAnswerBackColor(){

        switch questionData.correctAnswerNumber {
        case 1:
            answer1Button.backgroundColor = UIColor.cyan
        case 2:
            answer2Button.backgroundColor = UIColor.cyan
        case 3:
            answer3Button.backgroundColor = UIColor.cyan
        case 4:
            answer4Button.backgroundColor = UIColor.cyan
        default:
            print("正解例外")
        }

    }
    
    func setInCorrectAnswerBackColor(){
        
        switch questionData.userChoiceAnswerNumber {
        case 1:
            answer1Button.backgroundColor = UIColor.red
        case 2:
            answer2Button.backgroundColor = UIColor.red
        case 3:
            answer3Button.backgroundColor = UIColor.red
        case 4:
            answer4Button.backgroundColor = UIColor.red
        default:
            print("不正解例外")
        }
        
    }
    
    func goNextQuestionWithCorrectAnimation(){
        let soundUrl = Bundle.main.url(forResource: "crrect_answer3", withExtension: "mp3")
        var soundId: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(soundUrl! as CFURL, &soundId)
        AudioServicesPlaySystemSoundWithCompletion(soundId){
            
        }
        
        UIView.animate(withDuration: 2.0, animations:{
            self.correctImageView.alpha = 1.0
        }){(Bool) in
            self.goNextQuestion()
        }
    }

    func goNextQuestionWithIncorrectAnimation(){
        let soundUrl = Bundle.main.url(forResource: "blip01", withExtension: "mp3")
        var soundId: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(soundUrl! as CFURL, &soundId)
        AudioServicesPlaySystemSoundWithCompletion(soundId){
            
        }
        UIView.animate(withDuration: 2.0, animations:{
            self.incorrectImageView.alpha = 1.0
        }){(Bool) in
            self.goNextQuestion()
        }
    }

    func goNextQuestion(){
        
        guard  let nextQuestion = QuestionDataManager.sharedInstance.nextQuestion() else {
            if let resultViewController = storyboard?.instantiateViewController(withIdentifier: "result") as? ResultViewController {
                present(resultViewController,animated: true,completion: nil)
            }
            return
        }
        
        if let nextQuestionViewController = storyboard?.instantiateViewController(withIdentifier: "question") as? QuestionViewController{
            nextQuestionViewController.questionData = nextQuestion
            present(nextQuestionViewController, animated: true, completion: nil)
        }
    }
}
