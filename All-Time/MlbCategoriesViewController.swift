//
//  MlbCategoriesViewController.swift
//  All-Time
//
//  Created by Sang Saephan on 2/7/18.
//  Copyright © 2018 Sang Saephan. All rights reserved.
//

import UIKit
import ChameleonFramework

protocol MlbCategorySelection {
    func userSelectedCategory(category: String)
}

class MlbCategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let categories = ["Batting Average", "Hits", "Runs", "RBI", "Home Runs", "Stolen Bases", "SLG", "OBP", "Doubles", "Triples", "Wins", "Saves", "ERA", "Strikeouts", "Shutouts", "Complete Games"]
    var delegate: MlbCategorySelection?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: view.frame, andColors: [UIColor.flatNavyBlueDark, UIColor.flatBlue])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
    }

    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

extension MlbCategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mlbCategoryCell", for: indexPath)
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = categories[indexPath.row]
        cell.textLabel?.textColor = ContrastColorOf(UIColor.flatNavyBlue, returnFlat: true)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.userSelectedCategory(category: categories[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true, completion: nil)
    }
    
}
