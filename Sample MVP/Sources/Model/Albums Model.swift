//
//  Albums Model.swift
//  Sample MVP
//
//  Created by Nithin on 2022-06-03.
//

// MARK: Feed

struct Response: Decodable {
    
    let feed: Feed
}

struct Feed: Decodable {
    
    let results: [Album]
}

// MARK: Album

struct Album: Decodable {
    
    let artistName: String
    let name: String
}
