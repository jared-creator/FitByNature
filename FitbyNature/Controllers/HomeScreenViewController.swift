//
//  HomeScreenViewController.swift
//  prototype
//
//  Created by Jared Murray on 7/3/23.
//

import UIKit

class HomeScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: TableView
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var caloriesLeftLabel: UILabel!
    
    var menu: [FoodMacros] = []
    var fetchedFoods: [Food] = []
    var totalCalories: Double = 0.0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedFoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        self.table.refreshControl = nil
        table.bounces = false
        table.refreshControl?.removeFromSuperview()
        let foodInfo = fetchedFoods[indexPath.row]
        print(foodInfo.caloriesLeft)
        let currentDate = Date()
        
        var calender = Calendar.current
        calender.timeZone = TimeZone.current
        let result = calender.compare(foodInfo.time!, to: currentDate, toGranularity: .day)
        let isSameDay = result == .orderedSame
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        _ = formatter.date(from: "\(String(describing: foodInfo.time))")
        _ = formatter.date(from: "\(currentDate)")
    
        if isSameDay == true {
            let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
                        
            totalCalories += foodInfo.calories
               
            let caloriesLeft = caloriesLeft()
            foodInfo.caloriesLeft = caloriesLeft
            print("This is what calories are left:\(caloriesLeft)")
            
            caloriesLeftLabel.text = String("\(foodInfo.caloriesLeft) calories left for today")
            cell.calLabel.text = String(foodInfo.calories)
            cell.foodLabel.text = foodInfo.name?.capitalized
            cell.timeLabel.text = formatter.string(from: foodInfo.time!)
            handleTap(is: false)
            return cell
        } else {
            let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.table.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let foodToRemove = self.fetchedFoods[indexPath.row]
            print(foodToRemove)
            
            totalCalories -= foodToRemove.calories
            print("Total calories when deleted pressed:\(foodToRemove.calories)")
            print("This is the total calories within the delete function \(totalCalories)")
            
            CoreDataManager.shared.context.delete(foodToRemove)
            CoreDataManager.shared.save()
            fetchedFoods.remove(at: indexPath.row)
            table.deleteRows(at: [indexPath], with: .left)
            
            if fetchedFoods.isEmpty {
                caloriesLeftLabel.text = String("\(CoreDataManager.shared.stats![0].calories) calories left for today")
                handleTap(is: true)
            }
            totalCalories = 0
            self.table.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    @IBAction func addTapped(_ sender: Any) {
        performSegue(withIdentifier: "toFoodSearch", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        table.delegate = self
        table.dataSource = self
        table.refreshControl = nil
        CoreDataManager.shared.fetchUser()
        caloriesLeftLabel.text = String("\(CoreDataManager.shared.stats![0].calories) calories left for today")
        fetchedFoods = CoreDataManager.shared.fetchFood()
    }
    
    
    
    func caloriesLeft() -> Int64 {
        let caloriesLeft = CoreDataManager.shared.stats![0].calories - Int64(totalCalories)
        return caloriesLeft
    }
    
    let calorieCircle = CAShapeLayer()
    
    func addSubViews() {
        let center = view.center
        
        //create track layer
        let trackLayer = CAShapeLayer()
        trackLayer.position = CGPoint(x: view.bounds.minX, y: view.bounds.midY - 750)
        calorieCircle.position = CGPoint(x: view.bounds.minX, y: view.bounds.midY - 750)
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 25, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        trackLayer.path = circularPath.cgPath
        
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        view.layer.addSublayer(trackLayer)
        
        calorieCircle.path = circularPath.cgPath
        
        calorieCircle.strokeColor = UIColor(red: 1, green: 0.737, blue: 0.737, alpha: 1).cgColor
        calorieCircle.lineWidth = 10
        calorieCircle.fillColor = UIColor.clear.cgColor
        calorieCircle.lineCap = .butt
        
        calorieCircle.strokeEnd = 0
        
        view.layer.addSublayer(calorieCircle)
        
        
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 146, height: 39)
        view.textColor = UIColor(red: 0.514, green: 0.318, blue: 0.318, alpha: 1)
        view.font = UIFont(name: "Hiragino Maru Gothic ProN W4", size: 30)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.76
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(string: "Today", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])

        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 146).isActive = true
        view.heightAnchor.constraint(equalToConstant: 39).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 170).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 70).isActive = true
        
        
    }
    
    @objc private func handleTap(is reverse: Bool) {
        calorieCircle.removeAllAnimations()
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        let currentCalories = (totalCalories) / Double(CoreDataManager.shared.stats![0].calories)
        
        basicAnimation.duration = 1
        
        if reverse == false {
            
            basicAnimation.toValue = currentCalories
            basicAnimation.fillMode = .forwards
            basicAnimation.isRemovedOnCompletion = false
            
            calorieCircle.add(basicAnimation, forKey: "urSoBasic")
            
        } else {
            
            basicAnimation.toValue = currentCalories
            basicAnimation.fromValue = currentCalories
            basicAnimation.fillMode = .backwards
            basicAnimation.isRemovedOnCompletion = false
            
            calorieCircle.add(basicAnimation, forKey: "animation")
            
        }
    }
}
