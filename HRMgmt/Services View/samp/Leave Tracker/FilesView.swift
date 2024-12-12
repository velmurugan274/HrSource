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
        return fileTitle.count
    }
    var fileTitle = ["Leave Policy", "Rules and Regulation" , "Travel Policy", "Social Media Policy"]
    var fileDescription = ["This explain the leave policy of the company and procedures for leave", "This explains the rules and regulations to be followed in the company", "This explain the travelling policy of the company" , "This explains the acts of employess regarding the company in social media"]
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DownloadCell
       // cell.titleImage.image = UIImage(named: fileTitle[indexPath.row])
        cell.title.text = fileTitle[indexPath.row]
        cell.titleDescription.text = fileDescription[indexPath.row]
        cell.downoadImage.addTarget(self, action: #selector(downloadStart), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(PdfView(), animated: true)
    }
    var downloadList : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = " Files "
        navigationController?.navigationBar.prefersLargeTitles = true
        downloadList = UITableView()
        downloadList.register(DownloadCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(downloadList)
        view.backgroundColor = .white
        downloadList.delegate = self
       // downloadList.isUserInteractionEnabled = false
        downloadList.dataSource = self
        downloadList.rowHeight = 100
        downloadList.separatorStyle = .none
        downloadList.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        downloadList.backgroundColor = .clear
    }
    func DownlondFromUrl(){
        // Create destination URL
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        print(documentsUrl)
        let destinationFileUrl = documentsUrl.appendingPathComponent("downloadedFile.pdf")
        
        //Create URL to the source file you want to download
        let fileURL = URL(string: "https://www.antennahouse.com/XSLsample/pdf/sample-link_1.pdf")
        
        let session = URLSession(configuration: .default)
        let request = URLRequest(url:fileURL!)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
                
            } else {
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription as Any);
            }
        }
        task.resume()
    }
    @objc func downloadStart(){
        self.showToast(message: "Your File is downloading")
        print("Downloading")
        DownlondFromUrl()
    }
    
}
