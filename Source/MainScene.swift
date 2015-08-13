import Foundation

class MainScene: CCNode {
    
    func play() {
        animationManager.runAnimationsForSequenceNamed("playAnimation")
    }
    
    func startGame() {
        let gameplayScene = CCBReader.loadAsScene("Gameplay")
        CCDirector.sharedDirector().presentScene(gameplayScene)
    }
    
    func about() {
        let gameplayScene = CCBReader.loadAsScene("About")
        CCDirector.sharedDirector().presentScene(gameplayScene)
    }
    
    func settings() {
        let gameplayScene = CCBReader.loadAsScene("Settings")
        CCDirector.sharedDirector().presentScene(gameplayScene)
    }
}
