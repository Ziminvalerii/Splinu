//
//  ProgressBar.swift
//  StarCasino
//
//  Created by Artemius on 05.04.2022.
//

import SpriteKit

class ProgressBar : SKNode {
    
    var progressBar : SKCropNode
    
    init(size: CGSize, indicatorName: String) {
        let coverImage = indicatorName
        progressBar = SKCropNode()
        super.init()
    
        let filledImage  = SKSpriteNode(imageNamed: coverImage)
        
        filledImage.size = size
        progressBar.addChild(filledImage)
        progressBar.maskNode = SKSpriteNode(
            color: .white,
            size: CGSize(width: filledImage.size.width * 2, height: filledImage.size.height * 2))
        progressBar.maskNode?.position = CGPoint(x: -filledImage.size.width / 2, y: -filledImage.size.height / 2)
        progressBar.zPosition = 0.1
        
        self.addChild(progressBar)
        
     
        self.setYProgress(yProgress: 0)
        self.zPosition = 2
        self.name = "progress"
    }
    
    func scaleBarTo(scale: Double) {
        let action = SKAction.scaleY(to: scale, duration: 0.3);
        progressBar.maskNode?.run(action)
    }
    
    func setXProgress(xProgress : CGFloat){
        var value = xProgress
        if xProgress < 0{
            value = 0
        }
        if xProgress > 1 {
            value = 1
        }
        progressBar.maskNode?.xScale = value
    }
    
    func setYProgress(yProgress : CGFloat){
        var value = yProgress
        if yProgress < 0{
            value = 0
        }
        if yProgress > 1 {
            value = 1
        }
        progressBar.maskNode?.yScale = value
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
