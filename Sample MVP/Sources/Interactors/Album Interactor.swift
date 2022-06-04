//
//  Album Interactor.swift
//  Sample MVP
//
//  Created by Nithin on 2022-06-03.
//

import Foundation

class AlbumInteractor {
    
    var delegate: NetworkDelegate?
    
    func fetch(media type: MediaType, completion: @escaping (Result<[Album], AlbumError>) -> Void) {
        
        let endPoint = "\(type.rawValue)/\(type.feed())/100/\(type.type()).json"
        
        delegate?.callApi(url: Constants.BASEURL + endPoint, completion: { result in
            
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
