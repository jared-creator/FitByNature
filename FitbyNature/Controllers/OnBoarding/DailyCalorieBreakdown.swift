//
//  SetUpViewController.swift
//  prototype
//
//  Created by Jared Murray on 5/15/23.
//

import UIKit

class DailyCalorieBreakdown: UIViewController {
        
    var stackView = UIStackView()
    var imageView = UIImageView()
    var textView = UITextView()
    var continueButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStackView()
        setStackViewConstraints()
        addViewsToStackView()
        configureImageView()
        configureTextView()
        configureContinueButton()
    }
    
    func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 100
        stackView.setCustomSpacing(20, after: textView)
    }
    
    func addViewsToStackView() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(textView)
        stackView.addArrangedSubview(continueButton)
    }
    
    func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    func configureImageView() {
        imageView.image = UIImage(named: "istockphoto-1148608353-612x612 1")
        setImageViewConstraints()
    }
    
    func setImageViewConstraints() {
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 49
    }
    
    func configureTextView() {
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.center = self.view.center
        textView.textAlignment = NSTextAlignment.justified
        textView.text = DailyCalorieExplanation().explanation
        textView.font = UIFont(name: "Hiragino Maru Gothic ProN W4", size: 15)
        textView.textColor = UIColor(red: 131/255, green: 81/255, blue: 81/255, alpha: 1)
        textView.backgroundColor = UIColor(red: 255/255, green: 232/255, blue: 212/255, alpha: 1)
        textView.isEditable = false
        textView.isSelectable = false
    }
    
    func configureContinueButton() {
        continueButton.setTitle("Continue", for: .normal)
        continueButton.addTarget(self, action: #selector(segueToNextScreen), for: .touchUpInside)
        StyleGuide.styleFilledButton(continueButton)
    }

    @objc func segueToNextScreen() {
        performSegue(withIdentifier: "toCalorieSelection", sender: self)
    }
    
    struct DailyCalorieExplanation {
        let explanation = " We believe that it is best to track your current diet, no matter how unhealthy it is, and to see whether to add or lessen the amount you eat based on your weight at the start and end of that week. We recommend to add or subtract by smaller amounts like 200 - 500. In terms of macro and micro nutrients it is best to eat a well balanced diet unless told otherwise by a professional. Don’t worry! We will include some recommended calories for you on the next screen just in case. Now let's achieve that goal of yours together!"
    }
}

