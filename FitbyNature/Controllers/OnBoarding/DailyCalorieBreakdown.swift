//
//  SetUpViewController.swift
//  prototype
//
//  Created by Jared Murray on 5/15/23.
//

import UIKit

class DailyCalorieBreakdown: UIViewController {
        
    @IBOutlet weak var continueButton: UIButton!
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        StyleGuide.styleFilledButton(continueButton)
    }
}

