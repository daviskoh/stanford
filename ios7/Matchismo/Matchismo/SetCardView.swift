//
//  SetCardView.swift
//  Matchismo
//
//  Created by Davis Koh on 12/22/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

import UIKit

class SetCardView: CardView {
    // OPTIMIZE: make dimensios dynamic based on view size
    let dimensions = CGSize(
        width: 20.0,
        height: 10.0
    )

    func origin() -> CGPoint {
        return CGPoint(
            x: CGRectGetMidX(self.bounds),
            y: CGRectGetMidY(self.bounds)
        )
    }

    func basePoint() -> CGPoint {
        return CGPoint(
            x: self.origin().x,
            y: self.origin().y
        )
    }

    // OPTIMIZE: remove hard-coded values & use some fucking vars gosh...
    func drawDiamond() {
        let diamondPath = UIBezierPath()

        diamondPath.moveToPoint(self.basePoint())

        // Right/Down
        diamondPath.addLineToPoint(CGPoint(
            x: self.origin().x + self.dimensions.width,
            y: self.origin().y + self.dimensions.height
        ))

        // Left/Down
        diamondPath.addLineToPoint(CGPoint(
            x: self.origin().x,
            y: self.origin().y + (2.0 * self.dimensions.height)
        ))

        // Left/Up
        diamondPath.addLineToPoint(CGPoint(
            x: self.origin().x - self.dimensions.width,
            y: self.origin().y + self.dimensions.height
        ))

        diamondPath.closePath()

        self.color.setFill()
        diamondPath.fill()
        self.color.setStroke()
        diamondPath.stroke()
    }

    func drawOval() {
        let ovalPath = UIBezierPath()

        ovalPath.moveToPoint(CGPoint(
            x: self.basePoint().x - (self.dimensions.width / 2.0),
            y: self.basePoint().y
        ))

        ovalPath.addLineToPoint(CGPoint(
            x: self.origin().x + (self.dimensions.width / 2.0),
            y: self.origin().y
        ))

        ovalPath.addArcWithCenter(
            CGPoint(
                x: self.origin().x + (self.dimensions.width / 2.0),
                y: self.origin().y + self.dimensions.height
            ),
            radius: (self.dimensions.width / 2.0),
            startAngle: 270.degreesToRadians,
            endAngle: 90.degreesToRadians,
            clockwise: true
        )

        ovalPath.addLineToPoint(CGPoint(
            x: self.origin().x - (self.dimensions.width / 2.0),
            y: self.origin().y + (2.0 * self.dimensions.height)
        ))

        ovalPath.addArcWithCenter(
            CGPoint(
                x: self.origin().x - (self.dimensions.width / 2.0),
                y: self.origin().y + self.dimensions.height
            ),
            radius: (self.dimensions.width / 2.0),
            startAngle: 90.degreesToRadians,
            endAngle: 270.degreesToRadians,
            clockwise: true
        )

        ovalPath.closePath()

        self.color.setFill()
        ovalPath.fill()
        self.color.setStroke()
        ovalPath.stroke()
    }

    func drawSquiggle() {
        let squigglePath = UIBezierPath()
        let startPoint = CGPoint(
            x: self.basePoint().x - self.dimensions.width,
            y: self.basePoint().y + self.dimensions.height
        )

        squigglePath.moveToPoint(startPoint)

        let endpoint = CGPoint(
            x: self.basePoint().x + self.dimensions.width,
            y: self.basePoint().y - self.dimensions.height
        )

        let topPoint1 = CGPoint(
            x: self.basePoint().x - self.dimensions.width,
            y: self.basePoint().y - self.dimensions.height * 5.0
        )
        let topPoint2 = CGPoint(
            x: self.basePoint().x + 1.0,
            y: self.basePoint().y + self.dimensions.height
        )
        squigglePath.addCurveToPoint(
            endpoint,
            controlPoint1: topPoint1,
            controlPoint2: topPoint2
        )

        let bottomPoint1 = CGPoint(
            x: self.basePoint().x + self.dimensions.width,
            y: self.basePoint().y + self.dimensions.height * 5.0
        )
        let bottomPoint2 = CGPoint(
            x: self.basePoint().x - 1.0,
            y: self.basePoint().y - self.dimensions.height
        )
        squigglePath.addCurveToPoint(
            startPoint,
            controlPoint1: bottomPoint1,
            controlPoint2: bottomPoint2
        )

        squigglePath.closePath()

        self.color.setFill()
        squigglePath.fill()
        self.color.setStroke()
        squigglePath.stroke()
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)

        if self.faceUp {
            switch self.suit {
            case "diamond":
                self.drawDiamond()
            case "oval":
                self.drawOval()
            case "squiggle":
                self.drawSquiggle()
            default:
                break
            }
        }
    }
}
