//
//  FBHelper.swift
//  beMEMO
//
//  Created by Samuel Dias Fernandes de Oliveira on 19/05/16.
//  Copyright © 2016 samueldfo. All rights reserved.
//


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
                    var pictures:[UIImage] = [UIImage]();
                    let graphData = data.valueForKey("data") as! NSArray;
                    var albums:[AlbumModel] = [AlbumModel]();
                    
                    for obj in graphData{
                        print(obj.description)
                        let pictureURL = obj.valueForKey("picture") as! String
                        let url = NSURL(string: pictureURL)
                        let picData = NSData(contentsOfURL: url!)
                        let img = UIImage(data: picData!)
                        
                        pictures.append(img!)
                    }
                    NSNotificationCenter.defaultCenter().postNotificationName("photoNotification", object: nil, userInfo: nil);
                })
                
            }
        }
        
    }
    
    func fetchCoverPhoto(coverLink: String, completion:(image:UIImage)->()){
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { () -> Void in
            

            let userImageURL = "(self.baseUrl)(coverLink)?type=album&access_token=(self.accessToken!.tokenString)";
            
            let url = NSURL(string: userImageURL);
            
            let imageData = NSData(contentsOfURL: url!);
            
            if let imageDataHas = imageData{
                let image = UIImage(data: imageData!);
                
                completion(image: image!)
            }
            
        })
    }
    
    
    func fetchAlbum(){
        
        //let userImageURL = "(self.baseUrl)/1175201752496503/albums?access_token=1041459045935463|xiPlfCmFBTHZ_f--kX725Wqe6w4";
        
        let graphPath = "1175201752496503/albums";
        let request = FBSDKGraphRequest(graphPath: graphPath, parameters: ["fields": "name, id"], HTTPMethod: "GET")
        request.startWithCompletionHandler { (connection:FBSDKGraphRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
            if let gotError = error{
                
                print(gotError.description);
            
            }
            else{
                
                print(result)
                
                let graphData = result.valueForKey("data") as! NSArray;
                
                var albums:[AlbumModel] = [AlbumModel]();
                
                for obj:AnyObject in graphData{
                    let desc = obj.message;
                    //print(message);
                    let name = obj.valueForKey("name") as! String;
                    //print(name);
                    let id = obj.valueForKey("id") as! String;
                    
                    var cover = "";
                    cover = "(id)/picture";
                    //print(coverLink);
                    
                    let link = "(id)/photos";
                    
                    let model = AlbumModel(name: name, link: link, cover:cover);
                    albums.append(model);
                    
                }
                NSNotificationCenter.defaultCenter().postNotificationName("albumNotification", object: nil, userInfo: ["data":albums]);
            }
        }
    }
    
    
}

