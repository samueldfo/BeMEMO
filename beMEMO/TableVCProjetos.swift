//
//  TableVCProjetos.swift
//  beMEMO
//
//  Created by Samuel Dias Fernandes de Oliveira on 19/05/16.
//  Copyright © 2016 samueldfo. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class TableVCProjetos: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var ProjetosTableView: UITableView!
    
    let fbHelper = FBHelper()
    var sources:[AlbumModel] = [AlbumModel]()
    var currentAlbumModel = AlbumModel(name: "", link: "", cover: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        //customização do navigation menu
        self.navigationItem.titleView = UIImageView(image:UIImage(named: "beMEMO")) //imagem no titulo
        self.navigationController?.navigationBar.barTintColor = (UIColor(red: 249.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1.0)) //cor do fundo

        
        fbHelper.fetchAlbum()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func selectRowAtIndexPath(indexPath:NSIndexPath!, animated: Bool, scrollPosition: UITableViewScrollPosition){
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("AlbumCell")! as UITableViewCell
        let data = self.sources[indexPath.row]
        cell.textLabel!.text = data.name
        cell.detailTextLabel!.text = data.link
        
        if (data.cover != ""){
            let coverPhotoURL = NSURL(string: data.cover)
            let coverPhotoData = NSData(contentsOfURL: coverPhotoURL!)
            
            cell.imageView!.image = UIImage(data: coverPhotoData!)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sources.count
    }
    
    func executeAlbum(notification:NSNotification){
        let data:[AlbumModel]? = notification.userInfo?["data"] as? [AlbumModel]
        self.sources = data!
        self.ProjetosTableView?.reloadData()
    }
}