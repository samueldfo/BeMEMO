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
    
    let ALBUMS_PARAMETERS = ["fields": "id, name, count, cover_photo, description, type, picture{url}"]
    
    let PHOTO_PARAMETERS = ["fields": "id, name, created_time, picture, images{source}"]
    
    let PHOTO_COVER_PARAMETERS = ["fields": "picture{url}"]
    
    let ALBUM_COVER_PARAMETERS = ["fields": "images{height}, images{source}, images{width}"]
    
    //album covers
    func fetchAlbumCovers(albumid: String, handler: ([ImageAlb] -> Void)) {
        let request =  FBSDKGraphRequest(graphPath: "\(albumid)", parameters: ALBUM_COVER_PARAMETERS)
        print(albumid)
        request.startWithCompletionHandler({(connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            if error != nil {
                print("\(error.localizedDescription)")
            } else {
                handler(self.parseAlbumCovers(result))
            }
        })
    }
    
    func parseAlbumCovers(result: AnyObject!) -> [ImageAlb] {
        var Albumcovers = [ImageAlb]()
        print(result)
        if let albumcoversJson = result as? NSDictionary {
            if let dataJson = albumcoversJson["data"] as? NSArray {
                for albumcoversJson in dataJson {
                    print("\(albumcoversJson)")
                    var albumcover = ImageAlb(
                        height: albumcoversJson["height"] as? Int,
                        source: albumcoversJson["source"] as? String,
                        width: albumcoversJson["width"] as? Int)
                    
                    
                    Albumcovers.append(albumcover)
                    print(Albumcovers)
                }
            }
        }
        return Albumcovers
    }
    
    
    //albums
    func fetchAlbums(handler: ([Album] -> Void)) {
        let request =  FBSDKGraphRequest(graphPath: "/1175201752496503/albums", parameters: ALBUMS_PARAMETERS)
        request.startWithCompletionHandler({(connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            if error != nil {
                print(error.localizedDescription)
            } else {
                handler(self.parseAlbums(result))
            }
        })
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
                        cover: coverData["url"] as? String,
                        description: albumJson["description"] as? String,
                        type: albumJson["type"] as? String
                            )
                        
                    albums.append(album)
                    //print(albums)
                        }
                    }
                }
            }
        }
        return albums
    }
    

    
    //photos
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
                        created_time: photoJson["created_time"] as? String,
                        images: photoJson["images"] as? String)
                    
                    photos.append(photo)
                    //print(photos)
                }
            }
            
        }
        return photos
    }
    
}