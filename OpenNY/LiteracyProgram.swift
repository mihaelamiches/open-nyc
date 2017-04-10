//
//  LiteracyProgram.swift
//  OpenNY
//
//  Created by Mihaela Miches on 4/9/17.
//  Copyright © 2017 me. All rights reserved.
//

import CoreLocation

struct LiteracyProgram: Scrappable {
    let siteName: String
    let programType: String
    let location: CLLocationCoordinate2D
    let humanAddress: String
    let agency: String
    let boroughCommunity: String
    let program: String
    let gradeLevelAgeGroup: String
    let contactNumber: String
    
    init?(_ json: Dictionary) {
        self.siteName = json["site_name"] as? String ?? ""
        self.programType = json["program_type"] as? String ?? ""
      
        guard let location = json["location_1"] as? Dictionary else { return nil }
        
        let latitude = Double(location["latitude"] as? String ?? "") ?? 0
        let longitude = Double(location["longitude"] as? String ?? "") ?? 0
        self.location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.humanAddress = location["human_address"] as? String ?? ""
        
        self.agency = json["agency"] as? String ?? ""
        self.boroughCommunity = json["borough_community"] as? String ?? ""
        self.gradeLevelAgeGroup = json["grade_level_age_group"] as? String ?? ""
        self.contactNumber = json["contact_number"] as? String ?? ""
        self.program = json["program"] as? String ?? ""
    }
}
