//
//  FoodSearch.swift
//  prototype
//
//  Created by Jared Murray on 11/2/23.
//

import SwiftUI

struct FoodSearch: View {
    @State private var food: [FoodMacros] = []
    
    @State private var searchText = ""
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(food) { food in
                    NavigationLink {
                        FoodBreakdown(food: [food])
                    } label: {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(food.name.capitalized)
                                    .font(.headline)
                                Spacer()
                                Text("\(food.calories, specifier: "%.1f")")
                                
                            }
                        }
                        
                    }
                }
                
            }
            .navigationTitle("Food")
        }
        .searchable(text: $searchText)
        .onAppear(perform: runSearch)
        .onSubmit(of: .search, runSearch)
    }
    
    //    var filteredMessages: [FoodMacros] {
    //        if searchText.isEmpty {
    //            return food
    //        } else {
    //            return food.filter { $0.text.localizedCaseInsensitiveContains(searchText) }
    //        }
    //    }
    
    func runSearch() {
        Task {
            MacroController.shared.fetch(food: searchText, grams: nil) { menu in
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
