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
        
    var menu: [FoodMacros] = []
    var query = ""
    var grams = 100
    
    func fetch(food: String, grams: Any?, completionHandler: @escaping ([FoodMacros]) -> Void) {
        self.query = "\(self.grams)grams \(food)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(query)
        let url = URL(string: "https://api.calorieninjas.com/v1/nutrition?query="+query)!
        var request = URLRequest(url: url)
        request.setValue("n0xEhStieYFlUP5aemGlMQ==gkIV2JT0zfexoip2", forHTTPHeaderField: "X-Api-Key")
       
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
            do {
                let decoder = JSONDecoder()
                let menuResponse = try decoder.decode(items.self, from: data)
                self.menu = menuResponse.items
                completionHandler(self.menu)
            
            } catch {
                print(error)
            }
        }
       
        task.resume()
    }
}
