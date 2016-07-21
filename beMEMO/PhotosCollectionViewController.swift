//
//  PhotosCollectionViewController.swift
//  beMEMO
//
//  Created by Samuel Dias Fernandes de Oliveira on 14/07/16.
//  Copyright © 2016 samueldfo. All rights reserved.
//

import UIKit

private let reuseIdentifier = "collectcell"

class PhotosCollectionViewController: UICollectionViewController {

    var photos: [Photo] = []
    var album: Album?
    var selectedPhoto: Photo?
    var photo: Photo?
    var graphApi: GraphApi = GraphApi()
    var photoCache: ImageCache
    
    required init?(coder aDecoder: NSCoder) {
        photoCache = (UIApplication.sharedApplication().delegate as! AppDelegate).photoCache
        super.init(coder: aDecoder)
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        photoCache = (UIApplication.sharedApplication().delegate as! AppDelegate).photoCache
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        self.collectionView!.backgroundColor = UIColor.whiteColor()

        if let currentAlbum = album {
            if let albumId = currentAlbum.id {
                print(albumId)
                graphApi.fetchPhotos(albumId, handler: photosHandler)
            }
        }
        
        // Register cell classes
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    
    func photosHandler(photos: [Photo]) {
        self.photos = photos
        print("\(self.photos.count)")
        dispatch_async(dispatch_get_main_queue(), {
            self.collectionView?.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotosCollectionViewCell
        
        // Configure the cell
        
            let photo = photos[indexPath.row]
            
            if let photoUrl = photo.picture {
                if let image = photoCache.get(photoUrl) {
                    print("load from cache")
                    cell.photoview.image = image
                } else {
                    print("load from network")
                    let imageDownloader = ImageDownloader()
                    imageDownloader.loadImage(photoUrl, completeHandler: {(image: UIImage) -> Void in
                        self.photoCache.put(photoUrl, image: image)
                        dispatch_async(dispatch_get_main_queue(), {
                            if let cellToUpdate = collectionView.cellForItemAtIndexPath(indexPath) as? PhotosCollectionViewCell  {
                                cellToUpdate.photoview.image = image
                            }
                        })
                        }, errorHandler: nil)
                }
            }
            return cell
        }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedPhoto = photos[indexPath.row]
        performSegueWithIdentifier("showPhoto", sender: self)
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPhoto" {
           if let viewcontroller = segue.destinationViewController as? PhotoViewController {
                viewcontroller.photo = selectedPhoto
            //print(selectedPhoto!.picture)
            }
        }
    }
    
  
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
