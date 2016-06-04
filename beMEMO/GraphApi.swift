//
//  GraphApi.swift
//  beMEMO
//
//  Created by Samuel Dias Fernandes de Oliveira on 03/06/16.
//  Copyright © 2016 samueldfo. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKShareKit

class GraphApi {
    
    let ALBUMS_PARAMETERS = ["fields": "id, name, count, cover_photo, created_time, description, location, type, from, picture{url}"]
    
    let PHOTO_PARAMETERS = ["fields": "id, name, created_time, picture, images"]
    
    let PHOTO_COVER_PARAMETERS = ["fields": "picture{url}"]
    
    //me profile picture
    func fetchMeProfilePicture(handler: (String -> Void)) {
        
        let request = FBSDKGraphRequest(graphPath: "/1175201752496503/albums", parameters: PHOTO_COVER_PARAMETERS)
        
        request.startWithCompletionHandler({(connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            if error != nil {
                print(error.localizedDescription)
            } else {
                //parse albums
                //handler(self.parseAlbums(result))
                print("\(result)")
                if let albumcover = result as? NSDictionary {
                    if let picture = albumcover["picture"] as? NSDictionary {
                        if let pictureData = picture["data"] as? NSDictionary {
                            if let pictureUrl = pictureData["url"] as? String {
                                handler(pictureUrl)
                            }
                        }
                    }
                    
                }
            }
        })
        
    }
    
    //albums
    func fetchAlbums(handler: ([Album] -> Void)) {
        //var albums: [Album] = []
        let request =  FBSDKGraphRequest(graphPath: "/1175201752496503/albums", parameters: ALBUMS_PARAMETERS)
        
        request.startWithCompletionHandler({(connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            if error != nil {
                print(error.localizedDescription)
            } else {
                //parse albums
                handler(self.parseAlbums(result))
            }
        })
        // handler(albums)
    }
    
    func parseAlbums(result: AnyObject!) -> [Album] {
        var albums = [Album]()
        //print(result)
        if let albumsJson = result as? NSDictionary {
            if let dataJson = albumsJson["data"] as? NSArray {
                for albumJson in dataJson {
                    if let picture = albumJson["picture"] as? NSDictionary {
                        if let coverData = picture["data"] as? NSDictionary{
                    
                    let album = Album(
                        id: albumJson["id"] as? String,
                        name: albumJson["name"] as? String,
                        count: albumJson["count"] as? Int,
                        cover: coverData["url"] as? String)
                        
                    albums.append(album)
                    print(albums)
                        }
                    }
                }
            }
            
            if let paging = albumsJson["paging"] as? NSDictionary {
                
            }
        }
        return albums
    }
    
    func createAlbum() -> Bool {
        
        return true
    }
    
    func fetchPhotos(albumid: String, handler: ([Photo] -> Void)) {
        let request =  FBSDKGraphRequest(graphPath: "\(albumid)/photos", parameters: PHOTO_PARAMETERS)
        request.startWithCompletionHandler({(connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            if error != nil {
                print("\(error.localizedDescription)")
            } else {
                handler(self.parsePhotos(result))
            }
            
        })
    }
    
    func parsePhotos(result: AnyObject!) -> [Photo] {
        var photos = [Photo]()
        if let photosJson = result as? NSDictionary {
            if let dataJson = photosJson["data"] as? NSArray {
                for photoJson in dataJson {
                    //print("\(photoJson)")
                    var photo = Photo(
                        id: photoJson["id"] as? String,
                        name: photoJson["name"] as? String,
                        picture: photoJson["picture"] as? String,
                        created_time: photoJson["created_time"] as? String)
                    photos.append(photo)
                }
            }
            
            if let paging = photosJson["paging"] as? NSDictionary {
                
            }
        }
        return photos
    }
    
    
}