//
//  Extensions.swift
//  Sample MVP
//
//  Created by Nithin 3 on 04/06/22.
//

import UIKit
import Foundation

private let cache = NSCache<NSString, NSData>()

extension UIImageView {
    
    func downloadImage(url: String, handler: @escaping(Data?, Error?) -> Void){
        let cacheID = NSString(string: url)
        
        if let cachedData = cache.object(forKey: cacheID) {
            handler((cachedData as Data), nil)
        }else{
            if let url = URL(string: url) {
                var request = URLRequest(url: url)
                request.cachePolicy = .returnCacheDataElseLoad
                request.httpMethod = "get"
                URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let _data = data {
                        cache.setObject(_data as NSData, forKey: cacheID)
                        handler(_data, nil)
                    }else{
                        handler(nil, error)
                    }
                }.resume()
            } else {
            }
        }
    }
}
