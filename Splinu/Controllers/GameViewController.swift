//
//  GameViewController.swift
//  Vertical Fluppy Bird
//
//  Created by Dr.Drexa on 23.12.2021.
//

import SpriteKit

protocol FruitsUpdateDelegate {
    func updateFruitsIndicator(count: Int)
}

//protocol TutorialDelegate {
//    func show(sceneWidth: CGFloat)
//    func hide()
//}

class GameViewController: BaseVC {
    
    @IBOutlet weak var skView: SKView!
    @IBOutlet weak var fruitsCountLabel: UILabel!
    @IBOutlet weak var fruitImage: UIImageView!
    var currentFruit: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openGame()
    }
    
    func setData() {
        fruitImage.image = .init(named: currentFruit)
        fruitsCountLabel.text = String(FruitsData.shared.getCount(fruitName: currentFruit))
    }
    
    func openGame() {
        setData()
        let sceneNode = GameScene(size: view.frame.size)
        sceneNode.backgroundColor = .clear
        sceneNode.fruitsUpdateDelegate = self
        sceneNode.fruitName = currentFruit
        skView.presentScene(sceneNode)
        skView.ignoresSiblingOrder = true
        skView.backgroundColor = .clear
        //skView.showsPhysics = true
        //skView.showsNodeCount = true
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension GameViewController: FruitsUpdateDelegate {
    func updateFruitsIndicator(count: Int) {
        fruitsCountLabel.text = String(count)
    }
}


