//
//  BuyGardenController.swift
//  JuiceFactory
//
//  Created by Artemius on 09.08.2022.
//

import UIKit

class BuyGardenController: UIViewController {


    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var cost: UILabel!
    var gardenName = ""
    var currentCost = 0
    var orangeGardenPrice = 3000
    var pearGardenPrice = 5000
    var plumGardenPrice = 7000
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.layer.cornerRadius = 25
        background.layer.cornerRadius = 25
        switch gardenName {
        case "orange":
            cost.text = String(orangeGardenPrice)
            currentCost = orangeGardenPrice
        case "pear":
            cost.text = String(pearGardenPrice)
            currentCost = pearGardenPrice
        case "plum":
            cost.text = String(plumGardenPrice)
            currentCost = plumGardenPrice
        default:
            return
        }
    }
    
    @IBAction func openButtonTapped(_ sender: Any) {
        guard Coins.shared.coins >= currentCost else {
            noCoinsAlert()
            return
            
        }
        Coins.shared.decrease(coins: currentCost)

        switch gardenName {
        case "orange":
            GardensData.shared.isOrangesOpened = true
        case "pear":
            GardensData.shared.isPearsOpened = true
        case "plum":
            GardensData.shared.isPlumsOpened = true
        default:
            return
        }
        self.presentingViewController?.presentingViewController?.dismiss(animated: false)

    }
    
    func noCoinsAlert() {
        let alert = UIAlertController(title: "Ooops!", message: "You don`t have enough coins", preferredStyle: .alert)
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 0.6549, green: 0.5373, blue: 0.749, alpha: 1.0)
        
        let firstAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { _ in
            self.dismiss(animated: true)
        }
 
        alert.setTitlet(font: .init(name: "MarkerFelt-Wide", size: 20), color: .white)
        alert.setMessage(font: .init(name: "MarkerFelt-Wide", size: 18), color: .white)
        alert.view.tintColor = .white
        alert.addAction(firstAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
