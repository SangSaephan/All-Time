//
//  NhlViewController.swift
//  All-Time
//
//  Created by Sang Saephan on 2/8/18.
//  Copyright © 2018 Sang Saephan. All rights reserved.
//

import UIKit
import ChameleonFramework

class NhlViewController: UIViewController {
    
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
        
        categoryLabel.text = "Goals"
        categoryLabel.textColor = ContrastColorOf(UIColor.flatBlack, returnFlat: true)
        
        networkCall(category: categoryUrl)
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "NHL"
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
            let destination = navigationController.topViewController as! NhlCategoriesViewController
            destination.delegate = self
        }
    }

}

// MARK: - Tableview Delegate and Datasource Methods
extension NhlViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nhlCell", for: indexPath) as! NhlCell
        
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

// MARK: - NhlCategorySelection Protocol
extension NhlViewController: NhlCategorySelection {
    
    func userSelectedCategory(category: String) {
        
        switch category {
        case "Goals":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/nhl/goals")
        case "Points":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/nhl/points")
        case "Assists":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/nhl/assists")
        case "Hat Tricks":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/nhl/hattricks")
        case "Plus/Minus":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/nhl/plusminus")
        case "Penalty Minutes":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/nhl/penaltymins")
        case "Power Play Goals":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/nhl/ppgoals")
        case "Short-Handed Goals":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/nhl/shgoals")
        case "Wins":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/nhl/wins")
        case "Shutouts":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/nhl/shutouts")
        case "Avg. Goals Against":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/nhl/avggoalsagainst")
        case "Save Pct.":
            categoryLabel.text = category
            networkCall(category: "\(BASE_URL)/nhl/savepct")
        default:
            return
        }
        
    }
    
}
