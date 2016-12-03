//
//  LoginViewController.swift
//  beMEMO
//
//  Created by Samuel Dias Fernandes de Oliveira on 03/06/16.
//  Copyright © 2016 samueldfo. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var LoginView: UIView!

    @IBAction func contatobutton(sender: AnyObject) {
        performSegueWithIdentifier("contatosegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "contatosegue"){
            let tabVC = segue.destinationViewController as! UITabBarController
            tabVC.selectedIndex = 2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let LVxPosition = LoginView.frame.origin.x
        let LVyPosition = LoginView.frame.origin.y - 320
        let LVheight = LoginView.frame.size.height
        let LVwidth = LoginView.frame.size.width
        
        UIView.animateWithDuration(0.6, animations: {
            
            self.LoginView.frame = CGRectMake(LVxPosition, LVyPosition, LVheight, LVwidth)
            
        })
        
        let appDelegate = UIApplication.sharedApplication().delegate! as! AppDelegate
        
        if (FBSDKAccessToken.currentAccessToken() == nil) {
            print("Not loged in..")
            
            //logintext.text = "Mal podemos esperar para compartilhar com você nossos projetos e inspirações e quem sabe trabalharmos juntos para que o seu evento seja memorável.\n\nPara isso, realize o login no facebook.\n\nNão se preocupe, pois não postaremos nada sem a sua permissão."
            
        } else {
            print("Loged in...")
            
            let initialViewController = self.storyboard!.instantiateViewControllerWithIdentifier("TabbarVC")
            appDelegate.window?.rootViewController = initialViewController
            appDelegate.window?.makeKeyAndVisible()
            
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func facebookLogin (sender: AnyObject){
        
        // Create a reference to a Firebase location
        
        let facebookLogin = FBSDKLoginManager()
        
        print("Logging in")
        
        facebookLogin.logInWithReadPermissions(["public_profile","email"],fromViewController: self, handler:{(facebookResult, facebookError) -> Void in
            if facebookError != nil {
                print("Facebook login failed. Error \(facebookError)")
            } else if facebookResult.isCancelled {
                print("Facebook login was cancelled.")
            } else {
                print("You are in")
                
                let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)

                FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
                            if let error = error {
                                print(error.localizedDescription)
                                return
                            }
                    }
                                self.performSegueWithIdentifier("loginsegue", sender: nil)
            }
        
        });
        
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
