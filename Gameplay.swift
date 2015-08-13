import Foundation

class Gameplay: CCNode, CCPhysicsCollisionDelegate{
    
    weak var scoreLabel: CCLabelTTF!
    weak var gamePhysicsNode: CCPhysicsNode!
    weak var player: CCSprite!
    
    
    var screenWidth = CCDirector.sharedDirector().viewSize().width
    var bottomBlocks : [CCNode] = []
    var topBlocks : [CCNode] = []
    var score: Int = 0 {
        didSet {
            scoreLabel.string = "\(score)"
        }
    }
    var speed : CGFloat = 50
    var touched: Bool = false
    
    let firstBlockPosition : CGFloat = 400
    let distanceBetweenBlocks : CGFloat = 0
    
    func didLoadFromCCB() {
        userInteractionEnabled = true
        gamePhysicsNode.collisionDelegate = self
        gamePhysicsNode.debugDraw = false
        self.schedule("addPoint", interval: 1.0)
        for i in 0...1 {
            spawnNewBlock()
            spawnTopBlock()
        var traildot = TrailDot()
        traildot.position = ccp(64,284)
        addChild(traildot)
        }
    }
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        touched = true
    }
    
    override func touchEnded(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        touched = false
    }
    
    override func update(delta: CCTime) {
        
        if player.position.y < 0 || player.position.y > gamePhysicsNode.contentSize.height {
            var gameOverScene = CCBReader.loadAsScene("GameOver")
            CCDirector.sharedDirector().presentScene(gameOverScene)
        }
        
        if touched {
            player.physicsBody.applyImpulse(CGPoint(x: 0,y: 20000 * delta))
        }
        
        if bottomBlocks.count > 0 {
            let blockWorldPosition = gamePhysicsNode.convertToWorldSpace(bottomBlocks[0].position)
            let blockScreenPosition = convertToNodeSpace(blockWorldPosition)
            
            let topBlockWorldPosition = gamePhysicsNode.convertToWorldSpace(topBlocks[0].position)
            let topBlockScreenPosition = convertToNodeSpace(blockWorldPosition)
            
            for block in bottomBlocks {
                block.position.x -= speed * CGFloat(delta)
            }
            
            for block in topBlocks {
                block.position.x -= speed * CGFloat(delta)
            }
            
            if blockScreenPosition.x < -400 {
                gamePhysicsNode.removeChild(bottomBlocks[0])
                bottomBlocks.removeAtIndex(0)
                spawnNewBlock()
            }
            if topBlockScreenPosition.x < -400 {
                gamePhysicsNode.removeChild(topBlocks[0])
                topBlocks.removeAtIndex(0)
                spawnTopBlock()
            }
        }
    }
    
    func spawnTopBlock() {
        var blockNumber = arc4random_uniform(5) + 1
        
        let block = CCBReader.load("Blocks/Block\(blockNumber)")
        
        if topBlocks.count == 0 {
            block.position.x = screenWidth
            block.position.y = 400
        }
        else {
            block.position.x = topBlocks.last!.position.x + 400
            block.position.y = topBlocks.last!.position.y
        }
        
        gamePhysicsNode.addChild(block)
        topBlocks.append(block)
        
    }
    func spawnNewBlock() {
        
        var blockNumber = arc4random_uniform(5) + 1
        
        let block = CCBReader.load("Blocks/Block\(blockNumber)")
        
        if bottomBlocks.count == 0 {
            block.position.x = screenWidth
        }
        else {
            block.position.x = bottomBlocks.last!.position.x + 400
        }
        
        gamePhysicsNode.addChild(block)
        bottomBlocks.append(block)
        
    }
    
    func addPoint() {
        score++
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, player: CCNode!, enemy: CCNode!) -> ObjCBool {
        var gameOverScene = CCBReader.loadAsScene("GameOver")
        CCDirector.sharedDirector().presentScene(gameOverScene)
        println("Player Lost")
        return true
    }
}