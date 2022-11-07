//
//  GameScene.swift
//  PlatinumPlay
//
//  Created by Artemius on 04.05.2022.
//


import SpriteKit
import GameplayKit

class Popup: SKNode {
    let buttonWidth = 80
    let buttonHeight = 32
    
    init(width: CGFloat, position: CGPoint, bottle: Bottle, isTwoBottles: Bool) {
        super.init()
        self.isUserInteractionEnabled = true
        let background = createBackground(position: position, sceneWidth: width)
        let sellButton = createSellButton(position: position)
        let price = createPrice(position: position, bottle: bottle, istTwoBottles: isTwoBottles)
        let bottle = createBottle(position: position, scale: bottle.xScale)
        self.addChild(background)
        self.addChild(sellButton)
        self.addChild(price)
        self.addChild(bottle)
    }
    
    func createBackground(position: CGPoint, sceneWidth: CGFloat) -> SKSpriteNode {
        let texture = Mode.shared.isDarkMode ? SKTexture(imageNamed: "shopBGDark") : SKTexture(imageNamed: "shopBG")
        let popUpBackground = SKSpriteNode(texture: texture)
        popUpBackground.position = position
        popUpBackground.size = CGSize(width: 180, height: 250)
        popUpBackground.zPosition = 20
        return popUpBackground
    }
    
    func createSellButton(position: CGPoint) -> SKSpriteNode {
        let texture = SKTexture(imageNamed: "sellButton")
        let popUpYesButton = SKSpriteNode(texture: texture)
        popUpYesButton.position = CGPoint(x: position.x, y: position.y - 90)
        popUpYesButton.size = CGSize(width: buttonWidth, height: buttonHeight)
        popUpYesButton.zPosition = 21
        popUpYesButton.name = "sellButton"
        return popUpYesButton
    }
    
    func createPrice(position: CGPoint, bottle: Bottle, istTwoBottles: Bool) -> SKLabelNode {
        let cost = istTwoBottles ? bottle.cost * 2 : bottle.cost
        let price = SKLabelNode(text: "\(cost)")
        price.position = CGPoint(x: position.x - 17, y: position.y - 50)
        price.zPosition = 21
        price.name = "price"
        price.fontName = "Arial-Bold"
        price.fontSize = 30
        let coin = createCoin(position: CGPoint(x: price.position.x + 20, y: price.position.y - 2))
        self.addChild(coin)
        return price
    }
    
    func createCoin(position: CGPoint) -> SKSpriteNode {
        let texture = SKTexture(imageNamed: "coin")
        let coin = SKSpriteNode(texture: texture)
        coin.anchorPoint = .zero
        coin.position = position
        coin.size = CGSize(width: 26, height: 26)
        coin.zPosition = 21
        coin.name = "coin"
        return coin
    }
    
    func createBottle(position: CGPoint, scale: CGFloat) -> SKSpriteNode {
        let bottleName = Mode.shared.isDarkMode ? BottleTheme.shared.currentBottle + "Dark" : BottleTheme.shared.currentBottle + "Light"
        let texture = SKTexture(imageNamed: bottleName + "Indicator")
        let bottle = SKSpriteNode(texture: texture)
        bottle.position = CGPoint(x: position.x, y: position.y + 50)
        bottle.setScale(scale)
        bottle.zPosition = 21
        bottle.name = "bottle"
        return bottle
    }
    
    
    var handler: ((Bool) -> (Void))!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let position = touches.first?.location(in: self) else { return }
        if let touchedNode = self.atPoint(position) as? SKSpriteNode {
            if touchedNode.name == "sellButton" {
                handler(true)
            }
        }
    }
}


class GameScene: SKScene {
    
    enum GameState { case prepearing, playing, over, popup, tutorial }
    enum TreeState { case watering, ready, waiting }

    // NODES
    var can: SKSpriteNode!
    var tree: Tree!
    var basket: SKSpriteNode!
    var pipeHand: SKSpriteNode!
   
    let tapToScreenNode = SKLabelNode()
    let toWaterNode = SKLabelNode()
    let toWaterNode1 = SKLabelNode()

    // DELEGATES
    var fruitsUpdateDelegate: FruitsUpdateDelegate?

