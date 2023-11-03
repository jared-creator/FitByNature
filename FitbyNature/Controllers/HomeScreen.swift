//
//  ContentView.swift
//  FitByNature-HomeScreen-In-SwiftUI
//
//  Created by Jared Murray on 10/29/23.
//

import SwiftUI
import Foundation

struct HomeScreen: View {
    
    @State private var foodCalories = 0
    @State private var progress: CGFloat = 0.2
    @State private var showingSearch = false
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var user: FetchedResults<Person>
    @FetchRequest(sortDescriptors: []) var foods: FetchedResults<Food>
    
    var totalCalories: Double = 0.0
    
    var body: some View {
            VStack {
                Text("Today")
                    .font(.custom("Hiragino Maru Gothic ProN W4", size: 30))
                    .foregroundColor(Color(uiColor: UIColor(red: 0.514, green: 0.318, blue: 0.318, alpha: 1)))
                
                Spacer(minLength: 30)
                CircularProgressView(progress: progress)
                    .frame(width: 100, height: 50) // adjust size as needed
                
                Spacer(minLength: 40)
                
                Text("\(foodCalories) left for today")
                    .font(.custom("Hiragino Maru Gothic ProN W4", size: 12))
                    .foregroundColor(.black)
                
                Spacer(minLength: 50)
                
                NavigationStack {
                    List {
                        ForEach(foods) { food in
                            
                            HStack {
                                let sameDay = sameDay(date: food.time!)
                                let foodDate = dateFormatter(date: food.time!)
                                
                                if sameDay == true {
                                    
                                    Text("\(foodDate)")
                                        .font(.callout)
                                    Text("\(food.name?.capitalized ?? "")")
                                    Spacer()
                                    Text("\(food.calories, specifier: "%.1f")")
                                    
                                } else {
                                    Text("")
                                }
                            }
                            
                        }
                        .onDelete(perform: deleteFood)
                        .listRowBackground((Color(uiColor: UIColor(red: 251/255, green: 230/255, blue: 211/255, alpha: 1))))
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color(uiColor: UIColor(red: 251/255, green: 230/255, blue: 211/255, alpha: 1)))
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                showingSearch.toggle()
                            }, label: {
                                Image(systemName: "plus")
                            })
                        }
                    }
                }.sheet(isPresented: $showingSearch, content: {
                    MyView().ignoresSafeArea()
                })
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(uiColor: UIColor(red: 251/255, green: 230/255, blue: 211/255, alpha: 1)))
    }
    
    func caloriesLeft(calories: Int) -> Int64 {
        let caloriesLeft = CoreDataManager.shared.stats![0].calories - Int64(totalCalories)
        let calories = caloriesLeft
        return calories
    }
    
    func deleteFood(at offsets: IndexSet) {
        for offset in offsets {
            let food = foods[offset]
                moc.delete(food)
        }
            try? moc.save()
    }

    func dateFormatter(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        let stringDate = formatter.string(from: date)
        return stringDate
    }

    func sameDay(date: Date) -> Bool {
        let currentDate = Date()
        
        var calender = Calendar.current
        calender.timeZone = TimeZone.current
        let result = calender.compare(date, to: currentDate, toGranularity: .day)
        let isSameDay = result == .orderedSame
        return isSameDay
    }
}

struct CircularProgressView: View {
    let progress: CGFloat
    
    var body: some View {
        ZStack {
            // Background for the progress bar
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.1)
                .foregroundColor(Color(UIColor.lightGray))
            
            // Foreground or the actual progress bar
            Circle()
                .trim(from: 0.0, to: min(progress, 1.0))
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color(UIColor(red: 1, green: 0.737, blue: 0.737, alpha: 1)))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress)
        }
    }
}

//#Preview {
//    HomeScreen()
//        
//}
