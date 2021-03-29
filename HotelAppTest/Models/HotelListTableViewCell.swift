//
//  HotelListTableViewCell.swift
//  HotelAppTest
//
//  Created by Admin on 3/29/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit

class HotelListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hotelImageVoew: UIImageView!
    
    @IBOutlet weak var hotelTitleLabel: UILabel!
    
    @IBOutlet weak var hotelAddressLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //load default image
        let url = URL(string: "https://cf.bstatic.com/xdata/images/hotel/square200/156672332.jpg?k=7d50a5094840159372a74b7e80a202b4355de7c4bbf0784b0e5304c0340c8a54&o=")!
        let data = try? Data(contentsOf: url)
        if data != nil {
            DispatchQueue.main.async{
                self.hotelImageVoew.image = UIImage(data: data!)
            }
        }
        
        //round image view
        self.hotelImageVoew.layer.borderWidth = 1
        self.hotelImageVoew.layer.masksToBounds = false
        self.hotelImageVoew.layer.cornerRadius = self.hotelImageVoew.frame.height/2 //This will change with corners of image and height/2 will make this circle shape
        self.hotelImageVoew.clipsToBounds = true
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
