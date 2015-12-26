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
        var base = CGPoint(
            x: self.origin().x,
            y: self.origin().y - (self.dimensions().height / 2.0)
        )

        if self.rank == 2 {
            base.y = self.origin().y - (self.dimensions().height + (self.dimensions().height / 5.0))
        }

        return base
    }

    func addStripes(path: UIBezierPath) {
        let widthUnit = self.bounds.width / 3.0

        path.moveToPoint(CGPoint(
            x: widthUnit,
            y: self.bounds.origin.y
        ))
        path.addLineToPoint(CGPoint(
            x: widthUnit,
            y: self.bounds.height
        ))

        path.moveToPoint(CGPoint(
            x: self.basePoint().x,
            y: self.bounds.origin.y
        ))
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

        self.color.setStroke()
        path.stroke()
    }

    func addShading(path: UIBezierPath) {
        if self.shading == "fill" {
            self.color.setFill()
            path.fill()
        } else if self.shading == "stripe" {
            self.addStripes(path)
        }
    }

    func strokeAtPath(path: UIBezierPath) {
        self.color.setStroke()
        path.stroke()
    }

    func drawDiamond(basePoint: CGPoint, diamondPath: UIBezierPath) {
        let width = self.dimensions().width
        let height = self.dimensions().height

        diamondPath.moveToPoint(basePoint)

        // Right/Down
        let downRightEndPoint = CGPoint(
            x: basePoint.x + (width / 2.0),
            y: basePoint.y + (height / 2.0)
        )
        diamondPath.addLineToPoint(downRightEndPoint)

        // Left/Down
        let leftDownEndPoint = CGPoint(
            x: basePoint.x,
            y: basePoint.y + height
        )
        diamondPath.addLineToPoint(leftDownEndPoint)

        // Left/Up
        let leftUpEndPoint = CGPoint(
            x: basePoint.x - (width / 2.0),
            y: basePoint.y + (height / 2.0)
        )
        diamondPath.addLineToPoint(leftUpEndPoint)

        diamondPath.addLineToPoint(basePoint)

        self.strokeAtPath(diamondPath)
    }

    func drawOval(basePoint: CGPoint, ovalPath: UIBezierPath) {
        let width = self.dimensions().width
        let height = self.dimensions().height

        let topLineStart = CGPoint(
            x: basePoint.x - (width / 4.0),
            y: basePoint.y
        )
        ovalPath.moveToPoint(topLineStart)

        let topLineEnd = CGPoint(
            x: basePoint.x + (width / 4.0),
            y: basePoint.y
        )
        ovalPath.addLineToPoint(topLineEnd)

        ovalPath.addArcWithCenter(
            CGPoint(
                x: basePoint.x + (width / 4.0),
                y: basePoint.y + (height / 2.0)
            ),
            radius: height / 2.0,
            startAngle: 270.degreesToRadians,
            endAngle: 90.degreesToRadians,
            clockwise: true
        )

        let bottomLineEnd = CGPoint(
            x: basePoint.x - (width / 4.0),
            y: basePoint.y + height
        )
        ovalPath.addLineToPoint(bottomLineEnd)

        ovalPath.addArcWithCenter(
            CGPoint(
                x: basePoint.x - (width / 4.0),
                y: basePoint.y + (height / 2.0)
            ),
            radius: (height / 2.0),
            startAngle: 90.degreesToRadians,
            endAngle: 270.degreesToRadians,
            clockwise: true
        )

        self.strokeAtPath(ovalPath)
    }

    func drawSquiggle(basePoint: CGPoint, squigglePath: UIBezierPath) {
        let width = self.dimensions().width
        let height = self.dimensions().height

        let startPoint = CGPoint(
            x: basePoint.x - (width / 2.0),
            y: basePoint.y + height
        )

        squigglePath.moveToPoint(startPoint)

        let endpoint = CGPoint(
            x: basePoint.x + (width / 2.0),
            y: basePoint.y
        )

        let topPoint1 = CGPoint(
            x: basePoint.x - width,
            y: basePoint.y - height
        )
        let topPoint2 = CGPoint(
            x: basePoint.x + 1.0,
            y: basePoint.y + height
        )
        squigglePath.addCurveToPoint(
            endpoint,
            controlPoint1: topPoint1,
            controlPoint2: topPoint2
        )

        let bottomPoint1 = CGPoint(
            x: basePoint.x + width,
            y: basePoint.y + (height * 2.0)
        )
        let bottomPoint2 = CGPoint(
            x: basePoint.x - 1.0,
            y: basePoint.y - 1.0
        )
        squigglePath.addCurveToPoint(
            startPoint,
            controlPoint1: bottomPoint1,
            controlPoint2: bottomPoint2
        )

        self.strokeAtPath(squigglePath)
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)

        var draw: (CGPoint, UIBezierPath) -> ()

        if self.faceUp {
            switch self.suit {
            case "diamond":
                draw = self.drawDiamond
            case "oval":
                draw = self.drawOval
            case "squiggle":
                draw = self.drawSquiggle
            default:
                // TODO: draw another shape that clearly shows non-option
                // below needed because switch needs to be exhaustive
                // and draw needs to be initialized
                draw = self.drawDiamond
            }

            let path = UIBezierPath()
            draw(self.basePoint(), path)

            let offset = (self.dimensions().height + (self.dimensions().height / 5.0))
            if self.rank == 2 {
                draw(CGPoint(
                    x: self.basePoint().x,
                    y: self.basePoint().y + offset
                ), path)
            }

            if self.rank == 3 {
                draw(CGPoint(
                    x: self.basePoint().x,
                    y: self.basePoint().y - offset
                ), path)
                draw(CGPoint(
                    x: self.basePoint().x,
                    y: self.basePoint().y + offset
                ), path)
            }

            path.addClip()
            self.addShading(path)
        }
    }
}
