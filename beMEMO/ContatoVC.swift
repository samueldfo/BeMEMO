//
//  ContatoVC.swift
//  beMEMO
//
//  Created by Samuel Dias Fernandes de Oliveira on 30/04/16.
//  Copyright © 2016 samueldfo. All rights reserved.
//

import UIKit

class ContatoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // MARK: - UI Setup
        
        self.navigationItem.title = "Contato" //titulo
        self.navigationController?.navigationBar.barTintColor = (UIColor(red: 219.0/255.0, green: 200.0/255.0, blue: 168.0/255.0, alpha: 1.0)) //cor do fundo
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black // cor do texto do status bar - branco
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()] // cor do título
        

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
