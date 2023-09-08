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
        view.frame = CGRect(x: 0, y: 0, width: 380.32, height: 230.36)
        let image0 = UIImage(named: "istockphoto-1165399909-612x612 1")?.cgImage
        let layer0 = CALayer()
        layer0.contents = image0
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1.1, tx: 0, ty: -0.05))
        layer0.bounds = view.bounds
        layer0.position = view.center
        view.layer.addSublayer(layer0)
        
        view.layer.cornerRadius = 49
        
        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 380.32).isActive = true
        view.heightAnchor.constraint(equalToConstant: 230.36).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 24.68).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 195).isActive = true
        
        
        let welcomeLabel = UILabel()
        welcomeLabel.frame = CGRect(x: 0, y: 0, width: 292, height: 118)
        welcomeLabel.numberOfLines = 0
        welcomeLabel.lineBreakMode = .byWordWrapping
        welcomeLabel.font = UIFont(name: "Hiragino Maru Gothic ProN W4", size: 50)
        welcomeLabel.text = "Welcome to Fitbynature"
        welcomeLabel.textColor = UIColor(red: 131/255, green: 81/255, blue: 81/255, alpha: 1)
   
        parent.addSubview(welcomeLabel)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.widthAnchor.constraint(equalToConstant: 292).isActive = true
        welcomeLabel.heightAnchor.constraint(equalToConstant: 118).isActive = true
        welcomeLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 24).isActive = true
        welcomeLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 517).isActive = true
        
        
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
        quoteLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 78).isActive = true
        quoteLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 647).isActive = true
        
        let continueButton = UIButton()
        continueButton.frame = CGRect(x: 0, y: 0, width: 168, height: 64)
        continueButton.setTitle("Get Started!", for: .normal)
        StyleGuide.styleFilledButton(continueButton)
        continueButton.addTarget(self, action: #selector(segueToNextScreen), for: .touchUpInside)
        
        parent.addSubview(continueButton)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.widthAnchor.constraint(equalToConstant: 168).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
        continueButton.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 130).isActive = true
        continueButton.topAnchor.constraint(equalTo: parent.topAnchor, constant: 791).isActive = true

    }
    
    @objc func segueToNextScreen() {
        performSegue(withIdentifier: "toFirstQuestion", sender: self)
    }
}
