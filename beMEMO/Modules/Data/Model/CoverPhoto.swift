//
//  CoverPhoto.swift
//  beMEMO
//
//  Created by Samuel Dias Fernandes de Oliveira on 22/07/16.
//  Copyright © 2016 samueldfo. All rights reserved.
//

import Foundation

struct CoverPhoto {
    
    var height: Int?
    var width: Int?
    var source: String?
    
    init(height: Int?, width: Int?, source: String?) {
        self.height = height
        self.width = width
        self.source = source
    }
}
