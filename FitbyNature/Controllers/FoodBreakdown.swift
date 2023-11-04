//
//  FoodBreakdown.swift
//  prototype
//
//  Created by Jared Murray on 11/2/23.
//

import SwiftUI

struct FoodBreakdown: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var macro: [Double] = []
    @State private var macroName: [String] = []
    @State private var grams = ""
    @State private var calories: Double = 0.0
    @State private var protein: Double = 0.0
    @State private var carbs: Double = 0.0
    
    @State var food: [FoodMacros]
    @State private var savedFoods = [Food]()
    
    @State private var isShowingHome = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: 50) {
                    
                    Text("\(calories, specifier: "%.1f")  calories")
                    
                    Text("\(protein, specifier: "%.1f") protein")
                    
                    Text("\(carbs, specifier: "%.1f") carbs")
                }
                List {
                    ForEach(Array(macroName.enumerated()), id: \.element) { index, name in
                        HStack {
                            Text("\(name.capitalized)")
                            Spacer()
                            Text("\(macro[index], specifier: "%.1f")")
                        }
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground((Color(uiColor: UIColor(red: 251/255, green: 230/255, blue: 211/255, alpha: 1))))
                }
                .scrollContentBackground(.hidden)
                .background(Color(uiColor: UIColor(red: 251/255, green: 230/255, blue: 211/255, alpha: 1)))
                
                
                TextField("How much did you eat in grams",text: $grams)
                    .padding(.leading)
                    .onSubmit {
                        amountChanged()
                    }
            }
            .background(Color(uiColor: UIColor(red: 251/255, green: 230/255, blue: 211/255, alpha: 1)))
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(food[0].name.capitalized)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        addFood()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }.flatMap { $0.windows }.first{ $0.isKeyWindow}?.rootViewController?.dismiss(animated: true)
                        }
                    }
                    .buttonStyle(StyleGuide.SwiftUIButton())
                }
            }
        }.onAppear(perform: {
            getMacroName()
            getMacro()
        })
    }
    
    func getMacroName() {
        self.macroName = food[0].getName()
    }
    
    func getMacro() {
        self.macro = food[0].getMacro()
        calories = food[0].calories
        print(calories)
        protein = food[0].protein
        carbs = food[0].carbohydratesTotal
    }
    
    func addFood() {
        let currentTime = Date()
        
        let food = CoreDataManager.shared.createFood(name: food[0].name, calories: calories, servingSize: self.food[0].servingSize, sugar: self.food[0].sugar, fiber: self.food[0].fiber, sodium: self.food[0].sodium, potassium: self.food[0].potassium, fatSaturated: self.food[0].fatSaturated, fatTotal: self.food[0].fatTotal, cholesterol: self.food[0].cholesterol, protein: protein, carbohydratesTotal: carbs, time: currentTime)
        savedFoods.append(food)
        CoreDataManager.shared.save()
    }
    
    func amountChanged() {
        if let amountInGrams = Int(grams) {
            MacroController.shared.grams = amountInGrams
            MacroController.shared.fetch(food: self.food[0].name, grams: MacroController.shared.grams) { menu in
                DispatchQueue.main.async {
                    food = menu
                    getMacro()
                }
            }
        }
    }
}

//#Preview {
//    FoodBreakdown()
//}
