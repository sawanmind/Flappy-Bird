//
//  PlayerEntity.swift
//  Flappy Bird
//
//  Created by iOS Development on 8/27/18.
//  Copyright © 2018 Smartivity Labs. All rights reserved.
//

import GameplayKit
import SpriteKit

class PlayerEntity: GKEntity {
    var spriteComponent: SpriteComponent!
    var movementComponent: MovementComponent!
    var animationComponent : AnimationComponent!
    
    var movementAllowed = false
    var numberOfFrames = 3
    
    let sombrero = SKSpriteNode(imageNamed: "Sombrero")
    
    
    init(imageName:String) {
        super.init()
        
        let texture = SKTexture(imageNamed: imageName)
        spriteComponent = SpriteComponent(entity: self, texture: texture, size: texture.size())
        addComponent(spriteComponent)
        
        sombrero.position = CGPoint(x: 31 - sombrero.size.width / 2, y: 29 - sombrero.size.height / 2)
        sombrero.zPosition = 1
        spriteComponent.node.addChild(sombrero)
        
        
        movementComponent = MovementComponent(entity: self)
        addComponent(movementComponent)
        
        var textures:Array<SKTexture> = []
        for i in 0..<numberOfFrames {
            textures.append(SKTexture(imageNamed: "Bird\(i)"))
        }
        
        for i in stride(from: numberOfFrames, through: 0, by: -1){
            textures.append(SKTexture(imageNamed: "Bird\(i)"))
        }
 
        animationComponent = AnimationComponent(entity: self, textures: textures)
        addComponent(animationComponent)
        
        movementComponent.applyInitialImpulse()
        
        // Add Physics
        let spriteNode = spriteComponent.node
        spriteNode.physicsBody = SKPhysicsBody(texture: spriteNode.texture!, size: spriteNode.size)
        spriteNode.physicsBody?.categoryBitMask = PhysicsCategory.Player
        spriteNode.physicsBody?.collisionBitMask = 0
        spriteNode.physicsBody?.contactTestBitMask = PhysicsCategory.Obstacle | PhysicsCategory.Ground
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}
