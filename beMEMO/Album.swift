//
//  Album.swift
//  beMEMO
//
//  Created by Samuel Dias Fernandes de Oliveira on 03/06/16.
//  Copyright © 2016 samueldfo. All rights reserved.
//

import Foundation

struct Album {
    
    
    var id: String?
    var name: String?
    var count: Int?
    var cover: String?
    
    /*
     var cover_photo: String?
     var can_update: Bool
     var count: Int = 0
     var created_time: String? //date string
     var description: String?
     
     var link: String?
     var location: String?
     
     
     var privacy: String?
     var type: AlbumType
     var updated_time: String? //date string
     */
    /*
     Not used for now
     var from: User
     var place: Page
     */
    
    init(id: String?, name: String?, count: Int?, cover: String?) {
        self.id = id
        self.name = name
        self.count = count
        self.cover = cover
    }
    
}
