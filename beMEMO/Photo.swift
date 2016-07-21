//
//  Photo.swift
//  beMEMO
//
//  Created by Samuel Dias Fernandes de Oliveira on 03/06/16.
//  Copyright © 2016 samueldfo. All rights reserved.
//

import Foundation

struct Photo {

    
    var id: String?
    var name: String?
    var picture: String?
    var created_time: String?
    var images: String?
    init(id: String?, name: String?, picture: String?, created_time: String?, images: String?) {
        self.id = id
        self.name = name
        self.picture = picture
        self.created_time = created_time
        self.images = images
    }
}
