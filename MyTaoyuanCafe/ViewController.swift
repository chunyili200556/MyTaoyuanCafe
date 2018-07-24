//
//  ViewController.swift
//  MyTaoyuanCafe
//
//  Created by 黎峻亦 on 2018/7/7.
//  Copyright © 2018年 黎峻亦. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var cafeInfo = [CafeInfo]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadCafeInfo()
    }
    
    private func downloadCafeInfo(){
    
        let urlString = "https://cafenomad.tw/api/v1.2/cafes/taoyuan"
        guard let url = URL(string: urlString) else{
            assertionFailure("Invalid URL String")
            return
        }
        CafeDownload(targetURL: url).download { (error, cafes) in
            if let error = error {
                print("download Cafe info fail : \(error)")
                return
            }
            guard let cafes = cafes else{
                assertionFailure("Invalid Cafe Info")
                return
            }
            self.cafeInfo = cafes
            self.tableView.reloadData()
        }
    }
}

extension ViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cafeInfo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cafe = cafeInfo[indexPath.row]
        cell.textLabel?.text = cafe.name
        let averageScore = (cafe.cheap + cafe.music + cafe.quiet + cafe.wifi + cafe.seat) / 5
        cell.detailTextLabel?.text = "平均分數為： \(averageScore) 分"
        return cell
    }
}











