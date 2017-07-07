//
//  GameScene.swift
//  Tennis Travel
//
//  Created by David Kirson on 6/29/17.
//  Copyright © 2017 David Kirson. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate
 {
//    override init(size: CGSize)
//    {
//        super.init(size: SKView.bounds.size)
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    var tennisBall = SKShapeNode()
    var tennisRacket1 = SKSpriteNode()
    var tennisRacket2 = SKSpriteNode()
    var loseZone = SKSpriteNode()
    var loseZone2 = SKSpriteNode()
    var score: Int = 0
    var numberOfLives: Int = 0
    var scoreBoard: SKLabelNode!
    var scoreBoard2: SKLabelNode!
    
         override func didMove(to view: SKView)
         {
            physicsWorld.contactDelegate = self
        
            self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
            
            createBackground()
            makeTennisBall()
            makeRacket1()
            makeRacket2()
            makeLoseZone()
            makeLoseZone2()
            makeScoreBoard()
            makeScoreBoard2()
    
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        tennisBall.physicsBody?.applyImpulse(CGVector(dx: 5, dy: 5))
        tennisBall.physicsBody?.isDynamic = true
        
        for touch in touches
        {
            let location = touch.location(in: self)
            
            if loseZone2.contains(location)
            {
                tennisRacket1.position.x = location.x
            }
            
            if loseZone.contains(location)
            {
                tennisRacket2.position.x = location.x
            }
        }
    }

    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
    
        for touch in touches
        {
            let location = touch.location(in: self)
            
            if loseZone2.contains(location)
            {
                tennisRacket1.position.x = location.x
                
            }
            
            if loseZone.contains(location)
            {
                tennisRacket2.position.x = location.x
            }

        }
    }
    
    
    
            
    
        
        func didBegin(_ contact: SKPhysicsContact) {
            
            let bodyAName = contact.bodyA.node?.name
            let bodyBName = contact.bodyB.node?.name
            
            if (bodyAName == "tennisBall" && bodyBName == "greenRight1" || bodyAName == "greenLeft1" && bodyBName == "tennisBall"){
                 if (bodyAName == "greenRight2" && bodyBName == "tennisBall" || bodyAName == "tennisBall" && bodyBName == "greenLeft2") {
                    contact.bodyA.node?.removeFromParent()
                     score += 1
                }
                 else if bodyBName == "loseZone" {
                    contact.bodyB.node?.removeFromParent()
                    score -= 1
                }
                
            }
            

            if (contact.bodyA.node?.name == "loseZone" ||
                    contact.bodyB.node?.name == "loseZone") {
                    numberOfLives += 1
                    if numberOfLives < 3 {
                        print("You are on life", numberOfLives - 1)
                    }
                    if numberOfLives == 3 {
                        print("You made", score, "Serves!!\nBut You Still Lost!!")
                    }
                }
            }

            func update(currentTime: TimeInterval)
            {
                if (score == 60)
                {
                    print( "You totally won, dude!!!!\nYou Totally scored all", score,  "Points!!!!!!!")
                    self.view?.isPaused = true
                }
            }
    
            func createBackground()
            {
                let tennisCourt = SKTexture(imageNamed: "court")
      
                    let tennisCourtBackground = SKSpriteNode(texture: tennisCourt)
                    tennisCourtBackground.zPosition = -1
                    tennisCourtBackground.position = CGPoint(x: 0, y: 0)
                    tennisCourtBackground.setScale(1.45)
                    addChild(tennisCourtBackground)
                
            }

                func makeTennisBall()
                {
                tennisBall = SKShapeNode(circleOfRadius: 10)
                tennisBall.position = CGPoint(x: frame.midX, y: frame.midY)
                tennisBall.strokeColor = UIColor.white
                tennisBall.fillColor = UIColor.green
                tennisBall.name = "tennisBall"
                tennisBall.physicsBody = SKPhysicsBody(circleOfRadius: 10)
                tennisBall.physicsBody?.isDynamic = false//ignores all forces and impulses
                tennisBall.physicsBody?.usesPreciseCollisionDetection = true
                tennisBall.physicsBody?.friction = 0
                tennisBall.physicsBody?.affectedByGravity = false
                tennisBall.physicsBody?.restitution = 1
                 tennisBall.physicsBody?.angularDamping = 0
                tennisBall.physicsBody?.linearDamping = 0
                tennisBall.physicsBody?.contactTestBitMask = (tennisBall.physicsBody?.collisionBitMask)!
                tennisBall.physicsBody?.velocity = CGVector(dx: 30, dy: 30)
                addChild(tennisBall)
                }
    
                func makeRacket1()
                {
                tennisRacket1 = SKSpriteNode(color: UIColor.green, size: CGSize(width: frame.width/4, height: 20))
                tennisRacket1.position = CGPoint(x: frame.maxX, y: frame.minY + 125)
                tennisRacket1.name = "tennisRacket1"
                tennisRacket1.physicsBody = SKPhysicsBody(rectangleOf: tennisRacket1.size)
                tennisRacket1.physicsBody?.isDynamic = false
                addChild(tennisRacket1)
                }
    
                func makeRacket2()
                {
                tennisRacket2 = SKSpriteNode(color: UIColor.blue, size: CGSize(width: frame.width/4, height: 20))
                tennisRacket2.position = CGPoint(x: frame.minX, y: frame.maxY - 125)
                tennisRacket2.name = "tennisRacket2"
                tennisRacket2.physicsBody = SKPhysicsBody(rectangleOf: tennisRacket2.size)
                tennisRacket2.physicsBody?.isDynamic = false
                addChild(tennisRacket2)
                }
    
                func makeLoseZone()
                {
                    loseZone = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 840, height: 140))
                    loseZone.position = CGPoint(x: frame.minX, y: frame.maxY)
                    loseZone.name = "loseZone"
                    loseZone.physicsBody = SKPhysicsBody(rectangleOf: loseZone.size)
                    loseZone.physicsBody?.isDynamic = false
                    addChild(loseZone)
                }
    
                func makeLoseZone2()
                {
                    loseZone2 = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 840, height: 140))
                    loseZone2.position = CGPoint(x: frame.maxX, y: frame.minY)
                    loseZone2.name = "loseZone2"
                    loseZone2.physicsBody = SKPhysicsBody(rectangleOf: loseZone2.size)
                    loseZone2.physicsBody?.isDynamic = false
                    addChild(loseZone2)
                }
    
    func makeScoreBoard()
    {
        scoreBoard = SKLabelNode(fontNamed: "Arial")
        scoreBoard.fontSize = 20
        scoreBoard.fontColor = SKColor.red
        scoreBoard.position = CGPoint(x: frame.midX, y: frame.maxY - 50)
        scoreBoard.text = "Score: " + String(score)
        addChild(scoreBoard)

    }
    
    func makeScoreBoard2()
    {
        scoreBoard2 = SKLabelNode(fontNamed: "Arial")
        scoreBoard2.fontSize = 20
        scoreBoard2.fontColor = SKColor.blue
        scoreBoard2.position = CGPoint(x: frame.midX, y: frame.minY + 50)
        scoreBoard2.text = "Score: " + String(score)
        addChild(scoreBoard2)
    }
}
    
    
    
    

    
    
    
    
    //                func makeGreenRight() {
