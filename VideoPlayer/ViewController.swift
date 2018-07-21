//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Thieu Mao on 7/21/18.
//  Copyright © 2018 Thieu Mao. All rights reserved.
//

import UIKit
import YouTubePlayer

class ViewController: UIViewController {

    @IBOutlet weak var youtubePlayerView: YouTubePlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        youtubePlayerView.loadVideoID("xkhu732v3Wo")
    }


}

