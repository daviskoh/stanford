//
//  SetCardView.swift
//  Matchismo
//
//  Created by Davis Koh on 12/22/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

import UIKit

class SetCardView: CardView {
    func drawDiamond() {
        let diamondPath = UIBezierPath()

        let origin = CGPoint(
            x: CGRectGetMidX(self.bounds),
            y: CGRectGetMidY(self.bounds)
        )
        let dimensions = CGSize(
            width: 10.0,
            height: 5.0
        )
        let startingPoint = CGPointMake(origin.x, origin.y)

        diamondPath.moveToPoint(startingPoint)

        // Right/Down
        diamondPath.addLineToPoint(CGPoint(
            x: origin.x + dimensions.width,
            y: origin.y + dimensions.height
        ))

        // Left/Down
        diamondPath.addLineToPoint(CGPoint(
            x: origin.x,
            y: origin.y + (2.0 * dimensions.height)
        ))

        // Left/Up
        diamondPath.addLineToPoint(CGPoint(
            x: origin.x - dimensions.width,
            y: origin.y + dimensions.height
        ))

        diamondPath.closePath()

        self.color.setFill()
        diamondPath.fill()
        self.color.setStroke()
        diamondPath.stroke()
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)

        if self.faceUp {
            switch self.suit {
            case "diamond":
                self.drawDiamond()
            case "oval":
                break
            case "squiggle":
                break
            default:
                break
            }
        }
    }
}
