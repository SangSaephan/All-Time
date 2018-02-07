//
//  MlbViewController.swift
//  All-Time
//
//  Created by Sang Saephan on 2/7/18.
//  Copyright © 2018 Sang Saephan. All rights reserved.
//

import UIKit
import ChameleonFramework

class MlbViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryView: UIView!
    
    var players = [Dictionary<String, Any>]()
    var categoryUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: view.frame, andColors: [UIColor.flatNavyBlueDark, UIColor.flatBlue])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        
        categoryView.layer.cornerRadius = 10.0
        
        categoryLabel.text = "Batting Average"
        categoryLabel.textColor = ContrastColorOf(UIColor.flatBlack, returnFlat: true)
        
        networkCall(category: categoryUrl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "MLB"
        tableView.setContentOffset(.zero, animated: true)
    }

    // MARK: - Network Call
    func networkCall(category: String?) {
        
        if let urlString = category {
            let url = URL(string: urlString)!
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print("Error!")
                } else {
                    if let data = data {
                        do {
                            let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [Dictionary<String, Any>]
                            
                            if let json = jsonSerialized {
                                self.players = json
                            }
                        } catch {
                            print("Error")
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
            task.resume()
        }
        
    }
    
    // MARK: - Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categorySelection" {
            let navigationController = segue.destination as! UINavigationController
            let destination = navigationController.topViewController as! MlbCategoriesViewController
            destination.delegate = self
        }
    }

}

// MARK: - Tableview Delegate and Datasource Methods
extension MlbViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mlbCell", for: indexPath) as! MlbCell
        
        if players[indexPath.row]["active"] as! Bool == true {
            cell.nameLabel.text = "\(indexPath.row + 1). \((players[indexPath.row]["name"] as! String).uppercased())"
        } else {
            cell.nameLabel.text = "\(indexPath.row + 1). \(players[indexPath.row]["name"] as! String)"
        }
        
        if let stat = players[indexPath.row]["stat"] as? Int {
            cell.statLabel.text = "\(stat)"
        } else {
            cell.statLabel.text = "\(players[indexPath.row]["stat"] as! Double)"
        }
        
        return cell
    }
    
}

// MARK: - MlbCategorySelection Protocol
extension MlbViewController: MlbCategorySelection {
    
    func userSelectedCategory(category: String) {
        
        switch category {
        case "Batting Average":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/mlb/avg")
        case "Hits":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/mlb/hits")
        case "Runs":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/mlb/runs")
        case "RBI":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/mlb/rbi")
        case "Home Runs":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/mlb/hr")
        case "Stolen Bases":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/mlb/steals")
        case "SLG":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/mlb/slg")
        case "OBP":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/mlb/obp")
        case "Doubles":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/mlb/doubles")
        case "Triples":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/mlb/triples")
        case "Wins":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/mlb/wins")
        case "Saves":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/mlb/saves")
        case "ERA":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/mlb/era")
        case "Strikeouts":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/mlb/strikeouts")
        case "Shutouts":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/mlb/shutouts")
        case "Complete Games":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/mlb/cg")
        default:
            return
        }
        
    }
    
}
