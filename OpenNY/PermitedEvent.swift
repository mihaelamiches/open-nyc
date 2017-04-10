//
//  Event.swift
//  OpenNY
//
//  Created by Mihaela Miches on 4/9/17.
//  Copyright © 2017 me. All rights reserved.
//

import Foundation

struct PermitedEvent: Scrappable {
    let eventId: String
    let startTime: Date
    let endTime: Date
    let name: String
    let type: String
    let location: String
    let streetSide: String
    
    let policePrecinct: String
    let streetClosure: String
    let streetClosureType: String
    
    let agency: String
    let communityBoard: String
    
    let borough: String
    
    init(_ json: Dictionary) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        self.eventId = json["eventId"] as? String  ?? ""
        
        self.startTime = dateFormatter.date(from: json["start_date_time"] as? String  ?? "") ?? Date.distantPast
        self.endTime = dateFormatter.date(from: json["end_date_time"] as? String  ?? "") ?? Date.distantFuture
        
        self.name = json["event_name"] as? String  ?? ""
        self.streetSide = json["event_street_side"] as? String  ?? ""
        self.streetClosureType = json["street_closure_type"] as? String ?? ""
        self.type = json["event_type"] as? String  ?? ""
        self.location = json["event_location"] as? String  ?? ""
        self.policePrecinct = json["police_precinct"] as? String  ?? ""
        self.streetClosure = json["street_closure_type"] as? String  ?? ""
        self.agency = json["event_agency"] as? String  ?? ""
        self.communityBoard = json["community_board"] as? String  ?? ""
        self.borough = json["event_borough"] as? String  ?? ""
    }
}