    // VARIABLES
    var gameState: GameState = .prepearing
    var treeState: TreeState = .ready
    var fruitName: String!
    var fruitsWithoutWatering = 0
    var tapsToWater = WateringCanTheme.shared.tapsToWaterTree
    
    override func didMove(to view: SKView) {
        setupSwipes()
        startGame()
    }
    
    func startGame() {
        treeState = .watering
        setTree()
        setCan()
        setBasket()
        tree.texture = SKTexture(imageNamed: TreeTheme.shared.currentTree)
        toWaterPopUp()
        physicsWorld.contactDelegate = self
    }
    
    func setBasket() {
        let texture = SKTexture(imageNamed: "basket")
        basket = SKSpriteNode(texture: texture)
        let width = 80.0
        let scale = width / basket.size.width
        basket.setScale(scale)
        basket.position = CGPoint(x:  self.frame.maxX - 100, y:  tree.frame.minY)
        basket.zPosition = 10
        self.addChild(basket)
        basket.physicsBody = .init(texture: texture, size: basket.frame.size)
        basket.physicsBody?.isDynamic = false
        basket.physicsBody?.allowsRotation = false
        
        basket.physicsBody?.contactTestBitMask = BitMaskCategory.fruit
        basket.physicsBody?.categoryBitMask = BitMaskCategory.basket
        basket.physicsBody?.collisionBitMask = BitMaskCategory.none
    }
    
    
    func setCan() {
        let texture = SKTexture(imageNamed: WateringCanTheme.shared.currentCan)
        can = SKSpriteNode(texture: texture)
        let width = 70.0
        let scale = width / can.size.width
        can.setScale(scale)
        can.position = CGPoint(x:  self.frame.minX + 64, y:  tree.frame.minY)
        can.zPosition = 10
        self.addChild(can)
    }


    func setTree() {
        tree = Tree(scene: self, fruitName: fruitName)
        tree.position = .init(x: self.frame.midX, y: self.frame.minY + tree.frame.height / 2 + 80)
        fruitsWithoutWatering = tree.fruitsWithoutWatering
        self.addChild(tree)
    }
    
    
    
    
    func getFruit() {
        guard treeState == .ready else { return }
        let fruitFallsAction = SKAction.run {
            let texture = SKTexture(imageNamed: self.fruitName)
            let fruit = SKSpriteNode(texture: texture)
            fruit.position.x = self.basket.position.x
            fruit.position.y = self.tree.frame.maxY - 90
            fruit.size = .init(width: 24, height: 24)
            fruit.zPosition = 2
            self.addChild(fruit)
            fruit.physicsBody = .init(texture: texture, size: fruit.frame.size)
            fruit.physicsBody?.allowsRotation = false
            
            fruit.physicsBody?.contactTestBitMask = BitMaskCategory.basket
            fruit.physicsBody?.categoryBitMask = BitMaskCategory.fruit
            fruit.physicsBody?.collisionBitMask = BitMaskCategory.none
            fruit.physicsBody?.affectedByGravity = true
        }
        self.run(fruitFallsAction)

//        treeState = .waiting
    }
    
