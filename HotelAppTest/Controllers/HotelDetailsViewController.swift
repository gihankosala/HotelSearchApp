//
//  HotelDetailsViewController.swift
//  HotelAppTest
//
//  Created by Admin on 3/29/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit

class HotelDetailsViewController: UIViewController {

    @IBOutlet weak var imagePreviewView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var selectedResponce:Datum?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        setupDefaultImage()
        setupHotelDetails()
       
        
    }
    
    func setUpNavigationBar(){
        
        //navigation bar
        //let backButton = UIBarButtonItem(image: UIImage(named: "back icn"), style: .plain, target: self, action: #selector(backButtonAction(_:)))
        //self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "map", style: .done, target: self, action: #selector(addTapped))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.green
        self.navigationItem.title = "Details View"
        
    }
    
    func setupDefaultImage(){
        //load default image
        let url = URL(string: "https://cf.bstatic.com/xdata/images/hotel/square200/156672332.jpg?k=7d50a5094840159372a74b7e80a202b4355de7c4bbf0784b0e5304c0340c8a54&o=")!
        let data = try? Data(contentsOf: url)
        if data != nil {
            DispatchQueue.main.async{
                self.imagePreviewView.image = UIImage(data: data!)
            }
        }
    }
    
    func setupHotelDetails(){
        
        //load  image
        let url = URL(string: (selectedResponce?.image.medium)!)!
        let data = try? Data(contentsOf: url)
        if data != nil {
            DispatchQueue.main.async{
                self.imagePreviewView.image = UIImage(data: data!)
            }
        }
        //load other labels
        titleLabel.text = selectedResponce?.title
        
        descriptionLabel.text = selectedResponce?.datumDescription
        
        
    }
    
    @objc func addTapped(sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "show_map_view", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "show_map_view" ,
               let nextScene = segue.destination as? HotelLocationViewController {
               nextScene.selectedResponce = self.selectedResponce
           }
       }
    
    

}
