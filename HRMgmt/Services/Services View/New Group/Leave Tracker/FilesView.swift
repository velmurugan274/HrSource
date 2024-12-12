//
//  FilesView.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 24/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class FilesView : UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DownloadCell
        cell.downoadImage.addTarget(self, action: #selector(downloadStart), for: .touchUpInside)
        return cell
    }
    var downloadList : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = " Files "
        navigationController?.navigationBar.prefersLargeTitles = true
        downloadList = UITableView()
        downloadList.register(DownloadCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(downloadList)
        view.backgroundColor = UIColor(red: 231.0/255.0, green: 243/255.0, blue:253/255.0, alpha: 1)
        downloadList.delegate = self
       // downloadList.isUserInteractionEnabled = false
        downloadList.dataSource = self
        downloadList.rowHeight = 100
        downloadList.separatorStyle = .none
        downloadList.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        downloadList.backgroundColor = .clear
    }
    
    @objc func downloadStart(){
        self.showToast(message: "Your File is downloading")
        print("Downloading")
    }
    
}
