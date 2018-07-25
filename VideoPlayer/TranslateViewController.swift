//
//  TranslateViewController.swift
//  VideoPlayer
//
//  Created by Thieu Mao on 7/26/18.
//  Copyright © 2018 Thieu Mao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TranslateViewController: UIViewController {
    
    private var translateApiKey = "trnsl.1.1.20180724T020055Z.05f75e8e2f5db66d.b224594bfd6854abb7d4cdd287efe1a1ae394cee"
    private var translateApiLink = "https://translate.yandex.net/api/v1.5/tr.json/translate"
    
    private var result: String? {
        didSet {
            guard let value = result else {
                return
            }
            if isTranslateEnglishIntoVietnamse {
                vietnameseTextView.text = value
            }
            else {
                englishTextView.text = value
            }
        }
    }

    @IBOutlet weak var englishTextView: UITextView!
    @IBOutlet weak var vietnameseTextView: UITextView!
    
    var isTranslateEnglishIntoVietnamse = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func translateEnglishIntoVietnamse(_ sender: Any) {
        view.endEditing(true)
        isTranslateEnglishIntoVietnamse = true
        guard let englishText = englishTextView.text else {
            return
        }
        translateEnVi(englishText)
    }
    
    @IBAction func translateVietnameseIntoEnglish(_ sender: Any) {
        view.endEditing(true)
        isTranslateEnglishIntoVietnamse = false
        guard let vietnameseText = vietnameseTextView.text else {
            return
        }
        translateViEn(vietnameseText)
    }
    
    @IBAction func tap(_ sender: Any) {
        view.endEditing(true)
    }
}

// MARK: Translate API
extension TranslateViewController {
    
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
extension TranslateViewController {
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
