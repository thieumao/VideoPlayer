//
//  ForceTouchViewController.swift
//  VideoPlayer
//
//  Created by Nguyen Van Thieu on 7/23/18.
//  Copyright © 2018 Thieu Mao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SQLite

class ForceTouchViewController: UIViewController {

    private var link = "https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20180724T020055Z.05f75e8e2f5db66d.b224594bfd6854abb7d4cdd287efe1a1ae394cee &lang=vi-en&text=Anh yêu em"

    private var translateApiKey = "trnsl.1.1.20180724T020055Z.05f75e8e2f5db66d.b224594bfd6854abb7d4cdd287efe1a1ae394cee"
    private var translateApiLink = "https://translate.yandex.net/api/v1.5/tr.json/translate"

    private var result: String? {
        didSet {
            if let value = result {
                print(value)
            }
        }
    }

    @IBOutlet weak var forceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        translateEnVi("I love you")
//        translateViEn("Anh ơi")
//        open()
    }

    var DB_NAME = "data.db"

    func open(dbPath: String = "") {
        var dbURL: URL
        if dbPath.isEmpty {
            guard let url = Bundle.main.resourceURL else { return }
            dbURL = url.appendingPathComponent(DB_NAME)
        } else {
            dbURL = URL(fileURLWithPath: dbPath)
        }
        print(dbURL.absoluteString)
        guard let db = try? Connection(dbURL.absoluteString) else {
            print("Error: Connect Database failed")
            return
        }
        guard let stmt = try? db.prepare("SELECT * FROM dictionary") else {
            print("Error: SQL query wrong")
            return
        }
        for row in stmt {
            print("id: \(row[0]), short: \(row[1]), vi: \(row[2]), en: \(row[3])")
        }
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

// MARK: Network
extension ForceTouchViewController {
    // translate Vietnamese into English
    func translateViEn(_ text: String) {
        let link = getViEnLink(text)
        guard let encodeLink = link.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) else {
            return
        }
        callAPI(text, encodeLink)
    }

    // translate English into Vietnamse
    func translateEnVi(_ text: String) {
        let link = getEnViLink(text)
        guard let encodeLink = link.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) else {
            return
        }
        callAPI(text, encodeLink)
    }

    private func callAPI(_ text: String, _ link: String) {
        Alamofire.request(link).responseJSON { [weak self] responseData in
            guard let `self` = self, let value = responseData.result.value else {
                return
            }
            self.parseJson(value)
        }
    }

    private func parseJson(_ value: Any) {
        let json = JSON(value)
        guard let text = json["text"].arrayObject as? [String], !text.isEmpty else {
            result = nil
            return
        }
        result = text[0]
    }
}
