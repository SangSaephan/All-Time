//
//  NflViewController.swift
//  All-Time
//
//  Created by Sang Saephan on 2/1/18.
//  Copyright © 2018 Sang Saephan. All rights reserved.
//

import UIKit
import ChameleonFramework

class NflViewController: UIViewController {

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
        
        categoryLabel.text = "Pass Completions"
        categoryLabel.textColor = ContrastColorOf(UIColor.flatBlack, returnFlat: true)
        
        networkCall(category: categoryUrl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "NFL"
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
            let destination = navigationController.topViewController as! NflCategoriesViewController
            destination.delegate = self
        }
    }

}

// MARK: - Tableview Delegate and Datasource Methods
extension NflViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nflCell", for: indexPath) as! NflCell
        
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

// MARK: - NflCategorySelection Protocol
extension NflViewController: NflCategorySelection {
    
    func userSelectedCategory(category: String) {
        
        switch category {
        case "Pass Completions":
            categoryLabel.text = category
            networkCall(category: "http://localhost:8181/nfl/passcomp")
        case "Pass Yards":
            categoryLabel.text = category
            networkCall(category: "http://localhost:8181/nfl/passyards")
        case "Pass TDs":
            categoryLabel.text = category
            networkCall(category: "http://localhost:8181/nfl/passtds")
        case "Pass INTs":
            categoryLabel.text = category
            networkCall(category: "http://localhost:8181/nfl/passints")
        case "Rush Yards":
            categoryLabel.text = category
            networkCall(category: "http://localhost:8181/nfl/rushyards")
        case "Rush TDs":
            categoryLabel.text = category
            networkCall(category: "http://localhost:8181/nfl/rushtds")
        case "Receptions":
            categoryLabel.text = category
            networkCall(category: "http://localhost:8181/nfl/receptions")
        case "Receiving Yards":
            categoryLabel.text = category
            networkCall(category: "http://localhost:8181/nfl/recyards")
        case "Receiving TDs":
            categoryLabel.text = category
            networkCall(category: "http://localhost:8181/nfl/rectds")
        case "Sacks":
            categoryLabel.text = category
            networkCall(category: "http://localhost:8181/nfl/defsacks")
        case "Interceptions":
            categoryLabel.text = category
            networkCall(category: "http://localhost:8181/nfl/defints")
        default:
            return
        }
        
    }
    
}
