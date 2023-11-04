//
//  FoodMacros.swift
//  prototype
//
//  Created by Jared Murray on 7/3/23.
//

import Foundation
struct FoodMacros: Codable, Identifiable {
    var id = UUID()
    var name: String
    var calories: Double
    var servingSize: Double
    var sugar: Double
    var fiber: Double
    var sodium: Double
    var potassium: Double
    var fatSaturated: Double
    var fatTotal: Double
    var cholesterol: Double
    var protein: Double
    var carbohydratesTotal: Double
    
    enum CodingKeys: String, CodingKey {
        case name, calories
        case servingSize = "serving_size_g"
        case fatSaturated = "fat_saturated_g"
        case fatTotal = "fat_total_g"
        case carbohydratesTotal = "carbohydrates_total_g"
        case sugar = "sugar_g"
        case fiber = "fiber_g"
        case sodium = "sodium_mg"
        case potassium = "potassium_mg"
        case cholesterol = "cholesterol_mg"
        case protein = "protein_g"
    }
     func getMacro() -> [Double] {
        let macroArray = [sugar, fiber, sodium, potassium, fatSaturated, fatTotal, cholesterol]
        return macroArray
    }
    
     func getName() -> [String] {
     let nameArray = ["sugar", "fiber", "sodium", "potassium", "fatSaturated", "fatTotal", "cholesterol"]
        return nameArray
    }
}

