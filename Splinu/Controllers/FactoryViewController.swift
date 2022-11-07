//
//  FactoryViewController.swift
//  JuiceFactory
//
//  Created by Artemius on 26.07.2022.
//


import UIKit
import AudioToolbox

class FactoryViewController: BaseVC {
    
    @IBOutlet weak var fruitsCount: UILabel!
    @IBOutlet weak var fruitImage: UIImageView!
    @IBOutlet weak var blender: UIButton!
    @IBOutlet weak var fruitsForJuice: UILabel!
    @IBOutlet weak var textForNeed: UILabel!
    
    var currentStep = 0
    var timerSec = 15
    var currentFruit = "apple"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blender.setImage(transformSteps[1], for: .normal)
        blender.isEnabled = false
        hideDetails()
    }
    
    func hideDetails() {
        textForNeed.isHidden = true
        fruitsForJuice.isHidden = true
        fruitImage.isHidden = true
        fruitsCount.isHidden = true
    }
    
    func showDetails() {
        textForNeed.isHidden = false
        fruitsForJuice.isHidden = false
        fruitImage.isHidden = false
        fruitsCount.isHidden = false
    }
     
    func enableBlender(count: Int) {
        if count >= 10 {
            blender.isEnabled = true
        } else {
            blender.isEnabled = false
        }
    }
    
    @IBAction func appleTapped(_ sender: Any) {
        fruitsForJuice.text = "10 apples"
        fruitImage.image = UIImage(named: "apple")
        fruitsCount.text = String(FruitsData.shared.apples)
        showDetails()
        currentFruit = "apple"
        enableBlender(count: FruitsData.shared.apples)
        
    }
    
    @IBAction func pearTapped(_ sender: Any) {
        fruitsForJuice.text = "10 pears"
        fruitImage.image = UIImage(named: "pear")
        fruitsCount.text = String(FruitsData.shared.pears)
        showDetails()
        currentFruit = "pear"
        enableBlender(count: FruitsData.shared.pears)

    }
    
    @IBAction func plumTapped(_ sender: Any) {
        fruitsForJuice.text = "10 plums"
        fruitImage.image = UIImage(named: "plum")
        fruitsCount.text = String(FruitsData.shared.plums)
        showDetails()
        currentFruit = "plum"
        enableBlender(count: FruitsData.shared.plums)
    }
    
    @IBAction func orangeTapped(_ sender: Any) {
        fruitsForJuice.text = "10 oranges"
        fruitImage.image = UIImage(named: "orange")
        fruitsCount.text = String(FruitsData.shared.oranges)
        showDetails()
        currentFruit = "orange"
        enableBlender(count: FruitsData.shared.oranges)
    }
    
    @IBAction func blenderTapped(_ sender: Any) {
        FruitsData.shared.decrease(count: 10, fruitName: currentFruit)
        fruitsCount.text = String(FruitsData.shared.getCount(fruitName: currentFruit))
        transform()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    var transformSteps: [UIImage] = [
        .init(named: "blender1")!,
        .init(named: "blender2")!,
        .init(named: "blender3")!,
    ]
    
    func nextStep(timer: Timer) {
        currentStep += 1
        if currentStep >= transformSteps.count {
            currentStep = 0
            timerSec -= 1
        }
        blender.setImage(transformSteps[currentStep], for: .normal)
        guard timerSec <= 0 else { return }
        timer.invalidate()
        timerSec = 15
        blender.setImage(transformSteps[1], for: .normal)
        enableBlender(count: FruitsData.shared.getCount(fruitName: currentFruit))
        openPopUp()
    }
    
    func openPopUp() {
        let gameVC = storyboard?.instantiateViewController(withIdentifier: "SellVC") as? SellBottleController
        gameVC?.modalPresentationStyle = .overCurrentContext
        present(gameVC!, animated: true, completion: nil)
        
    }
    func transform() {
        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID (kSystemSoundID_Vibrate)) {}
        Timer.scheduledTimer(withTimeInterval: 0.0225, repeats: true) { timer in
            self.nextStep(timer: timer)
        }
    }


}
