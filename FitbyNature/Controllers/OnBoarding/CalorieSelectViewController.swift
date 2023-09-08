//
//  CalorieSelectViewController.swift
//  prototype
//
//  Created by Jared Murray on 7/15/23.
//

import UIKit
import CoreData

class CalorieSelectViewController: UIViewController {
    
    @IBOutlet weak var sexSegmentedControl: UISegmentedControl!
    @IBOutlet weak var activityLevelSegmentedControl: UISegmentedControl!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    var sexValue = 0
    var sex = "female"
    var activityLevelIndex = 0
    var age: Int?
    var activity = activityLevel.moderate
    var calories: Int?
    
    
    enum activityLevel {
        case sedentary, moderate, very
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        CoreDataManager.shared.fetchUser()
        
        
        setupToolBar()
        sexChanged(sexSegmentedControl)
        activityLevelChanged(activityLevelSegmentedControl)
        StyleGuide.styleFilledButton(doneButton)
        
        sexSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Hiragino Maru Gothic ProN W4", size: 20)!], for: .selected)
        activityLevelSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Hiragino Maru Gothic ProN W4", size: 20)!], for: .selected)
    }
    
    func setupToolBar() {
        //Create a toolbar
        let bar = UIToolbar()
        //Create a done button with an action to trigger our function to dismiss the keyboard
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissMyKeyboard))
        //Create a felxible space item so that we can add it around in toolbar to position our done button
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //Add the created button items in the toobar
        bar.items = [flexSpace, flexSpace, doneBtn]
        bar.sizeToFit()
        //Add the toolbar to our textfield
        ageTextField.inputAccessoryView = bar
    }
    
    @objc func dismissMyKeyboard() {
        view.endEditing(true)
    }
    
    func womenCalories() {
        if age != nil {
            if sexValue == 1 {
                switch activity {
                case .sedentary:
                    if age! <= 25 {
                        calorieLabel.text = "2,000"
                    } else if age! >= 26 && age! <= 30 {
                        calorieLabel.text = "1,800"
                    } else if age! >= 31 && age! <= 50 {
                        calorieLabel.text = "1,800"
                    } else if age! >= 51 && age! <= 60 {
                        calorieLabel.text = "1,600"
                    } else if age! >= 61 {
                        calorieLabel.text = "1,600"
                    }
                case .moderate:
                    if age! <= 25 {
                        calorieLabel.text = "2,200"
                    } else if age! >= 26 && age! <= 30 {
                        calorieLabel.text = "2,00"
                    } else if age! >= 31 && age! <= 50 {
                        calorieLabel.text = "2,000"
                    } else if age! >= 51 && age! <= 60 {
                        calorieLabel.text = "1,800"
                    } else if age! >= 61 {
                        calorieLabel.text = "1,800"
                    }
                case .very:
                    if age! <= 25 {
                        calorieLabel.text = "2,400"
                    } else if age! >= 26 && age! <= 30 {
                        calorieLabel.text = "2,400"
                    } else if age! >= 31 && age! <= 50 {
                        calorieLabel.text = "2,200"
                    } else if age! >= 51 && age! <= 60 {
                        calorieLabel.text = "2,200"
                    } else if age! >= 61 {
                        calorieLabel.text = "2,000"
                    }
                }
            } else {
                menCalories()
            }
            
        } else {
            calorieLabel.text = "Enter an age"
        }
    }
    
    func menCalories() {
        if age != nil {
            if sexValue == 0 {
                switch activity {
                case .sedentary:
                    if age! <= 25 {
                        calorieLabel.text = "2,400"
                    } else if age! >= 26 && age! <= 35 {
                        calorieLabel.text = "2,400"
                    } else if age! >= 36 && age! <= 40 {
                        calorieLabel.text = "2,400"
                    } else if age! >= 41 && age! <= 45 {
                        calorieLabel.text = "2,200"
                    } else if age! >= 46 && age! <= 55 {
                        calorieLabel.text = "2,200"
                    } else if age! >= 56 && age! <= 60 {
                        calorieLabel.text = "2,200"
                    } else if age! >= 61 && age! <= 65 {
                        calorieLabel.text = "2,000"
                    } else if age! >= 66 && age! <= 75 {
                        calorieLabel.text = "2,000"
                    } else if age! >= 76 {
                        calorieLabel.text = "2,000"
                    }
                    
                case .moderate:
                    if age! <= 25 {
                        calorieLabel.text = "2,800"
                    } else if age! >= 26 && age! <= 35 {
                        calorieLabel.text = "2,600"
                    } else if age! >= 36 && age! <= 40 {
                        calorieLabel.text = "2,600"
                    } else if age! >= 41 && age! <= 45 {
                        calorieLabel.text = "2,600"
                    } else if age! >= 46 && age! <= 55 {
                        calorieLabel.text = "2,400"
                    } else if age! >= 56 && age! <= 60 {
                        calorieLabel.text = "2,400"
                    } else if age! >= 61 && age! <= 65 {
                        calorieLabel.text = "2,400"
                    } else if age! >= 66 && age! <= 75 {
                        calorieLabel.text = "2,200"
                    } else if age! >= 76 {
                        calorieLabel.text = "2,200"
                    }
                case .very:
                    if age! <= 25 {
                        calorieLabel.text = "3,000"
                    } else if age! >= 26 && age! <= 35 {
                        calorieLabel.text = "3,000"
                    } else if age! >= 36 && age! <= 40 {
                        calorieLabel.text = "2,800"
                    } else if age! >= 41 && age! <= 45 {
                        calorieLabel.text = "2,800"
                    } else if age! >= 46 && age! <= 55 {
                        calorieLabel.text = "2,800"
                    } else if age! >= 56 && age! <= 60 {
                        calorieLabel.text = "2,600"
                    } else if age! >= 61 && age! <= 65 {
                        calorieLabel.text = "2,600"
                    } else if age! >= 66 && age! <= 75 {
                        calorieLabel.text = "2,600"
                    } else if age! >= 76 {
                        calorieLabel.text = "2,400"
                    }
                }
            } else {
                womenCalories()
            }
        }
        else {
            calorieLabel.text = "Enter an age"
        }
    }
    
    @IBAction func sexChanged(_ sender: UISegmentedControl) {
        sexValue = sender.selectedSegmentIndex
        if sexValue == 0 {
            menCalories()
        } else if sexValue == 1 {
            womenCalories()
        }
        if sexValue == 1 {
            sexSegmentedControl.selectedSegmentTintColor = UIColor(red: 255/255, green: 188/255, blue: 188/255, alpha: 1)
            activityLevelSegmentedControl.selectedSegmentTintColor = UIColor(red: 219/255, green: 196/255, blue: 240/255, alpha: 1)
        } else if sexValue == 0 {
            sexSegmentedControl.selectedSegmentTintColor = UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1)
            activityLevelSegmentedControl.selectedSegmentTintColor = UIColor(red: 244/255, green: 242/255, blue: 222/255, alpha: 1)
        }
    }
    
    @IBAction func activityLevelChanged(_ sender: UISegmentedControl) {
        activityLevelIndex = sender.selectedSegmentIndex
        if activityLevelIndex == 0 {
            activity = .sedentary
            menCalories()
            womenCalories()
        } else if activityLevelIndex == 1 {
            activity = .moderate
            menCalories()
            womenCalories()
        } else if activityLevelIndex == 2 {
            activity = .very
            menCalories()
            womenCalories()
        }
        print(activityLevelIndex)
    }
    
    @IBAction func ageChanged(_ sender: UITextField) {
        age = Int(ageTextField.text!)
        activityLevelChanged(activityLevelSegmentedControl)
        sexChanged(sexSegmentedControl)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        let comma: Set<Character> = [","]
        calorieLabel.text?.removeAll(where: {comma.contains(($0))})
        calories = Int(calorieLabel.text!)
        
        if age != nil {
            
           // Create a new user
            let newUser = Person(context: CoreDataManager.shared.context)
            newUser.calories = Int64(calories!)
            newUser.sex = sex
            newUser.age = Int64(age!)
            
            // Save the data
            CoreDataManager.shared.save()
            
            displayAlert(gender: sexValue)
            UserDefaults.standard.set(ageTextField.text, forKey: "name")
            ////
            ////        performSegue(withIdentifier: "toMain", sender: self)
        }
    }
    
    
    func displayAlert(gender: Int) {
        guard let _ = viewIfLoaded?.window else {return}
        
        if gender == 0 {
            sex = "male"
        } else if gender == 1 {
            sex = "female"
        }
        
        let alert = UIAlertController(title: "Does everything look right?", message: "You are a \(age!) year old \(sex) and your starting calories are \(calories!)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            self.performSegue(withIdentifier: "homeScreen", sender: nil)
        }))
        self.present(alert, animated: true)
    }
    
}

