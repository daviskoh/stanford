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

    func dimensions() -> CGSize {
        return CGSize(
            width: self.bounds.size.width / 2.0,
            height: self.bounds.size.height / 5.0
        )
    }

    func origin() -> CGPoint {
        return CGPoint(
            x: CGRectGetMidX(self.bounds),
            y: CGRectGetMidY(self.bounds)
        )
    }

    func basePoint() -> CGPoint {
        return CGPoint(
            x: self.origin().x,
            y: self.origin().y - (self.dimensions().height / 2.0)
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

        let width = self.dimensions().width
        let height = self.dimensions().height

        diamondPath.moveToPoint(self.basePoint())

        // Right/Down
        let downRightEndPoint = CGPoint(
            x: self.origin().x + (width / 2.0),
            y: self.origin().y
        )
        diamondPath.addLineToPoint(downRightEndPoint)

        // Left/Down
        let leftDownEndPoint = CGPoint(
            x: self.origin().x,
            y: self.origin().y + (height / 2.0)
        )
        diamondPath.addLineToPoint(leftDownEndPoint)

        // Left/Up
        let leftUpEndPoint = CGPoint(
            x: self.origin().x - (width / 2.0),
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

        let width = self.dimensions().width
        let height = self.dimensions().height

        let topLineStart = CGPoint(
            x: self.basePoint().x - (width / 4.0),
            y: self.basePoint().y
        )
        ovalPath.moveToPoint(topLineStart)

        let topLineEnd = CGPoint(
            x: self.basePoint().x + (width / 4.0),
            y: self.basePoint().y
        )
        ovalPath.addLineToPoint(topLineEnd)

        ovalPath.addArcWithCenter(
            CGPoint(
                x: self.basePoint().x + (width / 4.0),
                y: self.basePoint().y + (height / 2.0)
            ),
            radius: height / 2.0,
            startAngle: 270.degreesToRadians,
            endAngle: 90.degreesToRadians,
            clockwise: true
        )

        let bottomLineEnd = CGPoint(
            x: self.basePoint().x - (width / 4.0),
            y: self.basePoint().y + height
        )
        ovalPath.addLineToPoint(bottomLineEnd)

        ovalPath.addArcWithCenter(
            CGPoint(
                x: self.basePoint().x - (width / 4.0),
                y: self.basePoint().y + (height / 2.0)
            ),
            radius: (height / 2.0),
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

        let width = self.dimensions().width
        let height = self.dimensions().height

        let startPoint = CGPoint(
            x: self.basePoint().x - (width / 2.0),
            y: self.basePoint().y + height
        )

        squigglePath.moveToPoint(startPoint)

        let endpoint = CGPoint(
            x: self.basePoint().x + (width / 2.0),
            y: self.basePoint().y
        )

        let topPoint1 = CGPoint(
            x: self.basePoint().x - width,
            y: self.basePoint().y - height
        )
        let topPoint2 = CGPoint(
            x: self.basePoint().x + 1.0,
            y: self.basePoint().y + height
        )
        squigglePath.addCurveToPoint(
            endpoint,
            controlPoint1: topPoint1,
            controlPoint2: topPoint2
        )

        let bottomPoint1 = CGPoint(
            x: self.basePoint().x + width,
            y: self.basePoint().y + (height * 2.0)
        )
        let bottomPoint2 = CGPoint(
            x: self.basePoint().x - 1.0,
            y: self.basePoint().y - 1.0
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