//                    let greenRight = SKSpriteNode(color: UIColor.green, size: CGSize(width: frame.width, height: 50))
//                    greenRight.position = CGPoint(x: frame.maxX, y: frame.minY)
//                    greenRight.name = "greenRight"
//                    greenRight.physicsBody = SKPhysicsBody(rectangleOf: greenRight.size)
//                    greenRight.physicsBody?.isDynamic = false
//                    addChild(greenRight)
                
    
//                func makeGreenRight2() {
//                    let greenRight2 = SKSpriteNode(color: UIColor.green, size: CGSize(width: frame.width, height: 50))
//                    greenRight2.position = CGPoint(x: frame.minX - 70, y: frame.maxY)
//                    greenRight2.name = "greenRight2"
//                    greenRight2.physicsBody = SKPhysicsBody(rectangleOf: greenRight2.size)
//                    greenRight2.physicsBody?.isDynamic = false
//                    addChild(greenRight2)

                
//                func makeGreenLeft() {
//                    let greenLeft = SKSpriteNode(color: UIColor.green, size: CGSize(width: frame.width, height: 50))
//                    greenLeft.position = CGPoint(x: frame.maxX, y: frame.minY)
//                    greenLeft.name = "greenLeft"
//                    greenLeft.physicsBody = SKPhysicsBody(rectangleOf: greenLeft.size)
//                    greenLeft.physicsBody?.isDynamic = false
//                    addChild(greenLeft)

    
//                func makeGreenLeft2() {
//                    let greenLeft2 = SKSpriteNode(color: UIColor.green, size: CGSize(width: frame.width, height: 50))
//                    greenLeft2.position = CGPoint(x: frame.minX, y: frame.minY)
//                    greenLeft2.name = "greenLeft2"
//                    greenLeft2.physicsBody = SKPhysicsBody(rectangleOf: greenLeft2.size)
//                    greenLeft2.physicsBody?.isDynamic = false
//                    addChild(greenLeft2)

    
//                func makeNet() {
//                    let net = SKSpriteNode(color: UIColor.brown, size: CGSize(width: frame.width, height: 25))
//                    net.position = CGPoint(x: frame.midX, y: frame.midY + 25)
//                    net.name = "net"
//                    net.physicsBody = SKPhysicsBody(rectangleOf: net.size )
//                    net.physicsBody?.isDynamic = false
//                    addChild(net)

        



