//
//  CafeDownloader.swift
//  MyTaoyuanCafe
//
//  Created by 黎峻亦 on 2018/7/7.
//  Copyright © 2018年 黎峻亦. All rights reserved.
//

import Foundation

struct CafeInfo : Codable{
    var name : String
    var wifi : Double
    var seat : Double
    var quiet : Double
    var tasty : Double
    var cheap : Double
    var music : Double
    var url : String
    var address : String
    var latitude : String
    var longitude : String
    var limited_time : String
    var socket : String
    var open_time : String
}

typealias DownloadHandler = (Error?,[CafeInfo]?) -> Void

class CafeDownload{
    let targetURL : URL
    init(targetURL : URL) {
        self.targetURL = targetURL
    }
    
    func download(doneHandler : @escaping DownloadHandler){
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: targetURL) { (data, response, error) in
            if let error = error{
                print("Download Fail:\(error)")
                DispatchQueue.main.async {
                    doneHandler(error,nil)
                }
                return
            }
            guard let data = data else{
                let error = NSError(domain: "Data is nil", code: -1, userInfo: nil)
                DispatchQueue.main.async {
                    doneHandler(error,nil)
                }
                return
            }
            let decoder = JSONDecoder()
            do{
                let results = try decoder.decode([CafeInfo].self, from: data)
//                print(results.first!)
                DispatchQueue.main.async {
                    doneHandler(nil,results)
                }
            }catch{
                DispatchQueue.main.async {
                    doneHandler(error,nil)
                }
            }
        }
        task.resume()
    } 
}



