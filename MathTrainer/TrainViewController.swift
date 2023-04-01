//
//  TrainViewController.swift
//  MathTrainer
//
//  Created by Елизавета Ефросинина on 31/03/2023.
//

import UIKit

final class TrainViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet var resultButtonsCollection: [UIButton]!
    
    // MARK: - Properties
    var type: MathTypes = .add {
        didSet {
            print(type)
        }
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        configure()
    }
    
    //MARK: - Methods
    private func configure() {
        resultButtonsCollection.forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize.init(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
    }
}
