//
//  Menu.swift
//  Free_Fall_Fred
//
//  Created by igmstudent on 3/7/16.
//  Copyright © 2016 Schwarting_Schoolnick. All rights reserved.
//
import SpriteKit


//MARK: Menu screen
class Menu: SKScene
{
    var top:CGFloat = 0, bottom:CGFloat = 0, left:CGFloat = 0, right:CGFloat = 0
    var playableRect:CGRect = CGRect.zero
    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0
    var viewController: GameViewController!
    
    
    override func didMove(to view: SKView)
    {
        setupUI()
        
    }
    override func update(_ currentTime: TimeInterval)
    {
        if lastUpdateTime > 0
        {
            dt = currentTime - lastUpdateTime
        }
        else
        {
            dt = 0
        }
        lastUpdateTime = currentTime
    }
    
    // MARK: - Helpers -
    func setupUI()
    {
        // calculate playable rect for iPhone 4S
        top = is4SorOlder() ? size.height - 150 : size.height
        bottom = is4SorOlder() ? 150 : 0
        left = 0
        right = size.width
        playableRect = CGRect(x: 0, y: bottom, width: size.width, height: top)
        
        backgroundColor = SKColor.black
        let background = SKSpriteNode(imageNamed: "freefallfred-MM")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.zPosition = GameLayer.Background
        addChild(background)
        
        
        /*runAction(SKAction.sequence(
        [
        SKAction.waitForDuration(15.0),
        SKAction.runBlock()
        {
        
        }
        ]))*/
        
        print("background.size=\(background.size)")
        print("playableRect=\(playableRect.size)")
        print("screen aspect ratio=\(getScreenAspectRatio())")
        print("is4SorOlder=\(is4SorOlder())")
        
    }
    func moveSprites(_ rotation:Double, prevRotation:Double, currentAccel:[String:CGFloat])
    {
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches 
        let location = touch.first!.location(in: self)
        
        //if play button is touch moved to play screen
        if(location.x > 350 && location.x < 790 && location.y > 950 && location.y < 1170)
        {
            let scene = GameScene(size:CGSize(width: 1080, height: 1920))
            let skView = self.view as SKView!
            //skView.showsFPS = true
            //skView.showsNodeCount = true
            skView?.ignoresSiblingOrder = true
            scene.scaleMode = .aspectFill
            
            let transition = SKTransition.crossFade(withDuration: 1.0)
            
            skView?.presentScene(scene, transition: transition)
        }
        
        //if help button is touch moved to play screen
        if(location.x > 350 && location.x < 790 && location.y > 600 && location.y < 820)
        {
            let scene = Help(size:CGSize(width: 1080, height: 1920))
            let skView = self.view as SKView!
            //skView.showsFPS = true
            //skView.showsNodeCount = true
            skView?.ignoresSiblingOrder = true
            scene.scaleMode = .aspectFill
            
            let transition = SKTransition.crossFade(withDuration: 1.0)
            
            skView?.presentScene(scene,transition: transition)
        }
    }
    
    
}
