//
//  FoodBreakdownViewController.swift
//  prototype
//
//  Created by Jared Murray on 7/23/23.
//

import UIKit

class FoodBreakdownViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var breakdownTable: UITableView!
    @IBOutlet weak var amountAteTextfield: UITextField!
    @IBOutlet weak var addFoodButton: UIButton!
    
    var food: [FoodMacros] = []
    var savedFoods = [Food]()
    var macro: [Any] = []
    var macroName: [String] = []
    var foodName = ""
    var calorieAmount = 10.0
    var proteinAmount = 10.0
    var carbAmount = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        breakdownTable.delegate = self
        breakdownTable.dataSource = self
        
        let foodInfo = self.food[0]
        macro = foodInfo.getMacro()
        macroName = foodInfo.getName()
        
        amountAteTextfield.clearsOnBeginEditing = true
        amountAteTextfield.attributedPlaceholder = NSAttributedString(string: "How much did you eat in grams", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        StyleGuide.styleFilledButton(addFoodButton)
        foodLabel.text = foodName.capitalized
        calorieLabel.text = "\(calorieAmount)g calories"
        proteinLabel.text = "\(proteinAmount)g protein"
        carbsLabel.text = "\(carbAmount)g carbs"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.macro.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  breakdownTable.dequeueReusableCell(withIdentifier: "Macros", for: indexPath) as! FoodBreakdownTableViewCell
        
        let foodInfo = self.food[0]
        macro = foodInfo.getMacro()
        macroName = foodInfo.getName()
        let mac = macro[indexPath.row]
        let macName = macroName[indexPath.row]
        cell.amountLabel.text = ("\(mac)")
        cell.macroLabel.text = ("\(macName.capitalized)")
        
        return cell
    }
    
    @IBAction func amountChanged(_ sender: Any) {
        if let amountInGrams = Int(amountAteTextfield.text!) {
            MacroController.shared.grams = amountInGrams
            MacroController.shared.fetch(food: self.foodName, grams: MacroController.shared.grams) { menu in
                DispatchQueue.main.async {
                    self.calorieLabel.text = "\(self.food[0].calories)g calories"
                    self.proteinLabel.text = "\(self.food[0].protein)g protein"
                    self.carbsLabel.text = "\(self.food[0].carbohydratesTotal)g carbs"
                    self.food = menu
                    self.breakdownTable.reloadData()
                }
            }
        }
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        // save to core data
        //Get current time
        let currentTime = Date()
        
        let food = CoreDataManager.shared.createFood(name: foodName, calories: calorieAmount, servingSize: self.food[0].servingSize, sugar: self.food[0].sugar, fiber: self.food[0].fiber, sodium: self.food[0].sodium, potassium: self.food[0].potassium, fatSaturated: self.food[0].fatSaturated, fatTotal: self.food[0].fatTotal, cholesterol: self.food[0].cholesterol, protein: proteinAmount, carbohydratesTotal: carbAmount, time: currentTime)
        savedFoods.append(food)
        CoreDataManager.shared.save()
        // send back to home screen
        performSegue(withIdentifier: "backHome", sender: self)
    }
}
