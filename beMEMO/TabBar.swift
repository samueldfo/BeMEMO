//
//  TabBar.swift
//  beMEMO
//
//  Created by Samuel Dias Fernandes de Oliveira on 13/05/16.
//  Copyright © 2016 samueldfo. All rights reserved.
//

import Foundation
import UIKit

class TabBar: UITabBar {
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 44
        
        return sizeThatFits
    }
    
    
}