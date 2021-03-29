//
//  ViewController.swift
//  HotelAppTest
//
//  Created by Admin on 3/29/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController , LoginButtonDelegate {
    
    
    @IBOutlet var fbLoginBtnView: UIView!
    @IBOutlet weak var logInLbl: UILabel!
    
    var fbLoginSuccess = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //login button adding to logging view
        let loginButton = FBLoginButton()
        loginButton.center = fbLoginBtnView.center
        fbLoginBtnView.addSubview(loginButton)
        loginButton.delegate = self
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.green
        self.navigationItem.title = "Login"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //updating logged in label
        if isLoggedIn() {
            logInLbl.text = Constants.loggedInMsg
        }else{
            logInLbl.text = Constants.loggedOutMsg
        }
    }
    
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        print("User Logged In")
        logInLbl.text = Constants.loggedInMsg
        
        if ((error) != nil) {
            // Process error
            let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if result!.isCancelled {
            // Handle cancellations
        }
        else {
            fbLoginSuccess = true
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result!.grantedPermissions.contains("email") {
                // Do work
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        logInLbl.text = Constants.loggedOutMsg
    }
    
    @IBAction func loadHotelsBtnAction(_ sender: Any) {
        //checking login session
        if isLoggedIn() {
            performSegue(withIdentifier: "show_home_view", sender: self)
        }else{
            let alert = UIAlertController(title: "Alert", message: Constants.loginErrorMsg, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func isLoggedIn() ->Bool{
        
        //checking login session
        if let token = AccessToken.current,
            !token.isExpired{
            return true;
        }else{
            return false;
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_home_view" ,
            let nextScene = segue.destination as? HomeViewController {
            nextScene.LoggedInStatus = true
        }
    }
    
}

