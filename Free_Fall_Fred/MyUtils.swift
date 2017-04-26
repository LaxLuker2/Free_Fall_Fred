//
//  MyUtils.swift
//  Free_Fall_Fred
//
//  Created by igmstudent on 2/29/16.
//  Copyright © 2016 Schwarting_Schoolnick. All rights reserved.
//

import SpriteKit
import UIKit

func is4SorOlder()->Bool
{
    return UIScreen.main.bounds.height == 480
}

func getScreenAspectRatio()->CGFloat
{
    return UIScreen.main.bounds.height/UIScreen.main.bounds.width
}

func randomCGPointInRect(_ rect:CGRect,margin:CGFloat)->CGPoint
{
    let x = CGFloat.random(min: rect.minX + margin, max: rect.maxX - margin)
    let y = CGFloat.random(min: rect.minY + margin, max: rect.maxY - margin)
    return CGPoint(x: x,y: y)
}



extension CGPoint
{
    public static func randomUnitVector()->CGPoint
    {
        let vector = CGPoint(x: CGFloat.random(min:-1.0,max:1.0),y: CGFloat.random(min:-1.0,max:1.0))
        return vector.normalized()
    }
}
