//
//  FoodSearch.swift
//  prototype
//
//  Created by Jared Murray on 11/2/23.
//

import SwiftUI

struct FoodSearch: View {
    @State private var food: [Foods] = []
    
    @State private var searchText = ""
    
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                List {
                    ForEach(food, id: \.id) { food in
                        NavigationLink {
                            FoodBreakdown(foodDetail: food, food: [food])
                        } label: {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(food.name.capitalized)
                                        .font(.headline)
                                    Spacer()
                                    ForEach(0..<food.macros.count, id: \.self) { macro in
                                        if food.macros[macro].nutrientName == "Energy" {
                                            Text("\(food.macros[macro].value, specifier: "%.2f")")
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .listRowBackground((Color(uiColor: UIColor(red: 251/255, green: 230/255, blue: 211/255, alpha: 1))))
                }
                .scrollContentBackground(.hidden)
                .background(Color(uiColor: UIColor(red: 251/255, green: 230/255, blue: 211/255, alpha: 1)))
                .navigationTitle("Food")
            }
            .searchable(text: $searchText)
            .onSubmit(of: .search, runSearch)
        }
    }
    
    func runSearch() {
        Task {
            MacroController.shared.foodFetch(food: searchText) { menu in
                DispatchQueue.main.async {
                    self.food = menu
                }
            }
        }
    }
}

#Preview {
    FoodSearch()
}
