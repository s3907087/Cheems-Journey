//
//  CGFloat+Ext.swift
//  Cheems Journey
//
//  Created by Donnie Tran on 8/31/23.
//

import CoreGraphics

public let π = CGFloat.pi

extension CGFloat{
    
    func radiansToDegree() -> CGFloat {
        return self * 180.0 / π
    }
    
    func degreeToRadians() -> CGFloat{
        return self * π / 180
    }
    
    static func random () -> CGFloat{
        return CGFloat(Float(arc4random())/Float(0xFFFFFFFF)) //return 0,1
    }
    static func random(min: CGFloat, max: CGFloat) -> CGFloat{
        assert (min<max)
        return CGFloat.random() * (max-min)+min //return min or max
    }
}
