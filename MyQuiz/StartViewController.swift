//
//  StartViewController.swift
//  MyQuiz
//
//  Created by admin on 2020/04/15.
//  Copyright © 2020 kt. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        QuestionDataManager.sharedInstance.loadQuestion()
        
        guard let nextViewController = segue.destination as? QuestionViewController else {
            return
        }
        
        guard let questionData = QuestionDataManager.sharedInstance.nextQuestion() else{
            return
        }
        
        nextViewController.questionData = questionData
    }
    
    @IBAction func goToTitle(_ segue: UIStoryboardSegue){
        
    }

}

