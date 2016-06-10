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
    var selectedAlbum: Album?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        //print("\(self.albums)")
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
        // #warning Incomplete implementation, return the number of rows
        return albums.count
    }
    
    func selectRowAtIndexPath(indexPath:NSIndexPath!, animated: Bool, scrollPosition: UITableViewScrollPosition){
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AlbumCell", forIndexPath: indexPath)
        // Configure the cell...
        
            let data = albums[indexPath.row]
            cell.textLabel!.text = data.name
            
        if (data.cover != ""){
         let coverPhotoURL = NSURL(string: data.cover!)
         let coverPhotoData = NSData(contentsOfURL: coverPhotoURL!)
         
         cell.imageView!.image = UIImage(data: coverPhotoData!)
        }
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        selectedAlbum = albums[indexPath.row]
        performSegueWithIdentifier("launchAlbumCollection", sender: self)
    }
    
    
}
