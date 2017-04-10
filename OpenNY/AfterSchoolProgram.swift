//
//  AfterSchoolProgram.swift
//  OpenNY
//
//  Created by Mihaela Miches on 4/10/17.
//  Copyright © 2017 me. All rights reserved.
//

import CoreLocation

struct AfterSchoolProgram: Scrappable {
    let id: String
    let academics: Bool
    
    let agency: String
    let agencyContact: String
    let address: String
    
    let siteName: String
    let siteAddress: String
    let location: CLLocationCoordinate2D
    
    let enrollment: Double
    let estimatedEnrollment: Double
    
    let name: String
    let programType: String
    
    let weeklyHours: String
    let weekends: Bool
    let evenings: Bool
    let summer: Bool
    let elementary: Bool
    let sportsPhy: Bool
    
    
    init?(_ json: Dictionary) {
        self.id = json["id"] as? String ?? ""
        self.academics = (json["academics"] as? String ?? "").boolValue
        self.agency = json["agency_nam"] as? String ?? ""
        self.agencyContact = json["agency_tel"] as? String ?? ""
        self.address = "\(json["setting"] as? String ?? "") \(json["address1"] as? String ?? "") \(json["address2"] as? String ?? "")"
        
        self.siteName = json["site_name"] as? String ?? ""
        self.siteAddress = "\(json["site_build"] as? String ?? "") \(json["site_stree"] as? String ?? "") \(json["site_borou"] as? String ?? "") \(json["site_zip"] as? String ?? "")"
        
        guard let coordinates = (json["the_geom"] as? Dictionary ?? [:])["coordinates"] as? [Double]
            else { return nil }
        self.location = CLLocationCoordinate2D(latitude: coordinates[0], longitude: coordinates[1])

        self.enrollment = (json["enrollment"] as? String ?? "").doubleValue
        self.estimatedEnrollment = (json["estimated_"] as? String ?? "").doubleValue
        self.name = json["name"] as? String ?? ""
        self.programType = json["program_ty"] as? String ?? ""
        self.weeklyHours = json["weekly_hou"] as? String ?? ""
        self.weekends = (json["weekends"] as? String ?? "").boolValue
        self.evenings = (json["evenings"] as? String ?? "").boolValue
        self.summer = (json["summer"] as? String ?? "").boolValue
        self.elementary = (json["elementary"] as? String ?? "").boolValue
        self.sportsPhy = (json["sports_phy"] as? String ?? "").boolValue
    }
}
