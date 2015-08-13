//
//  Trail.swift
//  DotGame
//
//  Created by Dahua Zhou on 8/12/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class TrailDot: CCSprite {
    
    var speed : CGFloat = 50
    var actionDuration : Double = 3
    
    override func onEnter() {
        super.onEnter()
        spriteFrame = CCSpriteFrame(imageNamed: "Assets/player.png")
        scale = 0.03
        var scaleDown = CCActionScaleTo(duration: actionDuration, scale: 0)
        var fade = CCActionFadeOut(duration: actionDuration)
        var remove = CCActionCallBlock(block: {self.removeFromParent()})
        runAction(scaleDown)
        runAction(CCActionSequence(array: [fade, remove]))
    }
    
    override func update(delta: CCTime) {
        self.position.x -= speed * CGFloat(delta)
    }
}