//
//  TableVCProjetos.swift
//  beMEMO
//
//  Created by Samuel Dias Fernandes de Oliveira on 19/05/16.
//  Copyright © 2016 samueldfo. All rights reserved.
//

import UIKit
import FBSDKLoginKit


class TableVCProjetos: UIViewController {

    @IBOutlet weak var ProjetosTableView: UITableView!

    
    var graphApi: GraphApi = GraphApi()
    var albums: [Album] = []
    var album: Album?
    var selectedAlbum: Album?
    var albumsIds: [String] = []
    var albumcover: CoverPhoto?
    var albumcovers: [CoverPhoto] = []
    
    
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
        for item in albums {
            albumsIds.append(item.id!)
        }
        //print(albumsIds)
        for albumid in albumsIds {
            //print(albumid)
            graphApi.fetchAlbumCovers(albumid, handler: AlbumCoverHandler)
        }
        
        
        dispatch_async(dispatch_get_main_queue(), {
            self.ProjetosTableView.reloadData()
        })
    }
    
    func AlbumCoverHandler(albumcovers: [CoverPhoto]) {
        self.albumcovers = albumcovers
        //print(albumcovers)
    
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
        
            let data = albums[indexPath.row]
            cell.heading.text = data.name
        
            if (data.cover != ""){
                let coverPhotoURL = NSURL(string: data.cover!)
                let coverPhotoData = NSData(contentsOfURL: coverPhotoURL!)
         
                let image = UIImage(data: coverPhotoData!)
                cell.bkimage.image = image
            }
        
            /*let cover = covers[indexPath.row]
        
            if (cover.source != ""){
                let coverURL = NSURL(string: cover.source!)
                let coverData = NSData(contentsOfURL: coverURL!)
                    
                    let image = UIImage(data: coverData!)
                    cell.bkimage.image = image
            
        }*/
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedAlbum = albums[indexPath.row]
        performSegueWithIdentifier("launchAlbumCollection", sender: self)

    }
    
    

override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    if segue.identifier == "launchAlbumCollection" {
        if let viewController = segue.destinationViewController as? PhotosCollectionViewController {
            viewController.album = selectedAlbum
        }
    }
}
    
    

}

