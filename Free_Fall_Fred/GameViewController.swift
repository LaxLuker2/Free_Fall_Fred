//
//  GameViewController.swift
//  Free_Fall_Fred
//
//  Created by igmstudent on 2/29/16.
//  Copyright (c) 2016 Schwarting_Schoolnick. All rights reserved.
//

import UIKit
import SpriteKit
import CoreMotion //accelerometer

 // MARK: - globals
let motionManager = CMMotionManager()
var rotation:CGFloat = 0
var gravityVector = CGPoint.zero
var accelerationVector = CGPoint.zero
var level = 1
var maxLevels = 10

class GameViewController: UIViewController
{
    // MARK: - ivars -
    let scaleMode = SKSceneScaleMode.aspectFill
    
    // MARK: - Initialization
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.becomeFirstResponder()
        
        setupDeviceMotion()
        
        //MARK: Setup Scene
        let scene = Menu(size:CGSize(width: 1080, height: 1920))
        let skView = self.view as! SKView
        //skView.showsFPS = true
        //skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        //skView.showsPhysics = true;
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }
    
    //MARK: - Implement Motion - //accelerometer
    func setupDeviceMotion()
    {
        if motionManager.isDeviceMotionAvailable
        {
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main)
            {
                data, error in
                guard data != nil else{
                    print("there was an error: \(error)")
                    return
                }
                rotation = CGFloat(atan2(data!.gravity.x, data!.gravity.y) - M_PI)
                gravityVector = CGPoint(x: CGFloat(data!.gravity.x),y: CGFloat(data!.gravity.y))
                accelerationVector = CGPoint(x: CGFloat(data!.userAcceleration.x),y: CGFloat(data!.userAcceleration.y))
            }
        }
        
    }
    /*override func viewDidDisappear(animated: Bool)
    {
        motionManager.stopDeviceMotionUpdates()
    }
    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }*/
    
    /*func setAcceleration(x:Double, y:Double, z:Double)
    {
        currentAccel["x"] = CGFloat(x)
        currentAccel["y"] = CGFloat(y)
        currentAccel["z"] = CGFloat(z)
    }*/
    
    
    /*func setRotation(x:Double, y:Double, z:Double)
    {
        currentRotate["x"] = CGFloat(x)
        currentRotate["y"] = CGFloat(y)
        currentRotate["z"] = CGFloat(z)
    }*/
}
