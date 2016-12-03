//
//  Contato.swift
//  beMEMO
//
//  Created by Samuel Dias Fernandes de Oliveira on 09/05/16.
//  Copyright © 2016 samueldfo. All rights reserved.
//


import UIKit

struct Contato {
    
    var name:String
    var imageName:String
    var image: UIImage {
        get {
            return UIImage(named: imageName)!
        }
    }

}