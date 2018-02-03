//
//  ViewController.swift
//  All-Time
//
//  Created by Sang Saephan on 1/31/18.
//  Copyright © 2018 Sang Saephan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func sportButtonPressed(_ sender: UIButton) {
        if sender.tag == 0 {
            performSegue(withIdentifier: "goToNba", sender: "http://localhost:8181/nba/points")
        } else if sender.tag == 1 {
            performSegue(withIdentifier: "goToNfl", sender: "http://localhost:8181/nfl/passcomp")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToNba" {
            let destination = segue.destination as! NbaViewController
            destination.categoryUrl = sender as? String
        } else if segue.identifier == "goToNfl" {
            let destination = segue.destination as! NflViewController
            destination.categoryUrl = sender as? String
        }
        
    }
    
}

