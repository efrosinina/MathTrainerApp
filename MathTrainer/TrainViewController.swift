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
    
    
}
