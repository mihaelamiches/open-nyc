//
//  Urls.swift
//  OpenNY
//
//  Created by Mihaela Miches on 4/9/17.
//  Copyright © 2017 me. All rights reserved.
//

import Foundation

public enum OpenDataResource { case permittedEvents, socialBenefits, literacyPrograms, landmarks, serviceRequests, theaters, parks, afterSchool }

let openNYResourceUrl = "https://data.cityofnewyork.us/resource"

extension OpenDataResource{
    var identifiers: [String] {
        switch self {
        case .permittedEvents: return ["8end-qv57"]
        case .socialBenefits: return ["ujkp-2x99"]
        case .literacyPrograms: return ["h2nh-xgvp","trcd-7zc6","h2pf-4vz5", "vmdh-6fvj"]
        case .landmarks: return ["rb9s-d3m8"]
        case .serviceRequests: return ["fhrw-4uyv"]
        case .theaters: return ["2hzz-95k8"]
        case .parks: return ["y6ja-fw4f"]
        case .afterSchool: return ["reni-g9vg"]
        }
    }
    
    var urls: [URL] {
        get {
            return self.identifiers.flatMap{ URL(string: "\(openNYResourceUrl)/\($0).json") }
        }
    }
}
