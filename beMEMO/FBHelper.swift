//
//  FBHelper.swift
//  beMEMO
//
//  Created by Samuel Dias Fernandes de Oliveira on 19/05/16.
//  Copyright © 2016 samueldfo. All rights reserved.
//

// FBHelper.swift
// FBApp
//
// Created by Md. Arifuzzaman Arif on 7/4/14.
// Copyright (c) 2014 Md. Arifuzzaman Arif. All rights reserved.

import Foundation
import FBSDKCoreKit
import FBSDKShareKit


class FBHelper{
    var accessToken: FBSDKAccessToken?
    let baseUrl = "https://graph.facebook.com/v2.6/"
    init(){
        accessToken = FBSDKAccessToken.currentAccessToken()
    }
    
    
    func fetchPhoto(link:String){
        
        let fbRequest = FBSDKGraphRequest(graphPath: link, parameters: nil, HTTPMethod: "GET")
        fbRequest.startWithCompletionHandler { (connection:FBSDKGraphRequestConnection!, data:AnyObject!, error:NSError!) -> Void in
            if let gotError = error{
                print("Error: %@", gotError)
            }
            else{
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { () -> Void in
                    
                    //println(data)
                    var pictures:[UIImage] = [UIImage]()
                    let graphData: NSArray = data.valueForKey("data") as! NSArray
                    var albums:[AlbumModel] = [AlbumModel]()
                    
                    for obj:AnyObject in graphData{
                        //print(obj.description)
                        //print(obj)
                        
                        let pictureURL = obj.valueForKey("picture") as! String
                        let url = NSURL(string: pictureURL)
                        let picData = NSData(contentsOfURL: url!)
                        let img = UIImage(data: picData!)
                        
                        pictures.append(img!)

                    }
                    NSNotificationCenter.defaultCenter().postNotificationName("photoNotification", object: nil, userInfo: nil)
                })
                
            }
        }
        
    }
    
    
    func fetchCoverPhoto(coverLink: String, completion:(image:UIImage)->()){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { () -> Void in
            
            //http://graph.facebook.com/v2.4/10150192451235958/picture?type=thumbnail
            let userImageURL = "(self.baseUrl)(coverLink)?type=album&access_token=(self.accessToken!.tokenString)"
            
            let url = NSURL(string: userImageURL)
            
            let imageData = NSData(contentsOfURL: url!)
            
            if let imageDataHas = imageData{
                let image = UIImage(data: imageData!)
                
                completion(image: image!)
            }
            
        })
    }
    
    
    func fetchAlbum(){
        
        let userImageURL = "(self.baseUrl)1175201752496503/albums?access_token=(self.accessToken!.tokenString)"
        
        let graphPath = "/1175201752496503/albums"
        let request = FBSDKGraphRequest(graphPath: graphPath, parameters: nil, HTTPMethod: "GET")
        request.startWithCompletionHandler { (connection:FBSDKGraphRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
            if let gotError = error{
                print(gotError.description)
            }
            else{
                //print(result)
                let graphData = result.valueForKey("data") as! NSArray
                var albums:[AlbumModel] = [AlbumModel]()
                for obj:AnyObject in graphData{
                    let desc = obj.description
                    //print(desc)
                    let name = obj.valueForKey("name") as! String
                    //print(name)
                    
                    let id = obj.valueForKey("id") as! String
                    //print(id)
                    
                    let cover = "/\(id)/picture"
                    //print(cover)
                    
                    let link = "/\(id)/photos"
                    //print(link)
                    
                    let model = AlbumModel(name: name, link: link, cover:cover)
                    albums.append(model)
                    //print(albums)
                    
                }
                NSNotificationCenter.defaultCenter().postNotificationName("albumNotification", object: nil, userInfo: ["data":albums])
            }
        }
    }
}
