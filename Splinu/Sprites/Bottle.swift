//
//  Ball.swift
//  Vertical Fluppy Bird
//
//  Created by Dr.Drexa on 23.12.2021.
//

import SpriteKit

class Bottle: SKSpriteNode {
    
    var cost = BottleTheme.shared.bottleReward
    var progress: ProgressBar!

    init(sceneWidth: CGFloat) {
        
        let bottle = BottleTheme.shared
        
        let texture = SKTexture(imageNamed: bottle.currentBottle)
        super.init(texture: texture, color: .clear, size: texture.size())
        
        let indicatorName = bottle.currentBottle + "Indicator"
        progress = ProgressBar(size: self.size, indicatorName: indicatorName)
        self.addChild(progress)
        
        let width = sceneWidth / 5
        let scale = width / self.size.height
        self.setScale(scale)
    
        
        self.zPosition = 3
        self.name = "bottle"
        setPhysicsBody(to: self, texture: texture)
    }
    
    func setPhysicsBody(to player: SKNode, texture: SKTexture) {
        player.physicsBody = .init(texture: texture, size: player.frame.size)
        player.physicsBody?.isDynamic = false
        player.physicsBody?.allowsRotation = false
        
        player.physicsBody?.contactTestBitMask = BitMaskCategory.juice
        player.physicsBody?.categoryBitMask = BitMaskCategory.bottle
        player.physicsBody?.collisionBitMask = BitMaskCategory.none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
