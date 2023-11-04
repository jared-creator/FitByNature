//
//  Utilities.swift
//  customauth
//
//  Created by Christopher Ching on 2019-05-09.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class StyleGuide {
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 131/255, green: 80/255, blue: 80/255, alpha: 1).cgColor
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    
    static func styleLabel(_ label:UILabel, shadow: Bool?) {
        label.textColor = UIColor(red: 131, green: 81, blue: 81, alpha: 1)
        if shadow == true {
            label.shadowColor = UIColor.black
        }
        }
    
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 131/255, green: 81/255, blue: 81/255, alpha: 1)
        button.layer.cornerRadius = 13.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.cornerRadius = 17.0
        button.tintColor = UIColor.white
    }
    
    struct SwiftUIButton: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding(10)
                .background(Color(red: 131/255, green: 81/255, blue: 81/255))
                .tint(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15.0))
                .scaleEffect(configuration.isPressed ? 1.7 : 1)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
                
        }
    }
    
}
