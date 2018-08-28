//
//  MovementComponent.swift
//  Flappy Bird
//
//  Created by iOS Development on 8/27/18.
//  Copyright © 2018 Smartivity Labs. All rights reserved.
//

import SpriteKit
import GameplayKit


class MovementComponent : GKComponent {
    
    let spriteComponent : SpriteComponent
    
    let flapAction = SKAction.playSoundFileNamed("flapping.wav", waitForCompletion: false)
    
    let impulse:CGFloat = 400
    var velocity = CGPoint.zero
    let gravity:CGFloat = -1500
    
    var velocityModifier:CGFloat = 1000.0
    var angularVelocity:CGFloat = 0.0
    let minDegree:CGFloat = -90
    let maxDegree:CGFloat = 25
    
    var lastTouchTime: TimeInterval = 0
    var lastTouchY: CGFloat = 0.0
    
    var playableStart:CGFloat = 0
    
    
    init(entity:GKEntity) {
        self.spriteComponent = entity.component(ofType: SpriteComponent.self)!
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyInitialImpulse(){
        velocity = CGPoint(x: 0, y: impulse * 2)
    }
    
    
    func moveSombrero(){
       if let player = entity as? PlayerEntity {
            let moveUp = SKAction.moveBy(x: 0, y: 12, duration: 0.15)
            moveUp.timingMode = .easeInEaseOut
            let moveDn = moveUp.reversed()
            player.sombrero.run(SKAction.sequence([moveUp,moveDn]))
        }
    }
    
    func applyImpulse(_ lastupdateTime:TimeInterval){
        
        spriteComponent.node.run(flapAction)
        moveSombrero()
        velocity = CGPoint(x: 0, y: impulse)
        
        angularVelocity = velocityModifier.degreesToRadians()
        lastTouchTime = lastupdateTime
        lastTouchY = spriteComponent.node.position.y
    }
    
    func applyMovement(_ seconds:TimeInterval) {
        let spriteNode = spriteComponent.node
        
        //Apply Gravity
        let gravityStep = CGPoint(x: 0, y: gravity) * CGFloat(seconds)
        velocity += gravityStep
        
        //Apply Velocity
        let velocityStep = velocity * CGFloat(seconds)
        spriteNode.position += velocityStep
        
        if spriteNode.position.y < lastTouchY {
            angularVelocity = -velocityModifier.degreesToRadians()
        }
        
        //Rotation
        
        let angularStep = angularVelocity * CGFloat(seconds)
        spriteNode.zRotation += angularStep
        spriteNode.zRotation = min(max(spriteNode.zRotation,minDegree.degreesToRadians()),maxDegree.degreesToRadians())
                                       
                                       
        
        
        //Temporary Ground Hit
        if spriteNode.position.y - spriteNode.size.height / 2 < playableStart {
            spriteNode.position = CGPoint(x: spriteNode.position.x, y: playableStart + spriteNode.size.height / 2)
        }
    }
    
    
    
    override func update(deltaTime seconds: TimeInterval) {
        if let player = entity as? PlayerEntity {
            if player.movementAllowed {
                applyMovement(seconds)
            }
        }
    }
}


































































