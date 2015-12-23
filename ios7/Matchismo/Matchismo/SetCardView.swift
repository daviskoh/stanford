//
//  SetCardView.swift
//  Matchismo
//
//  Created by Davis Koh on 12/22/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

import UIKit

class SetCardView: CardView {
    func drawShape(suit: String) {
        let length = self.bounds.size.width / 3
        let bounds = CGRect(
            x: self.bounds.origin.x,
            y: self.bounds.origin.y,
            width: length,
            height: length
        )

        var shape: UIBezierPath?

        if suit == "triangle" {
            shape = UIBezierPath(
                roundedRect: bounds,
                cornerRadius: 0
            )
        } else if suit == "squiggle" {

        } else if suit == "oval" {

        }

        shape?.addClip()
        self.color.setFill()
        UIRectFill(self.bounds)
        UIColor.blackColor().setStroke()
        shape?.stroke()

        let context = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(
            context,
            bounds.size.width,
            bounds.size.height
        )
        CGContextRotateCTM(
            context,
            CGFloat(M_PI*45/180)
        )

        self.drawRect(bounds)
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)

        if self.faceUp {
            self.drawShape(self.suit)
        }
    }
}
