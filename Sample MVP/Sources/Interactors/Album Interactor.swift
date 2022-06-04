//
//  Album Interactor.swift
//  Sample MVP
//
//  Created by Nithin on 2022-06-03.
//

import Foundation

enum ParserError: Error {
    
    case parseError
}

class AlbumInteractor {
    
    var delegate: NetworkDelegate?
    
    func fetchAlbums(completion: @escaping (Result<[Album], AlbumError>) -> Void) {
        
        delegate?.callApi(url: Constants.ProdAPI, completion: { result in
            
            switch result {
                
            case .success(let data):
                
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(response.feed.results))
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(_):
                
                completion(.failure(.failedToParse))
            }
        })
    }
}
