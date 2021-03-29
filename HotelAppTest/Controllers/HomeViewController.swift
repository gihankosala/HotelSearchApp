//
//  HomeViewController.swift
//  HotelAppTest
//
//  Created by Admin on 3/29/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import ReachabilitySwift

class HomeViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
   
   
    var LoggedInStatus:Bool = false;
    var networkServices = NetworkServices()
    var responseObject:HotelResponse?
    var selectedResponce:Datum?
    let connected: Bool = Reachability.init()!.isReachable
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var LogoutBtn: UIButton!
    
    @IBOutlet weak var hotelListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setupLogoutBtnDesign()
        setupUserData()
        getHotelData()
    }
    
    func setUpNavigationBar(){
        
        //navigation bar
        //let backButton = UIBarButtonItem(image: UIImage(named: "back icn"), style: .plain, target: self, action: #selector(backButtonAction(_:)))
        //self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.green
        self.navigationItem.title = "List View"
        
    }
    
    func setupLogoutBtnDesign(){
        //adding design to logout button
        LogoutBtn.backgroundColor = .clear
        LogoutBtn.layer.cornerRadius = 5
        LogoutBtn.layer.borderWidth = 1
        LogoutBtn.layer.borderColor =  UIColor(red: 0/255, green: 102/255, blue: 51/255, alpha: 1.0).cgColor
        LogoutBtn.backgroundColor =  UIColor(red: 0/255, green: 102/255, blue: 51/255, alpha: 1.0)
    }
    
    func setupUserData(){
      
        if connected{
        
        let requestedFields = "email, first_name, last_name"
        //call rgaph request
        GraphRequest.init(graphPath: "me", parameters: ["fields":requestedFields]).start { (connection, result, error) -> Void in
          
            //checking and loading user sensitive data
            let info = result as! [String : AnyObject]
            if info["first_name"] as? String != nil && info["last_name"] as? String != nil{
                self.userNameLabel.text = (info["first_name"] as! String) + " " + (info["last_name"] as! String)
            }else{
                self.popupAlert(message: Constants.fnameNotFound, title: "Alert")
            }
            
            if info["email"] as? String != nil{
                self.userEmailLabel.text = (info["email"] as! String)
            }else{
                self.popupAlert(message: Constants.emailNotFound, title: "Alert")
                self.userEmailLabel.text = ""
            }
            
        }
        }else{
            self.popupAlert(message: Constants.noInternet, title: "Alert")
        }
        
    }
    
    @IBAction func logOutBtnAction(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logOut()
        navigationController?.popViewController(animated: true)
        
    }
    
    
    func popupAlert(message: String, title: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
           
        let oK = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
               UIAlertAction in
               //NSLog("Ok Action Invoked")
               // view.navigationController?.popViewController(animated: true)
               //view.viewDidLoad()
           }
           
           // Add the actions
           alert.addAction(oK)
           
           //Change button text color
           //alert.view.tintColor = Constants.ColourCodes.orangeColor
           self.present(alert, animated: true, completion:nil)
           
       }
    
    func getHotelData(){
       
        if connected {
            
            //calling hotel results api
            
            networkServices.getRequestNetworkCallWithCodable(url: Constants.baseUrl, headers: ["Content-Type" : "application/json" ,"Authorization": "No \("")"], completionHandler: { response,error in
                
                do {
                    if response != nil {
                        let decoder = JSONDecoder()
                        self.responseObject = try decoder.decode(HotelResponse.self, from: response! )
                        print(self.responseObject?.status)
                        DispatchQueue.main.async {
                            self.hotelListTableView.reloadData()
                        }
                    }else{
                        self.networkServices.ShowFailiureAlert(title: "Alert", message: Constants.someErrorOccured, in: self)
                        
                    }
                } catch let error {
                    print(error)

                }
            })
            
            
        }else{
            popupAlert(message: Constants.noInternet, title: "OOps")
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if responseObject != nil{
            return (responseObject?.data.count)!
        }else{
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:HotelListTableViewCell = (self.hotelListTableView.dequeueReusableCell(withIdentifier: "hotel_list_cell_identifier") as! HotelListTableViewCell?)!
        
        let datum = responseObject?.data[indexPath.row]
        
        cell.hotelTitleLabel.text = datum?.title
        
        cell.hotelAddressLabel.text = datum?.address
        
        print(datum?.image.small)
        
        let url = URL(string: (datum?.image.small)!)! // this images not loading with server isshue.
        let data = try? Data(contentsOf: url)
        if data != nil {
            DispatchQueue.main.async{
                cell.hotelImageVoew.image = UIImage(data: data!)
            }
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 115
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let datum = responseObject?.data[indexPath.row]
        
        if (datum != nil){
            selectedResponce = datum
            performSegue(withIdentifier: "show_detail_view", sender: self)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_detail_view" ,
            let nextScene = segue.destination as? HotelDetailsViewController {
            nextScene.selectedResponce = self.selectedResponce
        }
    }
    
    
    
    
    
   

}
