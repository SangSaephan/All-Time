//
//  NbaCategoriesViewController.swift
//  All-Time
//
//  Created by Sang Saephan on 2/1/18.
//  Copyright © 2018 Sang Saephan. All rights reserved.
//

import UIKit
import ChameleonFramework

protocol NbaCategorySelection {
    func userSelectedCategory(category: String)
}

class NbaCategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let categories = ["Points", "Assists", "Rebounds", "Blocks", "Steals", "Turnovers", "FG%", "FT%", "3PT%"]
    var delegate: NbaCategorySelection?
    
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

extension NbaCategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nbaCategoryCell", for: indexPath)
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
