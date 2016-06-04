//
//  AlbumList.swift
//  beMEMO
//
//  Created by Samuel Dias Fernandes de Oliveira on 03/06/16.
//  Copyright © 2016 samueldfo. All rights reserved.
//

import Foundation

struct AlbumList {
    var albums: [Album]
    
    init() {
        albums = []
    }
    
    init(albums: [Album]) {
        self.albums = albums
    }
}