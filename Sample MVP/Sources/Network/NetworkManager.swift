//
//  NetworkManager.swift
//  Sample MVP
//
//  Created by Nithin on 2022-06-03.
//

import Foundation

enum AlbumError: Error {
    
    case badURL
    case badResponse
    case failedToParse
}

protocol NetworkDelegate {
    
    func callApi(url: String, completion: @escaping (Result<Data, AlbumError>) -> Void)
}

struct Network: NetworkDelegate {
    
    func callApi(url: String, completion: @escaping (Result<Data, AlbumError>) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil {
                
                completion(.failure(.badResponse))
                return
            }
            
            if let responseData = data {
                
                completion(.success(responseData))
            }
            
        }.resume()
    }
}

