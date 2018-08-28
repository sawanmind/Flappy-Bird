//
//  AnimationComponent.swift
//  Flappy Bird
//
//  Created by iOS Development on 8/27/18.
//  Copyright © 2018 Smartivity Labs. All rights reserved.
//

import SpriteKit
import GameplayKit

class AnimationComponent: GKComponent {
    let spriteComponent:SpriteComponent
    var textures: Array<SKTexture> = []
    
    init(entity:GKEntity, textures:Array<SKTexture>) {
        self.textures = textures
        self.spriteComponent = entity.component(ofType: SpriteComponent.self)!
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        if let player = entity as? PlayerEntity {
            if player.movementAllowed {
                startAnimation()
            } else {stopAnimation("Flap")
                
            }
        }
    }
    
    func startAnimation(){
        if (spriteComponent.node.action(forKey: "Flap") == nil) {
            let playeranimation = SKAction.animate(with: textures, timePerFrame: 0.07)
            let repeatAction = SKAction.repeatForever(playeranimation)
            spriteComponent.node.run(repeatAction, withKey: "Flap")
        }
    }
    
    func startWobble(){
        let moveup = SKAction.moveBy(x: 0, y: 10, duration: 0.4)
        moveup.timingMode = .easeInEaseOut
        let moveDown = moveup.reversed()
        let sequence = SKAction.sequence([moveup, moveDown])
        let repeatWobbble = SKAction.repeatForever(sequence)
        spriteComponent.node.run(repeatWobbble, withKey: "Wobble")
        
        let flapWings = SKAction.animate(with: textures, timePerFrame: 0.07)
        let repeatFlap = SKAction.repeatForever(flapWings)
        spriteComponent.node.run(repeatFlap, withKey: "Wobble-Flap")
    }
    
    
    func stopWobble(){
        stopAnimation("Wobble")
        stopAnimation("Wobble-Flap")
    }
    
    func stopAnimation(_ name:String) {
        spriteComponent.node.removeAction(forKey: name)
    }
}






