//
//  SpriteComponent.swift
//  Flappy Bird
//
//  Created by iOS Development on 8/27/18.
//  Copyright © 2018 Smartivity Labs. All rights reserved.
//

import GameplayKit
import SpriteKit

class EntityNode: SKSpriteNode {
    
}

class SpriteComponent: GKComponent {
    let node : EntityNode
    
    init(entity:GKEntity, texture:SKTexture, size:CGSize) {
        node = EntityNode(texture: texture, color: SKColor.white, size: size)
        node.entity = entity
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
