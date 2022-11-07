//
//  Textures.swift
//  Vertical Fluppy Bird
//
//  Created by Artemius on 28.12.2021.
//

import Foundation
import SpriteKit

struct BitMaskCategory {
    static let bottle : UInt32 = 0x1 << 0
    static let juice : UInt32 = 0x1 << 1
    static let fruit : UInt32 = 0x1 << 2
    static let basket : UInt32 = 0x1 << 3
    static let none : UInt32 = 0x0
}

extension SKAction {
    static func oscillation(amplitude a: CGFloat, timePeriod t: CGFloat, midPoint: CGPoint) -> SKAction {
        let action = SKAction.customAction(withDuration: Double(t)) { node, currentTime in
            let displacement = a * sin(2 * CGFloat.pi * currentTime / t)
            node.position.x = midPoint.x + displacement
        }

        return action
    }
}
