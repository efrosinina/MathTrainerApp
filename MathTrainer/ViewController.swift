//
//  ViewController.swift
//  MathTrainer
//
//  Created by Елизавета Ефросинина on 31/03/2023.
//

import UIKit

enum MathTypes: Int, CaseIterable {
    case add, subtract, multiply, divide
    
    var key: String {
        switch self {
        case .add:
            return "addCount"
        case .subtract:
            return "subtractCount"
        case .multiply:
            return "multiplyCount"
        case .divide:
            return "divideCount"
        }
    }
}

class ViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet var buttonsCollection: [UIButton]!
    @IBOutlet weak var plusCountLabel: UILabel!
    @IBOutlet weak var minusCountLabel: UILabel!
    @IBOutlet weak var multiplyCountLabel: UILabel!
    @IBOutlet weak var divideCountLabel: UILabel!
    
    //MARK: - Properties
    private var selectedType: MathTypes = .add
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButtons()
        setCountLabels()
    }
    
    //MARK: - Actions
    @IBAction func buttonsAction(_ sender: UIButton) {
        selectedType = MathTypes(rawValue: sender.tag) ?? .add
        performSegue(withIdentifier: "goToNextView", sender: sender)
    }
    @IBAction func clearButtonAction(_ sender: UIButton) {
        MathTypes.allCases.forEach { type in
            let key = type.key
            UserDefaults.standard.removeObject(forKey: key)
            plusCountLabel.text = "-"
            minusCountLabel.text = "-"
            multiplyCountLabel.text = "-"
            divideCountLabel.text = "-"
        }
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) {
            setCountLabels()
    }
    
    //MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // destination - next viewController
        if let viewController = segue.destination as? TrainViewController {
            viewController.type = selectedType
        }
    }
    
    private func setCountLabels() {
        MathTypes.allCases.forEach { type in
            let key = type.key // Got key
            guard let count = UserDefaults.standard.object(forKey: key) as? Int else { return } // Received object from key
            let stringValue = String(count)
            
            switch type {
            case .add:
                plusCountLabel.text = stringValue
            case .subtract:
                minusCountLabel.text = stringValue
            case .multiply:
                multiplyCountLabel.text = stringValue
            case .divide:
                divideCountLabel.text = stringValue
            }
        }
    }
    
    private func configureButtons() {
        // Add shadow
        buttonsCollection.forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize.init(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
    }
}

