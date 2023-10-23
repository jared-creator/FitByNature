//
//  WelcomeScreenViewController.swift
//  prototype
//
//  Created by Jared Murray on 7/8/23.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
    
    var stackView = UIStackView()
    var imageView = UIImageView()
    var welcomeLabel = UILabel()
    var qouteLabel = UILabel()
    var continueButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStackView()
        setStackViewConstraints()
        addViewsToStackView()
        configureImageView()
        configureWelcomeLabel()
        configureQouteLabel()
        configureContinueButton()
    }
    
    func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
    }
    
    func addViewsToStackView() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(welcomeLabel)
        stackView.addArrangedSubview(qouteLabel)
        stackView.addArrangedSubview(continueButton)
    }
    
    func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
    }   
    
    func configureImageView() {
        imageView.image = UIImage(named: "istockphoto-1165399909-612x612 1")
        setImageViewConstraint()
    }

    func setImageViewConstraint() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 49
    }
    
    func configureWelcomeLabel() {
        welcomeLabel.numberOfLines = 0
        welcomeLabel.lineBreakMode = .byWordWrapping
        welcomeLabel.font = UIFont(name: "Hiragino Maru Gothic ProN W4", size: 45)
        welcomeLabel.text = "Welcome to FitByNature"
        welcomeLabel.textColor = UIColor(red: 131/255, green: 81/255, blue: 81/255, alpha: 1)
    }

    func configureQouteLabel() {
        qouteLabel.font = UIFont(name: "Hiragino Maru Gothic ProN W4-Heavy", size: 20)
        qouteLabel.numberOfLines = 0
        qouteLabel.lineBreakMode = .byWordWrapping
        qouteLabel.textAlignment = .center
        qouteLabel.text = "The quickest way to success is to start"
        qouteLabel.textColor = UIColor(red: 131/255, green: 81/255, blue: 81/255, alpha: 1)
    }
    
    func configureContinueButton() {
        continueButton.setTitle("Get Started!", for: .normal)
        StyleGuide.styleFilledButton(continueButton)
        continueButton.addTarget(self, action: #selector(segueToNextScreen), for: .touchUpInside)

        setContinueButtonConstraint()
    }

    func setContinueButtonConstraint() {
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
    }
    
    @objc func segueToNextScreen() {
        performSegue(withIdentifier: "toFirstQuestion", sender: self)
    }
}
