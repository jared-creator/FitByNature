//
//  FoodSearchViewController.swift
//  prototype
//
//  Created by Jared Murray on 7/23/23.
//

import UIKit
import SwiftUI

struct MyView: UIViewControllerRepresentable {
    typealias UIViewControllerType = FoodSearchViewController
    
    func makeUIViewController(context: Context) -> FoodSearchViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "FoodSearch") as! FoodSearchViewController
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: FoodSearchViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
        
    }
}
class FoodSearchViewController: UIViewController, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
   
     @IBOutlet weak var foodResultsTable: UITableView!
    
    let searchController = UISearchController()
    
    var food: [FoodMacros] = []
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.navigationItem.title = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodResultsTable.dataSource = self
        foodResultsTable.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.foodResultsTable.reloadData()
        searchBar.resignFirstResponder()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        MacroController.shared.fetch(food: text, grams: nil) { menu in
            DispatchQueue.main.async {
                self.food = menu
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.food.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = foodResultsTable.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as! FoodSearchTableViewCell
        
        let foodItem = self.food[indexPath.row]
        
        cell.foodLabel.text = foodItem.name.capitalized
        cell.calorieLabel.text = String(foodItem.calories)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.foodResultsTable.deselectRow(at: indexPath, animated: true)
        let food = self.food[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "FoodBreakdown") as? FoodBreakdownViewController
        
        vc?.foodName = food.name
        vc?.calorieAmount = food.calories
        vc?.proteinAmount = food.protein
        vc?.carbAmount = food.carbohydratesTotal
        vc?.food = self.food
        print(self.food)
        vc?.modalPresentationStyle = UIModalPresentationStyle.formSheet
        vc?.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        
        self.present(vc!, animated: true)
    }
}
