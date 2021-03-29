//
//  HotelResponse.swift
//  HotelAppTest
//
//  Created by Admin on 3/29/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

class HotelResponse: Codable {
    let status: Int
    let data: [Datum]

    init(status: Int, data: [Datum]) {
        self.status = status
        self.data = data
    }
}

class Datum: Codable {
    let id: Int
    let title, datumDescription, address, postcode: String
    let phoneNumber, latitude, longitude: String
    let image: Image

    enum CodingKeys: String, CodingKey {
        case id, title
        case datumDescription = "description"
        case address, postcode, phoneNumber, latitude, longitude, image
    }

    init(id: Int, title: String, datumDescription: String, address: String, postcode: String, phoneNumber: String, latitude: String, longitude: String, image: Image) {
        self.id = id
        self.title = title
        self.datumDescription = datumDescription
        self.address = address
        self.postcode = postcode
        self.phoneNumber = phoneNumber
        self.latitude = latitude
        self.longitude = longitude
        self.image = image
    }
}

// MARK: - Image
class Image: Codable {
    let small, medium, large: String

    init(small: String, medium: String, large: String) {
        self.small = small
        self.medium = medium
        self.large = large
    }
}
