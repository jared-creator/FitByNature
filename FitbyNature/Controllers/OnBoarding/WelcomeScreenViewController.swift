//
//  WelcomeScreenViewController.swift
//  prototype
//
//  Created by Jared Murray on 7/8/23.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = UIView()
        let parent = self.view!
        
        //Image view
        let imageName = "istockphoto-1165399909-612x612 1"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: self.view.frame.height - 400).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        view.layer.cornerRadius = 49
        
        
        parent.addSubview(view)
        
        //Welcome Label
        let welcomeLabel = UILabel()
        
        welcomeLabel.frame = CGRect(x: 0, y: 0, width: 300, height: 118)
        welcomeLabel.numberOfLines = 0
        welcomeLabel.lineBreakMode = .byWordWrapping
        welcomeLabel.font = UIFont(name: "Hiragino Maru Gothic ProN W4", size: 50)
        welcomeLabel.text = "Welcome to FitByNature"
        welcomeLabel.textColor = UIColor(red: 131/255, green: 81/255, blue: 81/255, alpha: 1)
   
        parent.addSubview(welcomeLabel)
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        welcomeLabel.heightAnchor.constraint(equalToConstant: 118).isActive = true
        welcomeLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 24).isActive = true
        welcomeLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20).isActive = true
        
        //Qoute Label
        let quoteLabel = UILabel()
        quoteLabel.frame = CGRect(x: 0, y: 0, width: 226, height: 53)
        quoteLabel.font = UIFont(name: "Hiragino Maru Gothic ProN W4-Heavy", size: 20)
        quoteLabel.numberOfLines = 0
        quoteLabel.lineBreakMode = .byWordWrapping
        quoteLabel.textAlignment = .center
        quoteLabel.text = "The quickest way to success is to start"
        quoteLabel.textColor = UIColor(red: 131/255, green: 81/255, blue: 81/255, alpha: 1)
        
        parent.addSubview(quoteLabel)
        quoteLabel.translatesAutoresizingMaskIntoConstraints = false
        quoteLabel.widthAnchor.constraint(equalToConstant: 226).isActive = true
        quoteLabel.heightAnchor.constraint(equalToConstant: 53).isActive = true
        quoteLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 50).isActive = true
        quoteLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 5).isActive = true
        
        //Continue Button
        let continueButton = UIButton()
        continueButton.setTitle("Get Started!", for: .normal)
        StyleGuide.styleFilledButton(continueButton)
        continueButton.addTarget(self, action: #selector(segueToNextScreen), for: .touchUpInside)
        parent.addSubview(continueButton)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.widthAnchor.constraint(equalToConstant: 168).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
        continueButton.leadingAnchor.constraint(equalTo: parent.centerXAnchor, constant: -90).isActive = true
        continueButton.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: 50).isActive = true
        continueButton.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -50).isActive = true

    }
    
    @objc func segueToNextScreen() {
        performSegue(withIdentifier: "toFirstQuestion", sender: self)
    }
}
