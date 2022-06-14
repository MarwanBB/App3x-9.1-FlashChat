//
//  ViewController.swift
//  App3x 9.1 FlashChat
//
//  Created by Marwan Elbahnasawy on 27/05/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    let timerInterval = 0.25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showTitle()
    }

    func showTitle(){
        titleLabel.text = ""
        var timerFactor: Double = 1
        for ch in "⚡️FlashChat" {
            Timer.scheduledTimer(withTimeInterval: timerInterval*timerFactor , repeats: false) { timer in
                self.titleLabel.text = self.titleLabel.text! + String(ch)
            }
            timerFactor += 1
        }
    }

}

