//
//  Albums Model.swift
//  Sample MVP
//
//  Created by Nithin on 2022-06-03.
//

// MARK: Response

struct Response: Decodable {
    
    let feed: Feed
}

// MARK: Feed

struct Feed: Decodable {
    
    let results: [Album]
}

// MARK: Album

struct Album: Decodable {
    
    let artistName: String
    let name: String
    let artworkUrl100: String
    let url: String
}

// MARK: Media Type

enum MediaType: String {
    
    case music
    case podcasts
    case apps
    case books
    case audiobooks = "audio-books"
    
    func description() -> String {
        return self.rawValue
    }
    
    func title() -> String {
        switch self {
        case .music:
            return "🎹 Music"
        case .podcasts:
            return "💡 Podcasts"
        case .apps:
            return "📱 Apps"
        case .books:
            return "📚 Books"
        case .audiobooks:
            return "🎼 Audio books"
        }
    }
    
    func type() -> String {
        switch self {
        case .music:
            return "albums"
        case .podcasts:
            return "podcasts"
        case .apps:
            return "apps"
        case .books:
            return "books"
        case .audiobooks:
            return "audio-books"
        }
    }
    
    func feed() -> String {
        switch self {
        case .music:
            return "most-played"
        case .podcasts:
            return "top"
        case .apps:
            return "top-free"
        case .books:
            return "top-free"
        case .audiobooks:
            return "top"
        }
    }
}
