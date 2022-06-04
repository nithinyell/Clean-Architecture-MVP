//
//  ViewController.swift
//  Sample MVP
//
//  Created by Nithin on 2022-06-03.
//

import UIKit

class AlbumsViewController: UIViewController {

    @IBOutlet weak var FeedTableView: UITableView!
    @IBOutlet weak var changeSelection: UIBarButtonItem!
    var albums: [Album]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        fetch(media: .music)
    }
    
    private func setupTableView() {
        
        FeedTableView.delegate = self
        FeedTableView.dataSource = self
    }
    
    private func fetch(media type: MediaType) {
        
        var albumPresenter = AlbumsPesenter()
        albumPresenter.delegate = self
        albumPresenter.present(media: type)
        self.title = type.title()
    }
    
    func presentAlert() {
        
        let alert = UIAlertController(title: "No Albums Found", message: "Please try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { action in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onClickChangeSelection(_ sender: Any) {
        
        let alert = UIAlertController(title: "Select Media", message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: MediaType.music.title(), style: .default , handler:{  [weak self] (UIAlertAction)in
            self?.fetch(media: .music)
        }))
        
        alert.addAction(UIAlertAction(title: MediaType.podcasts.title(), style: .default , handler:{  [weak self] (UIAlertAction)in
            self?.fetch(media: .podcasts)
        }))
        
        alert.addAction(UIAlertAction(title: MediaType.apps.title(), style: .default , handler:{  [weak self] (UIAlertAction)in
            self?.fetch(media: .apps)
        }))
        
        alert.addAction(UIAlertAction(title: MediaType.books.title(), style: .default, handler:{  [weak self] (UIAlertAction)in
            self?.fetch(media: .books)
        }))
        
        alert.addAction(UIAlertAction(title: MediaType.audiobooks.title(), style: .default, handler:{  [weak self] (UIAlertAction)in
            self?.fetch(media: .audiobooks)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            
        }))
        
        self.present(alert, animated: true, completion: {
            
        })
    }
}

extension AlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let FeedTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.AlbumsController.tableViewCellIdentifier, for: indexPath) as? FeedTableViewCell {

            FeedTableViewCell.album = albums?[indexPath.row]
            
            return FeedTableViewCell
        }
                
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if  let album = albums?[indexPath.row], let url = URL(string: album.url) {
            UIApplication.shared.open(url)
        }
    }
}

extension AlbumsViewController: AlbumsPesenterDelegate {
    
    func albumPresenter(albums: [Album]) {
        
        self.albums = albums
        
        DispatchQueue.main.async { [weak self] in
            
            if albums.isEmpty == true {
                self?.presentAlert()
            } else {
                self?.FeedTableView.reloadData()
            }
        }
    }
}
