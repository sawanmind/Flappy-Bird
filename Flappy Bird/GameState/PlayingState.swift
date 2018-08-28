//
//  PlayingState.swift
//  Flappy Bird
//
//  Created by iOS Development on 8/27/18.
//  Copyright © 2018 Smartivity Labs. All rights reserved.
//

import SpriteKit
import GameplayKit


class PlayingState: GKState {
    
    unowned let scene: GameScene
    
    init(scene:SKScene) {
        self.scene = scene as! GameScene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        scene.startSpawing()
        scene.player.movementAllowed = true
        scene.player.animationComponent.startAnimation()
        scene.player.animationComponent.stopWobble()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return (stateClass == FallingState.self) || (stateClass == GameOverState.self)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        scene.updateForeground()
        scene.updateScore()
    }
}
