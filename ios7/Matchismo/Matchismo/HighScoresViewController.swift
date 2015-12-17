//
//  HighScoresViewController.swift
//  Matchismo
//
//  Created by Davis Koh on 12/16/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

import UIKit

class HighScoresViewController: UIViewController {
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.yellowColor()

        let bounds = self.view.bounds
        let textView = UITextView(frame: CGRect(
            x: bounds.origin.x,
            y: 20,
            width: bounds.size.width,
            height: bounds.size.height
        ))

        self.view.addSubview(self.textViewWithText(textView))
    }

    func textViewWithText(textView: UITextView) -> UITextView {
        textView.text = self.createScoreString("Playing Card") + "\n"
        textView.text = textView.text + self.createScoreString("Set Card")
        textView.font = UIFont.systemFontOfSize(20)
        return textView
    }

    func createScoreString(gameType: String) -> String {
        let defaults = NSUserDefaults.standardUserDefaults()

        var playingCardScore = "\(gameType) Game High Scores \n"
        // FIXME: really ghetto keys...
        for score in defaults.arrayForKey("\(gameType)HighScores")! {
            playingCardScore += score.stringValue + "\n"
        }

        return playingCardScore
    }
}
