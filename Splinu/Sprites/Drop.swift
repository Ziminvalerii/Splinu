//
//  Drop.swift
//  PlatinumPlay
//
//  Created by Artemius on 11.05.2022.
//

import SpriteKit

class Drop: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "drop")
        super.init(texture: texture, color: .clear, size: texture.size())
        self.size = CGSize(width: 20, height: 20)
        self.zPosition = 2
        self.name = "drop"
        setPhysicsBody(to: self)
    }

    func setPhysicsBody(to drop: SKNode) {
        drop.physicsBody = .init(rectangleOf: self.size)
        drop.physicsBody?.isDynamic = true
        drop.physicsBody?.allowsRotation = false
        drop.physicsBody?.mass = 0.05
        drop.physicsBody?.contactTestBitMask = BitMaskCategory.bottle
        drop.physicsBody?.categoryBitMask = BitMaskCategory.juice
        drop.physicsBody?.collisionBitMask = BitMaskCategory.none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
