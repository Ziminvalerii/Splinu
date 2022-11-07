//
//  InfoViewController.swift
//
//  Created by Artemius on 17.06.2022.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        makeEventsSandable()
//        FruitsData.shared.apples = 100
//        Coins.shared.coins = 30000
//        Training.shared.training = 49
        // Do any additional setup after loading the view.
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
