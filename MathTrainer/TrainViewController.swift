//
//  TrainViewController.swift
//  MathTrainer
//
//  Created by Елизавета Ефросинина on 31/03/2023.
//

import UIKit

final class TrainViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var leftButtonResult: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var rightButtonResult: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    // MARK: - Properties
    var type: MathTypes = .add {
        didSet {
            switch type {
            case .add:
                sign = "+"
            case .subtract:
                sign = "-"
            case .multiply:
                sign = "*"
            case .divide:
                sign = "/"
            }
        }
    }
    
    private var firstNumber = 0
    private var secondNumber = 0
    private var sign: String = ""
    var count: Int = 0 {
        didSet {
            print("Count: \(count)")
        }
    }
    private var answer: Int {
        switch type {
        case .add:
            return firstNumber + secondNumber
        case .subtract:
            return firstNumber - secondNumber
        case .multiply:
            return firstNumber * secondNumber
        case .divide:
            return firstNumber / secondNumber
        }
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        configureQuestion()
        configureButton()
    }
    
    //MARK: - IBActions
    @IBAction func leftActionButton(_ sender: UIButton) {
        guard let text = sender.titleLabel?.text else {return}
        check(answer: text, for: sender)
    }
    
    @IBAction func rightActionButton(_ sender: UIButton) {
        guard let text = sender.titleLabel?.text else {return}
        check(answer: text, for: sender)
    }
    
    //MARK: - Methods
    private func configureButton() {
        let buttonsArray = [leftButtonResult, rightButtonResult]
        buttonsArray.forEach { button in
            button?.backgroundColor = .systemGray
        }
        
        buttonsArray.forEach { button in
            button?.layer.shadowColor = UIColor.darkGray.cgColor
            button?.layer.shadowOffset = CGSize.init(width: 0, height: 2)
            button?.layer.shadowOpacity = 0.4
            button?.layer.shadowRadius = 3
        }
        
        let isRightButton = Bool.random()
        var randomAnswer: Int
        repeat {
            randomAnswer = Int.random(in: (answer - 10)...(answer + 10))
        } while randomAnswer == answer
        
        rightButtonResult.setTitle(isRightButton ? String(answer) : String(randomAnswer), for: .normal)
        leftButtonResult.setTitle(isRightButton ? String(randomAnswer) : String(answer), for: .normal)
    }
    
    private func configureQuestion() {
        firstNumber = Int.random(in: 1...99)
        secondNumber = Int.random(in: 1...99)
        
        let question: String = "\(firstNumber) \(sign) \(secondNumber) = "
        questionLabel.text = question
    }
    
    private func check(answer: String, for button: UIButton) {
        let isRightAnswer = Int(answer) == self.answer
        
        button.backgroundColor  = isRightAnswer ? .green : .red
        
        if isRightAnswer {
            let isSecondAttempt = rightButtonResult.backgroundColor == .red ||
            leftButtonResult.backgroundColor == .red
            count += isSecondAttempt ? 0 : 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                self?.configureQuestion()
                self?.configureButton()
            }
        }
    }
}

