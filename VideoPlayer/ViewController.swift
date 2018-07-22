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
    lazy var playlistID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // youtubePlayerView.loadPlaylistID("PLe6dgR6eSaYHe8hwvyl8MixHQS6YjSgQY")
        // youtubePlayerView.loadVideoID("xkhu732v3Wo")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        youtubePlayerView.loadPlaylistID(playlistID)
    }

}

