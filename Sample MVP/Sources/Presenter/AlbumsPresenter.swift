//
//  AlbumsPresenter.swift
//  Sample MVP
//
//  Created by Nithin on 2022-06-03.
//

struct AlbumsPesenter {
    
    func presentAlbums(completion: @escaping ([Album]) -> Void) {
        
        let interactor = AlbumInteractor()
        interactor.delegate = Network()
        
        interactor.fetchAlbums { result in
            
            switch result {
            case .success(let albums):
                completion(albums)
            case .failure(_):
                completion([Album]())
            }
        }
    }
}
