//
//  ShopViewController.swift
//  Vertical Fluppy Bird
//
//  Created by Artemius on 19.01.2022.
//

import UIKit

class ShopViewController: BaseVC {
    
    @IBOutlet weak var coinsCountLabel: UILabel!
    @IBOutlet weak var currentBottle: UIImageView!
    @IBOutlet weak var bottleToBuy: UIImageView!
    @IBOutlet weak var bottlePrice: UILabel!
    @IBOutlet weak var currentWateringCan: UIImageView!
    @IBOutlet weak var wateringCanToBuy: UIImageView!
    @IBOutlet weak var wateringCanPrice: UILabel!
    @IBOutlet weak var currentTree: UIImageView!
    @IBOutlet weak var treeToBuy: UIImageView!
    @IBOutlet weak var treePrice: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setImagesAndPrices()
        coinsCountLabel.text = String(Coins.shared.coins)
    }
    
    func setImagesAndPrices() {
        currentBottle.image = .init(named: BottleTheme.shared.currentBottle)
        bottleToBuy.image = .init(named: BottleTheme.shared.bottleToBuy)
        bottlePrice.text = String(BottleTheme.shared.bottlePrice)
        
        currentWateringCan.image = .init(named: WateringCanTheme.shared.currentCan)
        wateringCanToBuy.image = .init(named: WateringCanTheme.shared.canToBuy)
        wateringCanPrice.text = String(WateringCanTheme.shared.canPrice)
        
        currentTree.image = .init(named: TreeTheme.shared.currentTree)
        treeToBuy.image = .init(named: TreeTheme.shared.treeToBuy)
        treePrice.text = String(TreeTheme.shared.treePrice)
        
    }

    @IBAction func bottleUpgradeButtonTapped(_ sender: Any) {
        guard Coins.shared.coins >= BottleTheme.shared.bottlePrice else {
            noCoinsAlert()
            return
        }
        guard BottleTheme.shared.bottleLevel < 3 else {
            alreadyBoughtAlert()
            return
        }
        Coins.shared.decrease(coins: BottleTheme.shared.bottlePrice)
        BottleTheme.shared.increaseBottleLevel()
        coinsCountLabel.text = String(Coins.shared.coins)
        setImagesAndPrices()
    }
    
    @IBAction func wateringCanUpgradeButtonTapped(_ sender: Any) {
        guard Coins.shared.coins >= WateringCanTheme.shared.canPrice else {
            noCoinsAlert()
            return
        }
        guard WateringCanTheme.shared.canLevel < 4 else {
            alreadyBoughtAlert()
            return
        }
        Coins.shared.decrease(coins: WateringCanTheme.shared.canPrice)
        WateringCanTheme.shared.increaseCanLevel()
        coinsCountLabel.text = String(Coins.shared.coins)
        setImagesAndPrices()
    }
    
    @IBAction func treeUpgradeButtonTapped(_ sender: Any) {
        guard Coins.shared.coins >= TreeTheme.shared.treePrice else {
            noCoinsAlert()
            return
        }
        guard TreeTheme.shared.treeLevel < 3 else {
            alreadyBoughtAlert()
            return
        }
        Coins.shared.decrease(coins: TreeTheme.shared.treePrice)
        TreeTheme.shared.increaseTreeLevel()
        coinsCountLabel.text = String(Coins.shared.coins)
        setImagesAndPrices()
    }
    
    func noCoinsAlert() {
        let alert = UIAlertController(title: "Ooops!", message: "You don`t have enough coins", preferredStyle: .alert)
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 0.6549, green: 0.5373, blue: 0.749, alpha: 1.0)
        
        let firstAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
 
        alert.setTitlet(font: .init(name: "MarkerFelt-Wide", size: 20), color: .white)
        alert.setMessage(font: .init(name: "MarkerFelt-Wide", size: 18), color: .white)
        alert.view.tintColor = .white
        alert.addAction(firstAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func alreadyBoughtAlert() {
        let alert = UIAlertController(title: "Ooops!", message: "You have already bought max one", preferredStyle: .alert)
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 0.6549, green: 0.5373, blue: 0.749, alpha: 1.0)
        
        let firstAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
 
        alert.setTitlet(font: .init(name: "MarkerFelt-Wide", size: 20), color: .white)
        alert.setMessage(font: .init(name: "MarkerFelt-Wide", size: 18), color: .white)
        alert.view.tintColor = .white
        alert.addAction(firstAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}


extension UIAlertController {
    
    //Set background color of UIAlertController
    func setBackgroundColor(color: UIColor) {
        if let bgView = self.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
        }
    }
    
    //Set title font and title color
    func setTitlet(font: UIFont?, color: UIColor?) {
        guard let title = self.title else { return }
        let attributeString = NSMutableAttributedString(string: title)//1
        if let titleFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : titleFont],//2
                                          range: NSMakeRange(0, title.utf8.count))
        }
        
        if let titleColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],//3
                                          range: NSMakeRange(0, title.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedTitle")//4
    }
    
    //Set message font and message color
    func setMessage(font: UIFont?, color: UIColor?) {
        guard let message = self.message else { return }
        let attributeString = NSMutableAttributedString(string: message)
        if let messageFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : messageFont],
                                          range: NSMakeRange(0, message.utf8.count))
        }
        
        if let messageColorColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : messageColorColor],
                                          range: NSMakeRange(0, message.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedMessage")
    }
    
    //Set tint color of UIAlertController
    func setTint(color: UIColor) {
        self.view.tintColor = color
    }
}
