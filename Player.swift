//
//  Player.swift
//  DotGame
//
//  Created by Dahua Zhou on 8/12/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Player: CCSprite {
    
    func didLoadFromCCB(){
        schedule("spawnTrailDot", interval: 0.17)
    }
    
    func spawnTrailDot() {
        var traildot = TrailDot()
        traildot.position = ccp(positionInPoints.x, positionInPoints.y)
        parent.addChild(traildot)
    }
}