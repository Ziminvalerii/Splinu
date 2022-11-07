//
//  WaterPipe.swift
//  Vertical Fluppy Bird
//
//  Created by Artemius on 13.01.2022.
//

import SpriteKit

class Tree: SKSpriteNode {
    
    var fruitsPerSwipe = 1.0
    var fruitsWithoutWatering = TreeTheme.shared.treeFruitsCount
    
    init(scene: SKScene, fruitName: String) {
        let textureName = "\(TreeTheme.shared.currentTree)\(fruitName)"
        
        let texture = SKTexture(imageNamed: textureName)
        super.init(texture: texture, color: .clear, size: texture.size())
        
        
        switch TreeTheme.shared.treeLevel {
        case 2:
            let width = scene.frame.width / 1.4
            let scale = width / self.size.width
            self.setScale(scale)
        case 3:
            let width = scene.frame.width / 1.4
            let scale = width / self.size.width
            self.setScale(scale)
        default:
            let width = scene.frame.width / 1.3
            let scale = width / self.size.width
            self.setScale(scale)
        }
        
        self.zPosition = 3
        self.name = "tree"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
