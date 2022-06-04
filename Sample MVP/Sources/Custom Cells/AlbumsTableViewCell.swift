//
//  AlbumsTableViewCell.swift
//  Sample MVP
//
//  Created by Nithin 3 on 04/06/22.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    var album: Album? {
        didSet {
            setupCell()
        }
    }
    
    lazy var albumImageView: UIImageView = {
        
        let albumImageView = UIImageView()
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        return albumImageView
    }()
    
    lazy var albumTitle: UILabel = {
        
        let albumTitle = UILabel()
        albumTitle.numberOfLines = 0
        albumTitle.translatesAutoresizingMaskIntoConstraints = false
        return albumTitle
    }()
    
    lazy var albumArtist: UILabel = {
        
        let albumArtist = UILabel()
        albumArtist.numberOfLines = 0
        albumArtist.translatesAutoresizingMaskIntoConstraints = false
        return albumArtist
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    private func setupCell() {
        
        self.addSubview(albumImageView)
        self.addSubview(albumTitle)
        self.addSubview(albumArtist)
        
        NSLayoutConstraint.activate([
            albumImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            albumImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            albumImageView.heightAnchor.constraint(equalToConstant: 125),
            albumImageView.widthAnchor.constraint(equalToConstant: 125),
            
            albumTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            albumTitle.leadingAnchor.constraint(equalTo: self.albumImageView.trailingAnchor, constant: 10),
            albumTitle.heightAnchor.constraint(equalToConstant: 95),
            albumTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),

            albumArtist.topAnchor.constraint(equalTo: albumTitle.bottomAnchor, constant: 10),
            albumArtist.leadingAnchor.constraint(equalTo: albumTitle.leadingAnchor),
            albumArtist.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            albumArtist.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            ])
        
        dataBind()
    }
    
    private func dataBind() {
        
        guard let album = album else { return }
        
        albumTitle.text = album.name
        albumArtist.text = "By: " + album.artistName
        
        albumImageView.downloadImage(url: album.artworkUrl100) { data, error in
            
            guard let data = data else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.albumImageView.image = UIImage(data: data)
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
