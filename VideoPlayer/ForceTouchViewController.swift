//
//  ForceTouchViewController.swift
//  VideoPlayer
//
//  Created by Nguyen Van Thieu on 7/23/18.
//  Copyright © 2018 Thieu Mao. All rights reserved.
//

import UIKit

class ForceTouchViewController: UIViewController {

    private var link = "https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20180724T020055Z.05f75e8e2f5db66d.b224594bfd6854abb7d4cdd287efe1a1ae394cee &lang=vi-en&text=Anh yêu em"

    private var translateApiKey = "trnsl.1.1.20180724T020055Z.05f75e8e2f5db66d.b224594bfd6854abb7d4cdd287efe1a1ae394cee"
    private var translateApiLink = "https://translate.yandex.net/api/v1.5/tr.json/translate"

    @IBOutlet weak var forceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mao = getEnViLink("I love you")
        print(mao)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if #available(iOS 9.0, *) {
                if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
                    if touch.force >= touch.maximumPossibleForce {
                        forceLabel.text = "385+ grams"
                    } else {
                        let force = touch.force/touch.maximumPossibleForce
                        let grams = force * 385
                        let roundGrams = Int(grams)
                        forceLabel.text = "\(roundGrams) grams"
                    }
                }
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        forceLabel.text = "0 gram"
    }

}

// MARK: Translate API
extension ForceTouchViewController {

    func getViEnLink(_ text: String) -> String {
        return getTranslateApiLink("vi", "en", text)
    }

    func getEnViLink(_ text: String) -> String {
        return getTranslateApiLink("en", "vi", text)
    }

    func getTranslateApiLink(_ from: String, _ to: String, _ text: String) -> String {
        return getTranslateApiLink(translateApiKey, from, to, text)
    }

    func getTranslateApiLink(_ key: String, _ from: String, _ to: String, _ text: String) -> String {
        return "\(translateApiLink)?key=\(key)&lang=\(from)-\(to)&text=\(text)"
    }
}
