//
//  311Request.swift
//  OpenNY
//
//  Created by Mihaela Miches on 4/9/17.
//  Copyright © 2017 me. All rights reserved.
//

import CoreLocation

struct ServiceRequest: Scrappable {
    let uniqueKey: String
    let complaintType: String
    let description: String

    let incidentLocation: CLLocationCoordinate2D
    let locationType: String
    
    let agency: String
    let agencyName: String
    
    let createdDate: Date
    let closedDate: Date?
    
    let status: String
    let resolution: String
    
    init?(_ json: Dictionary) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        self.createdDate = dateFormatter.date(from: (json["created_date"] as? String) ?? "") ?? Date.distantPast
        self.closedDate = dateFormatter.date(from: (json["closed_date"] as? String) ?? "")        
        self.uniqueKey = json["unique_key"] as? String ?? ""
        
        self.description = json["descriptor"] as? String ?? ""
        self.complaintType = json["complaint_type"] as? String ?? ""
        
        let latitude = json["latidude"] as? Double ?? 0
        let longitude = json["longitude"] as? Double ?? 0
        self.incidentLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.locationType = json["location_type"] as? String ?? ""
        
        self.agency = json["agency"] as? String ?? ""
        self.agencyName = json["agency_name"] as? String ?? ""
 
        
        self.status = json["status"] as? String ?? ""
        self.resolution = json["resolution_description"] as? String ?? ""
    }
}
