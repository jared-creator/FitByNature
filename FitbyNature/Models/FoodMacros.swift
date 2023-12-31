//
//  FoodMacros.swift
//  prototype
//
//  Created by Jared Murray on 7/3/23.
//

import Foundation
struct foodNutrients: Codable {
    var foodNutrients: [Nutrient_JSON]
}

struct foods: Codable {
    var foods: [Foods]
}

struct Foods: Codable {
    let id = UUID()
    let name: String
    let macros: [Nutrient_JSON]
    let servingSize: Double
    let servingSizeUnit: String
    
    enum CodingKeys: String, CodingKey {
        case name = "description"
        case macros = "foodNutrients"
        case servingSize
        case servingSizeUnit
    }
    
//    func getMacro() -> [Double] {
//       let macroArray = [sugar, fiber, sodium, potassium, fatSaturated, fatTotal, cholesterol]
//       return macroArray
//   }
//   
//    func getName() -> [String] {
//    let nameArray = ["sugar", "fiber", "sodium", "potassium", "fatSaturated", "fatTotal", "cholesterol"]
//       return nameArray
//   }

    var filteredMacros: [Nutrient_JSON] {
    let nameArray = ["Protein", "Energy"]
        return macros.filter { $0.nutrientName.localizedCaseInsensitiveContains(nameArray[0]) }
    }
    
}

struct Nutrient_JSON : Codable, Identifiable {
    let id = UUID()
    let nutrientId: Int
    let nutrientName: String
    let nutrientNumber: String
    let unitName: String
    let value: Double
    
}