    func setupSwipes() {
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(sender:)))
        rightSwipe.direction = .right
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(sender:)))
        upSwipe.direction = .up
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(sender:)))
        leftSwipe.direction = .down
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(sender:)))
        downSwipe.direction = .left
        
        [rightSwipe, upSwipe, leftSwipe, downSwipe].forEach { view?.addGestureRecognizer($0) }
        
        view?.addGestureRecognizer(rightSwipe)
    }
    
    @objc func didSwipe(sender: UISwipeGestureRecognizer) {
        if sender.direction == .down {
            if gameState == .popup {
                tapToScreenNode.removeFromParent()
                gameState = .playing
            }
            getFruit()
        }
    }
    
    func prepareForGame() {
        gameState = .popup
        tapToScreenNode.text = "Swipe to start"
        tapToScreenNode.name = "tapToScreenNode"
        tapToScreenNode.zPosition = 10
        tapToScreenNode.fontSize = 48
        tapToScreenNode.fontColor = .white
        tapToScreenNode.fontName = "Baskerville-Bold"
        tapToScreenNode.position = CGPoint(x: frame.midX, y: frame.midY + 200)
        self.addChild(tapToScreenNode)
    }
    
    func toWaterPopUp() {
        toWaterNode.text = "Please, water the tree"
        toWaterNode.name = "toWaterNode"
        toWaterNode.zPosition = 10
        toWaterNode.fontSize = 32
        toWaterNode.fontColor = .white
        toWaterNode.fontName = "Baskerville-Bold"
        toWaterNode.position = CGPoint(x: frame.midX, y: frame.maxY - 200)
        self.addChild(toWaterNode)
      

        toWaterNode1.text = "by tapping the sprinkler"
        toWaterNode1.name = "toWaterNode1"
        toWaterNode1.zPosition = 10
        toWaterNode1.fontSize = 32
        toWaterNode1.fontColor = .white
        toWaterNode1.fontName = "Baskerville-Bold"
        toWaterNode1.position = CGPoint(x: frame.midX, y: frame.maxY - 250)
        self.addChild(toWaterNode1)
    }
    

    
    private func gameSettings() {
        gameState = .playing
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch gameState {
        case .prepearing:
            gameSettings()
        case .playing:
            guard treeState == .watering else {return}
            if let particles = SKEmitterNode(fileNamed: "WateringEffect.sks") {
                particles.zPosition = 4
                particles.position = .init(x: self.can.frame.midX, y: self.can.frame.maxY)
                self.addChild(particles)
            }
            tapsToWater -= 1
            guard tapsToWater == 0 else {return}
            tree.texture = SKTexture(imageNamed: String(TreeTheme.shared.currentTree+fruitName))
            toWaterNode.removeFromParent()
            toWaterNode1.removeFromParent()
            tapsToWater = WateringCanTheme.shared.tapsToWaterTree
            treeState = .ready
            fruitsWithoutWatering = tree.fruitsWithoutWatering
            prepareForGame()
        case .over:
            return
        case .popup:
            return
        case .tutorial:
            return
        }
    }
    
//    func changeProgressBarScale() {
//        bottle.progress?.scaleBarTo(scale: progressBarScale)
//        guard WaterPipeTheme.shared.currentPipe != "pipe1" else { return }
//        bottle2.progress?.scaleBarTo(scale: progressBarScale)
//    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA.categoryBitMask
        let bodyB = contact.bodyB.categoryBitMask

        if bodyA == BitMaskCategory.basket || bodyB == BitMaskCategory.basket {
            if bodyA == BitMaskCategory.basket {
                guard let fruit = contact.bodyB.node else {
                    return
                }
                catchFruit(fruit: fruit)
            } else if bodyB == BitMaskCategory.basket {
                guard let fruit = contact.bodyA.node else {
                    return
                }
                catchFruit(fruit: fruit)
            }
        } else {
            print("ooops... idk who is who +")

        }
    }
    
    func catchFruit(fruit: SKNode) {
        fruit.physicsBody = nil
        fruit.removeFromParent()
        FruitsData.shared.addNew(count: 1, fruitName: fruitName)
        fruitsUpdateDelegate?.updateFruitsIndicator(count: FruitsData.shared.getCount(fruitName: fruitName))
        fruitsWithoutWatering -= 1
        guard fruitsWithoutWatering == 0 else {return}
        tree.shake()
        treeState = .watering
        tree.texture = SKTexture(imageNamed: TreeTheme.shared.currentTree)
        toWaterPopUp()
    }
}

extension SKAction {
    class func shake(initialX: CGFloat, duration: Float, amplitudeX: Int = 4, amplitudeY: Int = 4) -> SKAction {
        let numberOfShakes = duration / 0.05
        var actionsArray: [SKAction] = []
        for _ in 1...Int(numberOfShakes) {
            let newXPos = initialX + CGFloat(arc4random_uniform(UInt32(amplitudeX))) - CGFloat(amplitudeX / 2)
            actionsArray.append(SKAction.moveTo(x: newXPos, duration: 0.015))
        }
        actionsArray.append(SKAction.moveTo(x: initialX, duration: 0.015))
        return SKAction.sequence(actionsArray)
    }
}

extension SKNode {
    func shake() {
        self.run(.shake(initialX: self.position.x, duration: 0.2, amplitudeX: 12, amplitudeY: 0))
    }
    
    func setScale(toWidth width: CGFloat) {
        let frame = self.calculateAccumulatedFrame()
        let ration = width / frame.width
        self.setScale(ration)
    }
}
