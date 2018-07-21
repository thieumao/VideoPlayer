//
//  ListViewController.swift
//  VideoPlayer
//
//  Created by Thieu Mao on 7/21/18.
//  Copyright © 2018 Thieu Mao. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
    }

}

// MARK: UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell") as? ItemTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell("Thieu \(indexPath.row)")
        return cell
    }
}

// MARK: UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    
}
