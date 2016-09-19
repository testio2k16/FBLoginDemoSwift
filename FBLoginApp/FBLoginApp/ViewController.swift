//
//  ViewController.swift
//  FBLoginApp
//
//  Created by testio2k16 on 9/15/16.
//  Copyright © 2016 testio2k16. All rights reserved.
//

import UIKit

class ViewController: UIViewController,FBSDKLoginButtonDelegate {
    
    let LoginBtn: FBSDKLoginButton = {
        let btn = FBSDKLoginButton()
        btn.readPermissions = ["email","user_friends","read_custom_friendlists"]
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(LoginBtn)
        LoginBtn.center = view.center
        LoginBtn.delegate = self
        
        if let token = FBSDKAccessToken.currentAccessToken(){
            fetchProfile()
        }
        
    }
    
    func fetchProfile(){
        let parameters = ["fields":""]
        FBSDKGraphRequest(graphPath: "me/friends",parameters: parameters).startWithCompletionHandler { (conection, result, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            print(result)
            
            if let email = result["first_name"] as? String {
                print(email)
            }
        }
    }
    
    /*!
     @abstract Sent to the delegate when the button was used to login.
     @param loginButton the sender
     @param result The results of the login
     @param error The error (if any) from the login
     */
     func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!){
        
    }
    
    /*!
     @abstract Sent to the delegate when the button was used to logout.
     @param loginButton The button that was clicked.
     */
     func loginButtonDidLogOut(loginButton: FBSDKLoginButton!){
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
    }
    
    /*!
     @abstract Sent to the delegate when the button is about to login.
     @param loginButton the sender
     @return YES if the login should be allowed to proceed, NO otherwise
     */
      func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

