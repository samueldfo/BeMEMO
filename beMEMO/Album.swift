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
    var description: String?
    var type: String?
    
    init(id: String?, name: String?, count: Int?, cover: String?, description: String?, type: String?) {
        self.id = id
        self.name = name
        self.count = count
        self.cover = cover
        self.description = description
        self.type = type
    }
    
}
