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
    
    let ALBUMS_PARAMETERS = ["fields": "id, name, count, cover_photo{id}, description, type, picture{url}"]
    
    let PHOTO_PARAMETERS = ["fields": "id, name, created_time, picture, images{source}"]
    
    let COVER_PHOTO_PARAMETERS = ["fields": "height, source, width"]
    
    //cover photo
    func fetchAlbumCovers(coverid: String, completionHandler: ([CoverPhoto] -> Void)) {
        //print(coverid)
        let request =  FBSDKGraphRequest(graphPath: "\(coverid)?fields=images", parameters: COVER_PHOTO_PARAMETERS)
        //print(request)
        request.startWithCompletionHandler({(connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            if error != nil {
                print("\(error.localizedDescription)")
            } else {
                
                completionHandler(self.parseAlbumCovers(result))
            }
        })
    }
    
    func parseAlbumCovers(result: AnyObject!) -> [CoverPhoto] {
        var Albumcovers = [CoverPhoto]()
        //print(result)
        if let albumcoversJson = result as? NSDictionary {
            
            var albumcover = CoverPhoto(
                    height: albumcoversJson["height"] as? Int,
                    width: albumcoversJson["width"] as? Int,
                    source: albumcoversJson["source"] as? String
            )
            Albumcovers.append(albumcover)
            //print(Albumcovers)
        }
        return Albumcovers
    }
    
    
    //albums
    func fetchAlbums(completionHandler: ([Album] -> Void)) {
        let request =  FBSDKGraphRequest(graphPath: "/1175201752496503/albums", parameters: ALBUMS_PARAMETERS)
        request.startWithCompletionHandler({(connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            if error != nil {
                print(error.localizedDescription)
            } else {

                completionHandler(self.parseAlbums(result))
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
                        if let pictureData = picture["data"] as? NSDictionary{
                            if let coverphoto = albumJson["cover_photo"] as? NSDictionary {
                                
                    let album = Album(
                        id: albumJson["id"] as? String,
                        name: albumJson["name"] as? String,
                        count: albumJson["count"] as? Int,
                        picture: pictureData["url"] as? String,
                        description: albumJson["description"] as? String,
                        type: albumJson["type"] as? String,
                        coverid: coverphoto["id"] as? String
                                )
                                albums.append(album)
                                //print(albums)
                            }
                        }
                    }
                }
            }
        }
        return albums
    }
    

    
    //photos
    func fetchPhotos(albumid: String, completionHandler: ([Photo] -> Void)) {
        //print(albumid)
        let request =  FBSDKGraphRequest(graphPath: "\(albumid)/photos", parameters: PHOTO_PARAMETERS)
        //print(request)
        request.startWithCompletionHandler({(connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            if error != nil {
                print("\(error.localizedDescription)")
            } else {
                completionHandler(self.parsePhotos(result))
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