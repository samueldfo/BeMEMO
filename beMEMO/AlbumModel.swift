//
//  AlbumInfo.swift
//  beMEMO
//
//  Created by Samuel Dias Fernandes de Oliveira on 19/05/16.
//  Copyright © 2016 samueldfo. All rights reserved.
//

import Foundation

class AlbumModel{
    var name = ""
    var link = ""
    var cover = ""
    init(name:String, link:String, cover:String){
        self.name = name
        self.link = link
        self.cover = cover
    }
}