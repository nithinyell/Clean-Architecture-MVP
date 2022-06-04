//
//  ViewController.swift
//  Sample MVP
//
//  Created by Nithin on 2022-06-03.
//

import UIKit

class AlbumsViewController: UIViewController {

    @IBOutlet weak var albumsTableView: UITableView!
    var albums: [Album]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        fetchAlbums()
    }
    
    private func setupTableView() {
        
        albumsTableView.delegate = self
        albumsTableView.dataSource = self
    }
    
    private func fetchAlbums() {
        
        let albumPresenter = AlbumsPesenter()
        albumPresenter.presentAlbums { [weak self] albums in
            
            defer {
                DispatchQueue.main.async {
                   self?.albumsTableView.reloadData()
               }
            }
            
            self?.albums = albums
        }
    }
}

extension AlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.AlbumsController.tableViewCellIdentifier, for: indexPath)
        let album = albums?[indexPath.row]
        
        cell.textLabel?.text = album?.name
        cell.detailTextLabel?.text = "By: \(String(describing: album?.artistName ?? ""))"
        
        return cell
    }
}

