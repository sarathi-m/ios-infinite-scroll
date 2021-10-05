//
//  RequestManager.swift
//  Feeds
//
//  Created by Sarathi M on 9/14/21.
//

import Foundation

class RequestManager {
    func downloadData(url: String, dataHandler: @escaping (Feed)->()) {
        print(url)
        guard let url = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                print(data)
                let feedObj = try JSONDecoder().decode(Feed.self, from: data)
                dataHandler(feedObj)
            }
            catch let err {
                print(err)
            }
            
        }.resume()
    }
}
