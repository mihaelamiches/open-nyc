//
//  BenefitViewController.swift
//  OpenNY
//
//  Created by Mihaela Miches on 3/26/17.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit

class BenefitViewController: UIViewController {
    @IBOutlet weak var detailTextView: UITextView!
    
    var benefit: SocialBenefit? {
        didSet {
            title = benefit?.programName ?? ""
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let benefit = benefit else { return }
        
        detailTextView.tintColor = UINavigationBar.appearance().tintColor
        
        var htmlString = benefit.programDescription
        htmlString += "<br/><br/>"
        htmlString += benefit.howToApplySummary
        htmlString += "<br/><br/>"
        htmlString += "<b>\(benefit.requiredDocuments)</b>"
        htmlString += "<br/>"
        htmlString += "<i>\(benefit.programCategory) for \(benefit.populationServed)</i>"
        htmlString += "\(benefit.helpSummary)"
        
        detailTextView.attributedText = htmlString.attributedString
    }
}
