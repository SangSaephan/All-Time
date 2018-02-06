//
//  ViewController.swift
//  All-Time
//
//  Created by Sang Saephan on 1/31/18.
//  Copyright © 2018 Sang Saephan. All rights reserved.
//

import UIKit
import ChameleonFramework

class ViewController: UIViewController {

    @IBOutlet weak var nbaButton: UIButton!
    @IBOutlet weak var nflButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: view.frame, andColors: [UIColor.flatNavyBlueDark, UIColor.flatBlue])
        
        updateButtonsUi()
    }
    
    func updateButtonsUi() {
        
        nbaButton.layer.borderWidth = 1.0
        nflButton.layer.borderWidth = 1.0
        
        nbaButton.layer.cornerRadius = 15.0
        nflButton.layer.cornerRadius = 15.0
        
        nbaButton.layer.borderColor = (ContrastColorOf(UIColor.flatNavyBlue, returnFlat: true)).cgColor
        nflButton.layer.borderColor = (ContrastColorOf(UIColor.flatNavyBlue, returnFlat: true)).cgColor
        
        nbaButton.tintColor = ContrastColorOf(UIColor.flatNavyBlue, returnFlat: true)
        nflButton.tintColor = ContrastColorOf(UIColor.flatNavyBlue, returnFlat: true)
        
    }

    @IBAction func sportButtonPressed(_ sender: UIButton) {
        if sender.tag == 0 {
            performSegue(withIdentifier: "goToNba", sender: "\(BASE_URL)/nba/points")
        } else if sender.tag == 1 {
            performSegue(withIdentifier: "goToNfl", sender: "\(BASE_URL)/nfl/passcomp")
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

