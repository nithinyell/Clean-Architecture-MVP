//
//  AlbumsPresenter.swift
//  Sample MVP
//
//  Created by Nithin on 2022-06-03.
//

protocol AlbumsPesenterDelegate {

    func albumPresenter(albums: [Album])
}

struct AlbumsPesenter {
    
    var delegate: AlbumsPesenterDelegate?
    
    func present(media type: MediaType) {
        
        let interactor = AlbumInteractor()
        interactor.delegate = Network()
        
        interactor.fetch(media: type) { result in
            
            switch result {
            case .success(let albums):
                delegate?.albumPresenter(albums: albums)
            case .failure(_):
                delegate?.albumPresenter(albums: [Album]())
            }
        }
    }
}
