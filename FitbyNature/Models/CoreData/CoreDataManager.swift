//
//  CoreDataManager.swift
//  prototype
//
//  Created by Jared Murray on 7/25/23.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var stats: [Person]?

    
    func save() {
        if context.hasChanges {
            do {
                try context.save()
                print("saved")
            } catch {
                print("An error ocurred while saving: \(error.localizedDescription)")
            }
        }
    }
}

// MARK:- Helper functions
extension CoreDataManager {
    
    func fetchUser() {
        do {
            let request = Person.fetchRequest() as NSFetchRequest<Person>
            
            self.stats = try context.fetch(request)
            
        } catch {
            print("could not fetch user \(error.localizedDescription)")
        }
    }
    
    func createFood(name: String, calories: Double, servingSize: Double, sugar: Double, fiber: Double, sodium: Double, potassium: Double, fatSaturated: Double, fatTotal: Double, cholesterol: Double, protein: Double, carbohydratesTotal: Double, time: Date) -> Food {
        let food = Food(context: context)
        food.name = name
        food.calories = calories
        food.servingSize = servingSize
        food.sugar = sugar
        food.fiber = fiber
        food.sodium = sodium
        food.potassium = potassium
        food.saturatedFat = fatSaturated
        food.totalFat = fatTotal
        food.cholesterol = cholesterol
        food.protein = protein
        food.carbohydrates = carbohydratesTotal
        food.time = time
        return food
    }
    
    func fetchFood() -> [Food] {
        let request: NSFetchRequest<Food> = Food.fetchRequest()
        var fetchedFood: [Food] = []
        
        do {
            fetchedFood = try context.fetch(request)
        } catch {
            print("Error fetching food \(error)")
        }
        return fetchedFood
    }
    
    func deleteFood(food: Food) {
        context.delete(food)
        save()
    }
    
}
