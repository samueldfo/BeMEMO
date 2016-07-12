//
//  Image.swift
//  beMEMO
//
//  Created by Samuel Dias Fernandes de Oliveira on 28/06/16.
//  Copyright © 2016 samueldfo. All rights reserved.
//

import Foundation

struct Image {
    
    
    var height: Int?
    var source: String?
    var width: Int?
    
    init(height: Int?, source: String?, width: Int?) {
        self.height = height
        self.source = source
        self.width = width
    }
}
