//
//  GardensViewController.swift
//  JuiceFactory
//
//  Created by Artemius on 26.07.2022.
//

import UIKit

class GardensViewController: BaseVC {
    
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var pearButton: UIButton!
    @IBOutlet weak var plumButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtons()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    static let shared = GardensViewController()
    
    
    func setButtons() {
        appleButton.setImage(UIImage(named: "ApplesOpenedButton"), for: .normal)
        let orangesButtonName = GardensData.shared.isOrangesOpened ? "OrangesOpenedButton" : "OrangesClosedButton"
            orangeButton.setImage(UIImage(named: orangesButtonName), for: .normal)
        let pearsButtonName = GardensData.shared.isPearsOpened ? "PearOpenedButton" : "PearClosedButton"
            pearButton.setImage(UIImage(named: pearsButtonName), for: .normal)
        let plumsButtonName = GardensData.shared.isPlumsOpened ? "PlumOpenedButton" : "PlumClosedButton"
            plumButton.setImage(UIImage(named: plumsButtonName), for: .normal)
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func appleGardenTapped(_ sender: Any) {
        let gameVC = storyboard?.instantiateViewController(withIdentifier: "GameVC") as? GameViewController
        gameVC?.modalPresentationStyle = .fullScreen
        gameVC?.currentFruit = "apple"
        present(gameVC!, animated: true, completion: nil)
        
    }
    
    @IBAction func orangesButtonTapped(_ sender: Any) {
        guard GardensData.shared.isOrangesOpened else {
            openPopUp(name: "orange")
            return
        }
        let gameVC = storyboard?.instantiateViewController(withIdentifier: "GameVC") as? GameViewController
        gameVC?.modalPresentationStyle = .fullScreen
        gameVC?.currentFruit = "orange"
        present(gameVC!, animated: true, completion: nil)
    }
    
    @IBAction func pearsButtonTapped(_ sender: Any) {
        guard GardensData.shared.isPearsOpened else {
            openPopUp(name: "pear")
            return
        }
        let gameVC = storyboard?.instantiateViewController(withIdentifier: "GameVC") as? GameViewController
        gameVC?.modalPresentationStyle = .fullScreen
        gameVC?.currentFruit = "pear"
        present(gameVC!, animated: true, completion: nil)
    }
    
    @IBAction func plumsButtonTapped(_ sender: Any) {
        guard GardensData.shared.isPlumsOpened else {
            openPopUp(name: "plum")
            return
        }
        let gameVC = storyboard?.instantiateViewController(withIdentifier: "GameVC") as? GameViewController
        gameVC?.modalPresentationStyle = .fullScreen
        gameVC?.currentFruit = "plum"
        present(gameVC!, animated: true, completion: nil)
    }
    
    func openPopUp(name: String) {
        let gameVC = storyboard?.instantiateViewController(withIdentifier: "BuyGardenVC") as? BuyGardenController
        gameVC?.modalPresentationStyle = .overCurrentContext
        gameVC?.gardenName = name
        present(gameVC!, animated: true, completion: nil)
    }
    
}
