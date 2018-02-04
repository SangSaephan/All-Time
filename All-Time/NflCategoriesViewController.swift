//
//  NflCategoriesViewController.swift
//  All-Time
//
//  Created by Sang Saephan on 2/3/18.
//  Copyright © 2018 Sang Saephan. All rights reserved.
//

import UIKit
import ChameleonFramework

protocol NflCategorySelection {
    func userSelectedCategory(category: String)
}

class NflCategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let categories = ["Pass Completions", "Pass Yards", "Pass TDs", "Pass INTs", "Rush Yards", "Rush TDs", "Receptions", "Receiving Yards", "Receiving TDs", "Sacks", "Interceptions"]
    var delegate: NflCategorySelection?
    
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

extension NflCategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nflCategoryCell", for: indexPath)
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
