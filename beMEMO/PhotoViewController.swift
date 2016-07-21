//
//  PhotoViewController.swift
//  beMEMO
//
//  Created by Samuel Dias Fernandes de Oliveira on 20/07/16.
//  Copyright © 2016 samueldfo. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    
    var photo: Photo?
    
    @IBOutlet weak var photoview: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        
        
        photoview.image = UIImage(data: NSData(contentsOfURL: NSURL(string: (photo?.picture)!)!)!)
        
            
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
