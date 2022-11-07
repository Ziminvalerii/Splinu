//
//  SellBottleController.swift
//  JuiceFactory
//
//  Created by Artemius on 09.08.2022.
//

import UIKit

class SellBottleController: UIViewController {

    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var bottle: UIImageView!
    @IBOutlet weak var popUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.layer.cornerRadius = 15
        bottle.image = UIImage(named: BottleTheme.shared.currentBottle)
        cost.text = String(BottleTheme.shared.bottleReward)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.backgroundColor = .clear
    }

    @IBAction func sellButtonTapped(_ sender: Any) {
        Coins.shared.addNew(coins: BottleTheme.shared.bottleReward)
        self.dismiss(animated: true)
    }
}
