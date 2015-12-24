//
//  SetCardView.swift
//  Matchismo
//
//  Created by Davis Koh on 12/22/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

import UIKit

class SetCardView: CardView {
    var shading: String = ""

    // OPTIMIZE: make dimensios dynamic based on view size ------[NEXT]------
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
            y: self.origin().y - self.dimensions.height
        )
    }

    func addStripes(path: UIBezierPath) {
        let widthUnit = self.bounds.width / 3.0

        path.addClip()

        path.moveToPoint(CGPoint(
                x: widthUnit,
                y: self.bounds.origin.y
            ))
        path.addLineToPoint(CGPoint(
            x: widthUnit,
            y: self.bounds.height
        ))

        path.moveToPoint(self.basePoint())
        path.addLineToPoint(CGPoint(
            x: self.basePoint().x,
            y: self.bounds.height
        ))

        path.moveToPoint(CGPoint(
            x: self.bounds.width - widthUnit,
            y: self.bounds.origin.y
        ))
        path.addLineToPoint(CGPoint(
            x: self.bounds.width - widthUnit,
            y: self.bounds.height
        ))
    }

    func drawDiamond() {
        let diamondPath = UIBezierPath()

        diamondPath.moveToPoint(self.basePoint())

        // Right/Down
        let downRightEndPoint = CGPoint(
            x: self.origin().x + self.dimensions.width,
            y: self.origin().y
        )
        diamondPath.addLineToPoint(downRightEndPoint)

        // Left/Down
        let leftDownEndPoint = CGPoint(
            x: self.origin().x,
            y: self.origin().y + self.dimensions.height
        )
        diamondPath.addLineToPoint(leftDownEndPoint)

        // Left/Up
        let leftUpEndPoint = CGPoint(
            x: self.origin().x - self.dimensions.width,
            y: self.origin().y
        )
        diamondPath.addLineToPoint(leftUpEndPoint)

        diamondPath.addLineToPoint(self.basePoint())

        if self.shading == "fill" {
            self.color.setFill()
            diamondPath.fill()
        } else if self.shading == "stripe" {
            self.addStripes(diamondPath)
        }

        diamondPath.closePath()

        self.color.setStroke()
        diamondPath.stroke()
    }

    func drawOval() {
        let ovalPath = UIBezierPath()

        let topLineStart = CGPoint(
            x: self.basePoint().x - (self.dimensions.width / 2.0),
            y: self.basePoint().y
        )
        ovalPath.moveToPoint(topLineStart)

        let topLineEnd = CGPoint(
            x: self.basePoint().x + (self.dimensions.width / 2.0),
            y: self.basePoint().y
        )
        ovalPath.addLineToPoint(topLineEnd)

        ovalPath.addArcWithCenter(
            CGPoint(
                x: self.basePoint().x + (self.dimensions.width / 2.0),
                y: self.basePoint().y + self.dimensions.height
            ),
            radius: (self.dimensions.width / 2.0),
            startAngle: 270.degreesToRadians,
            endAngle: 90.degreesToRadians,
            clockwise: true
        )

        let bottomLineEnd = CGPoint(
            x: self.basePoint().x - (self.dimensions.width / 2.0),
            y: self.basePoint().y + (2.0 * self.dimensions.height)
        )
        ovalPath.addLineToPoint(bottomLineEnd)

        ovalPath.addArcWithCenter(
            CGPoint(
                x: self.basePoint().x - (self.dimensions.width / 2.0),
                y: self.basePoint().y + self.dimensions.height
            ),
            radius: (self.dimensions.width / 2.0),
            startAngle: 90.degreesToRadians,
            endAngle: 270.degreesToRadians,
            clockwise: true
        )

        ovalPath.closePath()

        if self.shading == "fill" {
            self.color.setFill()
            ovalPath.fill()
        } else if self.shading == "stripe" {
            self.addStripes(ovalPath)
        }

        self.color.setStroke()
        ovalPath.stroke()
    }

    func drawSquiggle() {
        let squigglePath = UIBezierPath()
        let startPoint = CGPoint(
            x: self.basePoint().x - self.dimensions.width,
            y: self.basePoint().y + (self.dimensions.height * 2.0)
        )

        squigglePath.moveToPoint(startPoint)

        let endpoint = CGPoint(
            x: self.basePoint().x + self.dimensions.width,
            y: self.basePoint().y
        )

        let topPoint1 = CGPoint(
            x: self.basePoint().x - self.dimensions.width,
            y: self.basePoint().y - self.dimensions.height * 2.0
        )
        let topPoint2 = CGPoint(
            x: self.basePoint().x + 1.0,
            y: self.basePoint().y + (self.dimensions.height * 2.0)
        )
        squigglePath.addCurveToPoint(
            endpoint,
            controlPoint1: topPoint1,
            controlPoint2: topPoint2
        )

        let bottomPoint1 = CGPoint(
            x: self.basePoint().x + self.dimensions.width,
            y: self.basePoint().y + self.dimensions.height * 4.0
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

        if self.shading == "fill" {
            self.color.setFill()
            squigglePath.fill()
        } else if self.shading == "stripe" {
            self.addStripes(squigglePath)
        }
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
