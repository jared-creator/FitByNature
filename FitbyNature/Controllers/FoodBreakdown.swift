//
//  FoodBreakdown.swift
//  prototype
//
//  Created by Jared Murray on 11/2/23.
//

import SwiftUI

struct FoodBreakdown: View {
    
    let foodDetail: Foods
    @State private var macro: [Nutrient_JSON] = []
    
    @State private var grams = ""
    @State private var macroDic: [String:Double] = [:]
    
    @State private var animation = false
    @State private var rotateCheckMark = 60
    @State private var showCheckMark = -60
    @State private var checkOpacity = 0.0
    @State private var circleOpacity = 0.0
    
    @State var food: [Foods]
    @State private var savedFoods = [Food]()
    
    @State private var isShowingHome = false
    
    @State private var filteredMacros: [Nutrient_JSON] = []
    let nameArray = ["Protein", "Energy", "Carbohydrate, by difference", "Sugars, total including NLEA", "Fiber, total dietary", "Sodium, Na", "Potassium, K", "Fatty acids, total saturated", "Total lipid (fat)", "Cholesterol", "Fatty acids, total trans"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack(spacing: 50) {
                        
                        ForEach(0..<foodDetail.macros.count, id: \.self) { calorie in
                            if foodDetail.macros[calorie].nutrientName == "Energy" {
                                Text("\(foodDetail.macros[calorie].value, specifier: "%.1f")  calories")
                                    .foregroundStyle(.black)
                            } else if foodDetail.macros[calorie].nutrientName == "Protein" {
                                Text("\(foodDetail.macros[calorie].value, specifier: "%.1f") protein")
                                    .foregroundStyle(.black)
                                
                            } else if foodDetail.macros[calorie].nutrientName == "Carbohydrate, by difference" {
                                Text("\(foodDetail.macros[calorie].value, specifier: "%.1f") carbs")
                                    .foregroundStyle(.black)
                            }
                        }
                    }
                    List(filteredMacros) { macro in
                        HStack {
                            if macro.nutrientName != "Protein" && macro.nutrientName !=  "Energy" && macro.nutrientName !=  "Carbohydrate, by difference" {
                                Text("\(macro.nutrientName)")
                                    .foregroundStyle(.black)
                                Spacer()
                                Text("\(macro.value, specifier: "%.1f")")
                                    .foregroundStyle(.black)
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground((Color(uiColor: UIColor(red: 251/255, green: 230/255, blue: 211/255, alpha: 1))))
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color(uiColor: UIColor(red: 251/255, green: 230/255, blue: 211/255, alpha: 1)))
                    
//                    TextField("How much did you eat in grams", text: $grams)
//                        .background(.white)
//                        .padding(.leading)
//                        .padding(.bottom)
//                        .padding(.trailing)
                    Text("All nutritional value is based on the serving size of: \(food[0].servingSize, specifier: "%.1f") \(food[0].servingSizeUnit)")
                }
                .background(Color(uiColor: UIColor(red: 251/255, green: 230/255, blue: 211/255, alpha: 1)))
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(food[0].name.capitalized)
                            .foregroundStyle(.black)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add") {
                            addFood()
                            withAnimation {
                                animation.toggle()
                                circleOpacity = 1
                                checkOpacity = 1
                                rotateCheckMark = 0
                                showCheckMark = 0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }.flatMap { $0.windows }.first{ $0.isKeyWindow}?.rootViewController?.dismiss(animated: true)
                            }
                        }
                        .buttonStyle(StyleGuide.SwiftUIButton())
                    }
                }
                Circle()
                    .stroke(lineWidth: 10)
                    .frame(width: 100, height: 100)
                    .opacity(circleOpacity)
                    .foregroundStyle(.black)
                
                Image(systemName: "checkmark")
                    .foregroundStyle(.black)
                    .fontWeight(.bold)
                    .font(.system(size: 50))
                    .opacity(checkOpacity)
                    .symbolEffect(.bounce, value: animation)
                    .rotationEffect(.degrees(Double(rotateCheckMark)))
                    .clipShape(Rectangle().offset(x: CGFloat(showCheckMark)))
            }
        }
        .onAppear {
            for index in 0..<nameArray.count {
                if food[0].macros.contains(where: {$0.nutrientName.localizedCaseInsensitiveContains(nameArray[index])}) {
                    
                    macro = food[0].macros.filter { $0.nutrientName.localizedCaseInsensitiveContains(nameArray[index])}
                    
                    filteredMacros.append(macro[0])
                    
                }
                for i in 0..<macro.count {
                    macroDic[macro[i].nutrientName] = macro[i].value
                }
            }
            
            
            print(macroDic)
            }
        }
    
    func addFood() {
        let currentTime = Date()
        
        let food = CoreDataManager.shared.createFood(name: food[0].name, calories: macroDic["Energy"] ?? 0, sugar: macroDic["Sugars"] ?? 0, fiber: macroDic["Fiber"] ?? 0, sodium: macroDic["Sodium, Na"] ?? 0, potassium: macroDic["Potassium"] ?? 0, fatSaturated: macroDic["Fatty acids, total saturated"] ?? 0, fatTotal: macroDic["Total lipid (fat)"] ?? 0, cholesterol: macroDic["Cholesterol"] ?? 0, protein: macroDic["Protein"] ?? 0, carbohydratesTotal: macroDic["Carbohydrate, by difference"] ?? 0, time: currentTime)
        savedFoods.append(food)
        CoreDataManager.shared.save()
    }
    
    
    //current api does not have a way to change the serving size
//    func amountChanged() {
//        if let amountInGrams = Int(grams) {
//            MacroController.shared.grams = amountInGrams
//            MacroController.shared.foodFetch(food: self.food[0].name) { menu in
//                DispatchQueue.main.async {
//                    food = menu
////                    getMacro()
//                }
//            }
//        }
//        
//        if let amountInGrams = Int(grams) {
//            MacroController.shared.grams = amountInGrams
//            MacroController.shared.foodFetch(food: self.food[0].name) { menu in
//                DispatchQueue.main.async {
//                    food = menu
//                    
//                }
//            }
//        }
    }


//#Preview {
//    FoodBreakdown()
//}
