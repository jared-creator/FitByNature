//
//  MacroController.swift
//  prototype
//
//  Created by Jared Murray on 7/3/23.
//

import Foundation
class MacroController {
    
    static let shared = MacroController()
    static let personStatsUpdate =
    Notification.Name("MacroController.personUpdated")
    
    var grams = 100
    
    var foodMacro: [Foods] = []
    var query = ""
    
    var menu: [Foods] = []
    
    func foodFetch(food: String, completionHandler: @escaping ([Foods]) -> Void) {
        query = "\(food)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let decoder = JSONDecoder()
        
        let url = URL(string: "https://api.nal.usda.gov/fdc/v1/foods/search?api_key=Zn52LCe2u6U93JFcHYnmt40hy145VmWlq57eRNxF&query=\(query)&pageSize=3")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            guard let data = data else { return }
            
            do {
                let result = try decoder.decode(foods.self, from: data)
                self.menu = result.foods
                completionHandler(self.menu)
            }
            catch {
                print("failed to convert \(error)")
            }
        }
        task.resume()
    }
}
