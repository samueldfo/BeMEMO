//
//  WebViewController.swift
//  beMEMO
//
//  Created by Samuel Dias Fernandes de Oliveira on 10/05/16.
//  Copyright © 2016 samueldfo. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    
    @IBOutlet weak var webView: UIWebView!
    
    var url: NSURL!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.loadRequest(NSURLRequest(URL: url))
        
        //animacao de carregamento
        //activityIndicator.startAnimating()
        //activityIndicator.hidesWhenStopped = true
        
        webView.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- UIWebView Delegate methods
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.stopAnimating()
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
