//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Umer Jamil on 10/3/23.
//

import UIKit

class TriviaViewController: UIViewController {
    
    var currentQuestionIndex = 0
    var currentQuestion: TriviaQuestion? {
        didSet {
            updateUI()
        }
    }
    
    // This can be a UILabel
    var questionLabel: UILabel!
    
    // These can be UIButton or custom UIViews
    var answerButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()  // Set up your UI components here
        currentQuestion = triviaQuestions[currentQuestionIndex]
    }
    
    func setupUI() {
        // Initialize the question label
        questionLabel = UILabel()
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 0
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionLabel)
        
        // Layout the question label
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Initialize and layout answer buttons
        for i in 0..<4 {
            let button = UIButton(type: .system)
            button.tag = i
            button.addTarget(self, action: #selector(answerTapped(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(button)
            answerButtons.append(button)
            // button background basic styling
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 8
            
            // Position the buttons below each other and below the question label
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: (i == 0) ? questionLabel.bottomAnchor : answerButtons[i - 1].bottomAnchor, constant: 20),
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
            ])
        }
    }

    
    func updateUI() {
        guard let question = currentQuestion else { return }
        questionLabel.text = question.question
        for (index, button) in answerButtons.enumerated() {
            button.setTitle(question.answers[index], for: .normal)
        }
    }
    
    @objc func answerTapped(_ sender: UIButton) {
        // For now, we just move to the next question when any answer is tapped
        currentQuestionIndex += 1
        if currentQuestionIndex < triviaQuestions.count {
            currentQuestion = triviaQuestions[currentQuestionIndex]
        } else {
            // Game over, or perhaps show a results screen
        }
    }
}

