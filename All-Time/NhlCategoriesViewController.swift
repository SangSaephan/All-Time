//
//  NhlCategoriesViewController.swift
//  All-Time
//
//  Created by Sang Saephan on 2/8/18.
//  Copyright © 2018 Sang Saephan. All rights reserved.
//

import UIKit
import ChameleonFramework

protocol NhlCategorySelection {
    func userSelectedCategory(category: String)
}

class NhlCategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let categories = ["Goals", "Points", "Assists", "Hat Tricks", "Plus/Minus", "Penalty Minutes", "Power Play Goals", "Short-Handed Goals", "Wins", "Shutouts", "Avg. Goals Against", "Save Pct."]
    var delegate: NhlCategorySelection?
    
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

extension NhlCategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nhlCategoryCell", for: indexPath)
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
