//
//  WelcomeScreenViewController.swift
//  prototype
//
//  Created by Jared Murray on 7/8/23.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
    
    var parentStackView = UIStackView()
    var secondaryStackView = UIStackView()
    var imageView = UIImageView()
    var welcomeLabel = UILabel()
    var qouteLabel = UILabel()
    var continueButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureParentStackView()
        setParentStackViewConstraints()
        addViewsToParentStackView()
        configureImageView()
        configureWelcomeLabel()
        configureQouteLabel()
        configureContinueButton()
    }
    
    func configureParentStackView() {
        view.addSubview(parentStackView)
        parentStackView.axis = .vertical
        parentStackView.distribution = .fill
        parentStackView.spacing = 75
    }
    
    func addViewsToParentStackView() {
        parentStackView.addArrangedSubview(imageView)
        parentStackView.addArrangedSubview(welcomeLabel)
        parentStackView.addArrangedSubview(qouteLabel)
        parentStackView.addArrangedSubview(continueButton)
    }
    
    func setParentStackViewConstraints() {
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        parentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        parentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        parentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
    }   
    
    func configureImageView() {
        imageView.image = UIImage(named: "istockphoto-1165399909-612x612 1")
        setImageViewConstraint()
    }

    func setImageViewConstraint() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: view.frame.width - 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: view.frame.height - 400).isActive = true
        imageView.topAnchor.constraint(equalTo: parentStackView.safeAreaLayoutGuide.topAnchor, constant: -300).isActive = true
        imageView.layer.cornerRadius = 49
    }
    
    func configureWelcomeLabel() {
        welcomeLabel.numberOfLines = 0
        welcomeLabel.lineBreakMode = .byWordWrapping
        welcomeLabel.font = UIFont(name: "Hiragino Maru Gothic ProN W4", size: 45)
        welcomeLabel.text = "Welcome to FitByNature"
        welcomeLabel.textColor = UIColor(red: 131/255, green: 81/255, blue: 81/255, alpha: 1)

        setWelcomeLabelConstraint()
    }

    func setWelcomeLabelConstraint() {
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        welcomeLabel.heightAnchor.constraint(equalToConstant: 118).isActive = true
        welcomeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        welcomeLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -200).isActive = true
    }
    func configureQouteLabel() {
        qouteLabel.font = UIFont(name: "Hiragino Maru Gothic ProN W4-Heavy", size: 20)
        qouteLabel.numberOfLines = 0
        qouteLabel.lineBreakMode = .byWordWrapping
        qouteLabel.textAlignment = .center
        qouteLabel.text = "The quickest way to success is to start"
        qouteLabel.textColor = UIColor(red: 131/255, green: 81/255, blue: 81/255, alpha: 1)
        
        setQouteLabelConstraints()
    }
    
    func setQouteLabelConstraints() {
        qouteLabel.translatesAutoresizingMaskIntoConstraints = false
        qouteLabel.widthAnchor.constraint(equalToConstant: 226).isActive = true
        qouteLabel.heightAnchor.constraint(equalToConstant: 53).isActive = true
        qouteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        qouteLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: -20).isActive = true
    }
    
    func configureContinueButton() {
        continueButton.setTitle("Get Started!", for: .normal)
        StyleGuide.styleFilledButton(continueButton)
        continueButton.addTarget(self, action: #selector(segueToNextScreen), for: .touchUpInside)

        setContinueButtonConstraint()
    }

    func setContinueButtonConstraint() {
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.widthAnchor.constraint(equalToConstant: 168).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
    }
    
    @objc func segueToNextScreen() {
        performSegue(withIdentifier: "toFirstQuestion", sender: self)
    }
}
