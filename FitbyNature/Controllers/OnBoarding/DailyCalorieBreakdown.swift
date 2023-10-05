//
//  SetUpViewController.swift
//  prototype
//
//  Created by Jared Murray on 5/15/23.
//

import UIKit

class DailyCalorieBreakdown: UIViewController {
        
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView()
        let parent = self.view!
        
        //Image view
        let imageName = "istockphoto-1148608353-612x612 1"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(imageView)
        
        imageView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: self.view.frame.height - 400).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 140).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        view.layer.cornerRadius = 49
        
        
        parent.addSubview(view)
        
        let textView = UITextView()
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.center = self.view.center
        textView.textAlignment = NSTextAlignment.justified
        textView.text = DailyCalorieExplanation().explanation
        textView.font = UIFont(name: "Hiragino Maru Gothic ProN W4", size: 15)
        textView.textColor = UIColor(red: 131/255, green: 81/255, blue: 81/255, alpha: 1)
        textView.backgroundColor = UIColor(red: 255/255, green: 232/255, blue: 212/255, alpha: 1)
        textView.isEditable = false
        textView.isSelectable = false
        
        parent.addSubview(textView)

        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30).isActive = true
        textView.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0).isActive = true
        textView.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: 0).isActive = true
        textView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 125).isActive = true
        
        continueButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 70).isActive = true
        
        StyleGuide.styleFilledButton(continueButton)
    }
    
    struct DailyCalorieExplanation {
        let explanation = " We believe that it is best to track your current diet, no matter how unhealthy it is, and to see whether to add or lessen the amount you eat based on your weight at the start and end of that week. We recommend to add or subtract by smaller amounts like 200 - 500. In terms of macro and micro nutrients it is best to eat a well balanced diet unless told otherwise by a professional. Don’t worry! We will include some recommended calories for you on the next screen just in case. Now let's achieve that goal of yours together!"
    }
}

