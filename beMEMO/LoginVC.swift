//
//  LoginVC.swift
//  beMEMO
//
//  Created by Samuel Dias Fernandes de Oliveira on 03/06/16.
//  Copyright © 2016 samueldfo. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class LoginVC: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.sharedApplication().delegate! as! AppDelegate
        
        
        if (FBSDKAccessToken.currentAccessToken() == nil) {
            print("Not loged in..")
            
            
        } else {
            print("Loged in...")
            
            var initialViewController = self.storyboard!.instantiateViewControllerWithIdentifier("TabbarVC") as! UIViewController
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
