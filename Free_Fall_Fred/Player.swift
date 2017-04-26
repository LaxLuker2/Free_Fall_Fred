//
//  Player.swift
//  Free_Fall_Fred
//
//  Created by igmstudent on 2/29/16.
//  Copyright © 2016 Schwarting_Schoolnick. All rights reserved.
//

import Foundation
import SpriteKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class Player: SKSpriteNode
{
    var direction:CGPoint = CGPoint(x: 1.0, y: 0.0)
    var forceOfGravity:Float = 9.81
    var maxSpd:CGFloat = 100
    var velocity:CGVector = CGVector(dx: 0, dy: 0)
    //var position:CGPoint = CGPointMake(0.0, 0.0)
    
    var health:Int = 0
    
    var xVelocity: CGFloat!
    
    var playerCharacter:SKSpriteNode!
    var bloodParticles:SKEmitterNode!
    var particlesPlayer:SKEmitterNode!
    
    init(screen:CGSize, pos:CGPoint, hp:Int)
    {
        let player = SKTexture(imageNamed: "skydiver")
        super.init(texture: player, color: UIColor.clear, size: player.size())
        position = pos
        setScale(0.25)
        name = "player"
        health = hp
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Move player around keep in bounds
    //Accelerometer
    func move(_ dt:CGFloat, bounds: CGRect)
    {
        
        xVelocity = gravityVector.x * 2 // 3 = more sensitive
        xVelocity = xVelocity < -1 ? -1 : xVelocity // -1.0 = 45 degrees left rotation
        xVelocity = xVelocity > 1 ? 1 : xVelocity // +1.0 = 45 degrees right rotation
        
        position.x += xVelocity * CGFloat(800.0) * dt
    }
    
    //check if player is in bounds
    func boundsCheckPlayer(_ playableRect:CGRect)
    {
        /*newPos:CGPoint, in the parameters
        
        let bottomLeft = CGPoint(x: 0, y: CGRectGetMinY(playableRect))
        let topRight = CGPoint(x: size.width, y: CGRectGetMaxY(playableRect))
        
        if newPos.x <= bottomLeft.x - 10
        {
            position.x = bottomLeft.x + 5 //(player.size.width / 2)
            return false
        }
        if newPos.x >= topRight.x
        {
            position.x = topRight.x - 5 //(player.size.width / 2)
            return false
        }*/
        
        if(position.x < 0)
        {
            position.x = 0
        }
        if(position.x > playableRect.width)
        {
            position.x = playableRect.width
        }
    }

    
    //MARK: Build Sprite for this object

    //white smoke
    func createParticles()
    {
        particlesPlayer = SKEmitterNode(fileNamed: "playerTrail")
        particlesPlayer.name = "particle"
        particlesPlayer.position = CGPoint(x: position.x - 580, y: position.y - 150)
        particlesPlayer.zPosition = 5
        particlesPlayer.setScale(4.0)
        
        
    }
    func removeParticles()
    {
        particlesPlayer.removeFromParent()
    }
    //MARK: Parachute
    func releaseParachute(_ playableRect: CGRect)
    {
        let parachute = SKSpriteNode(imageNamed: "parachute")
        parachute.name = "parachute"
        parachute.anchorPoint = CGPoint(x: 0.5, y: 0)
        print("player position x b4 : \(position.x)")
        parachute.position = CGPoint(x: position.x - ((position.x / playableRect.width) * 500), y: position.y - 280)
        parachute.setScale(0)
        parachute.zPosition = 1
        addChild(parachute)
        
        parachute.run(SKAction.sequence(
        [
            SKAction.run()
            {
                self.createParticles()
            },
            SKAction.moveBy(x: parachute.position.x - position.x - 21, y: parachute.position.y, duration: 0),
            SKAction.wait(forDuration: 0.25),
            SKAction.run()
            {
                self.removeParticles()
            },
            SKAction.scaleX(to: 1.0, duration: 0.0),
            SKAction.scaleY(to: 1.0, duration: 0.25)
            
            
        ]))
        print("parachute position x after : \(parachute.position.x)")
    }
    
    //MARK: kill player
    func destroy()
    {
        run(SKAction.sequence(
        [
            SKAction.run()
            {
                self.bloodParticles = SKEmitterNode(fileNamed: "bloodParticle")
                self.bloodParticles.name = "particle"
                self.bloodParticles.position = CGPoint(x: self.position.x - 580, y: self.position.y - 150)
                self.bloodParticles.zPosition = 5
                self.bloodParticles.setScale(4.0)
                self.addChild(self.bloodParticles)
            },
            SKAction.wait(forDuration: 0.5),
            SKAction.removeFromParent()
        ]))
    }
    
    
}
