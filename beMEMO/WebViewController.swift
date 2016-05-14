//
//  WebViewController.swift
//  beMEMO
//
//  Created by Samuel Dias Fernandes de Oliveira on 10/05/16.
//  Copyright © 2016 samueldfo. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    
    var webView: UIWebView!
    
    var url: NSURL!
    
    lazy private var activityIndicator : CustomActivityIndicatorView = {
        let image : UIImage = UIImage(named: "loadingicon")!
        return CustomActivityIndicatorView(image: image)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = UIWebView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height-(44+20+44))) //posiciona uiwebview
        webView.loadRequest(NSURLRequest(URL: url)) //configura a url a ser carregada
        webView.delegate = self //delega o controle a uiwebview
        self.view.addSubview(webView) //adiciona a webview
        
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor() //muda cor do botão e texto
        self.navigationController?.navigationBar.topItem?.title = "Contato"
        
        self.view.addSubview(activityIndicator) //adiciona o activityindicator
        activityIndicator.center = CGPoint(x: (view.bounds.width)/2, y: (view.bounds.height)/2-(20+44)) //centraliza o activity indicador
        
        //animacao de carregamento
        activityIndicator.startAnimating()//inicia activity indicator
        //UIApplication.sharedApplication().networkActivityIndicatorVisible = true //inicia activity indicator status bar
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- UIWebView Delegate methods
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.stopAnimating() //para activity indicator
        //UIApplication.sharedApplication().networkActivityIndicatorVisible = false //para activity indicator status bar
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
