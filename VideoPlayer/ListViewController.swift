//
//  ListViewController.swift
//  VideoPlayer
//
//  Created by Thieu Mao on 7/21/18.
//  Copyright © 2018 Thieu Mao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ListViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    
    let link = "https://www.googleapis.com/youtube/v3/playlists?part=snippet,contentDetails&maxResults=25&channelId=UCOgl0poXA0PzbtC037vP0GA&fields=items(contentDetails,id,snippet(title,thumbnails(high(url),default))),nextPageToken,pageInfo&key=AIzaSyB5Jgo4jTYPq5Nep-7k2KqQCHjV4wbWC-w"

    var playlists = [Playlist]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        callAPI()
    }
    
    private func setupTableView() {
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
    }
}

// MARK: Network
extension ListViewController {
    private func callAPI() {
        Alamofire.request(link).responseJSON { [weak self] responseData in
            guard let `self` = self else { return }
            guard let value = responseData.result.value else {
                print("Error")
                return
            }
            self.parseJson(value)
        }
    }
    
    private func parseJson(_ value: Any) {
        let json = JSON(value)
        guard let items = json["items"].arrayObject as? [[String:AnyObject]] else { return }
        playlists.removeAll()
        items.forEach { item in
            guard let id = item["id"] as? String  else { return }
            guard let snippet = item["snippet"]  else { return }
            guard let title = snippet["title"] as? String else { return }
            let playlist = Playlist(id: id, title: title)
            playlists.append(playlist)
        }
        listTableView.reloadData()
    }
}

// MARK: UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell") as? ItemTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(playlists[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(playlists[indexPath.row].title)
        print(playlists[indexPath.row].id)
        openViewController(playlists[indexPath.row].id)
    }
    
    private func openViewController(_ id: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
        controller.playlistID = id
//        self.present(controller, animated: true, completion: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
