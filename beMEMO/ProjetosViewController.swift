//
//  ProjetosViewController.swift
//  beMEMO
//
//  Created by Samuel Dias Fernandes de Oliveira on 19/05/16.
//  Copyright © 2016 samueldfo. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ProjetosViewController: UIViewController {

    @IBOutlet weak var ProjetosTableView: UITableView!

    
    var graphApi: GraphApi = GraphApi()
    var albums: [Album] = []
    var selectedAlbum: Album?
    var coverIds: [String] = []
    var Albumcovers: [CoverPhoto] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ProjetosTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        //customização do navigation menu
        self.navigationItem.titleView = UIImageView(image:UIImage(named: "beMEMO")) //imagem no titulo
        self.navigationController?.navigationBar.barTintColor = (UIColor(red: 249.0/255.0, green: 246.0/255.0, blue: 235.0/255.0, alpha: 1.0)) //cor do fundo
        
        
        if (FBSDKAccessToken.currentAccessToken() == nil) {
            print("Not loged in..")
            
            performSegueWithIdentifier("notlogsegue", sender: self)
            
            
        } else {
            print("Loged in...")
        
            graphApi.fetchAlbums(albumsHandler)
            
            
        }
    }

    func albumsHandler(albums: [Album]) {
        self.albums = albums
        //print(albums)
        
        ids(albums)
        
        
        dispatch_async(dispatch_get_main_queue(), {
            self.ProjetosTableView.reloadData()
        })
    }
    func ids(albums: [Album]) -> [CoverPhoto] {
        
        for item in albums {
            coverIds.append(item.coverid!)
        }
        for coverid in coverIds {
            graphApi.fetchAlbumCovers(coverid, completionHandler: AlbumCoverHandler)
        }
        return Albumcovers
    }
    
    func AlbumCoverHandler(Albumcovers: [CoverPhoto]) {
        self.Albumcovers = Albumcovers
        
        dispatch_async(dispatch_get_main_queue(), {
            self.ProjetosTableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AlbumCell", forIndexPath: indexPath) as! SubTableViewCell
        // Configure the cell...
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        let data = albums[indexPath.row]

        //print(Albumcovers)
        
        //let datacover = Albumcovers[indexPath.row]
        
        cell.heading.text = data.name
        
            if (data.picture != ""){
                let coverPhotoURL = NSURL(string: data.picture!)
                let coverPhotoData = NSData(contentsOfURL: coverPhotoURL!)
         
                let image = UIImage(data: coverPhotoData!)
                cell.bkimage.image = image
            }
        
        return cell
        
            /*let cover = covers[indexPath.row]
        
            if (cover.source != ""){
                let coverURL = NSURL(string: cover.source!)
                let coverData = NSData(contentsOfURL: coverURL!)
                    
                    let image = UIImage(data: coverData!)
                    cell.bkimage.image = image
        }*/
        
    }
 
    //função que faz a transição da segue "launchAlbumCollection ao selecionar item da tabela
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedAlbum = albums[indexPath.row]
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier("launchAlbumCollection", sender: self)
    }
    
    
    //funçao que verifica a segue utilizada e a próxima view e passa informação do objeto selecionado "album" para a próxima view controller
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "launchAlbumCollection" {
        if let viewController = segue.destinationViewController as? PhotosCollectionViewController {
            viewController.album = selectedAlbum
            
            let backItem = UIBarButtonItem()
            backItem.title = "Voltar"
            navigationItem.backBarButtonItem = backItem
            
        }
    }
}
    
    

}

