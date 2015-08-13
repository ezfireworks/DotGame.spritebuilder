//
//  About.swift
//  DotGame
//
//  Created by Dahua Zhou on 8/11/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation
class About: CCScene {
    func back() {
        let gameplayScene = CCBReader.loadAsScene("MainScene")
        CCDirector.sharedDirector().presentScene(gameplayScene)
    }
}