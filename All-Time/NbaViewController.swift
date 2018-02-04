//
//  NbaViewController.swift
//  All-Time
//
//  Created by Sang Saephan on 2/1/18.
//  Copyright © 2018 Sang Saephan. All rights reserved.
//

import UIKit
import ChameleonFramework

class NbaViewController: UIViewController {

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
        
        categoryLabel.text = "Points"
        categoryLabel.textColor = ContrastColorOf(UIColor.flatBlack, returnFlat: true)
        
        networkCall(category: categoryUrl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "NBA"
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
            let destination = navigationController.topViewController as! NbaCategoriesViewController
            destination.delegate = self
        }
    }

}

// MARK: - Tableview Delegate and Datasource Methods
extension NbaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nbaCell", for: indexPath) as! NbaCell
        
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

// MARK: - NbaCategorySelection Protocol
extension NbaViewController: NbaCategorySelection {
    
    func userSelectedCategory(category: String) {
        if category == "Points" {
            categoryLabel.text = category
            networkCall(category: "http://localhost:8181/nba/points")
        } else if category == "Assists" {
            categoryLabel.text = category
            networkCall(category: "http://localhost:8181/nba/assists")
        } else if category == "Rebounds" {
            categoryLabel.text = category
            networkCall(category: "http://localhost:8181/nba/rebounds")
        } else if category == "Blocks" {
            categoryLabel.text = category
            networkCall(category: "http://localhost:8181/nba/blocks")
        } else if category == "Steals" {
            categoryLabel.text = category
            networkCall(category: "http://localhost:8181/nba/steals")
        } else if category == "Turnovers" {
            categoryLabel.text = category
            networkCall(category: "http://localhost:8181/nba/turnovers")
        } else if category == "FG%" {
            categoryLabel.text = category
            networkCall(category: "http://localhost:8181/nba/fgpct")
        } else if category == "FT%" {
            categoryLabel.text = category
            networkCall(category: "http://localhost:8181/nba/ftpct")
        } else if category == "3PT%" {
            categoryLabel.text = category
            networkCall(category: "http://localhost:8181/nba/3ptpct")
        }
    }
    
}
