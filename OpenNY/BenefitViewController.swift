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
    @IBOutlet weak var applyButton: UIButton!
    
    @IBAction func didTapApply(_ sender: Any) {
        print("apply")
    }
    
    var benefit: SocialBenefit? {
        didSet {
            title = benefit?.programName ?? ""
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let benefit = benefit else { return }
        
        detailTextView.tintColor = UINavigationBar.appearance().tintColor
        
        applyButton.backgroundColor  = UINavigationBar.appearance().tintColor
        
        var htmlString = benefit.programDescription
        htmlString += "<br/><br/>"
        htmlString += benefit.howToApplySummary
        htmlString += "<br/><br/>"
        htmlString += "<b>\(benefit.requiredDocuments)</b>"
        htmlString += "<br/>"
        htmlString += "<a target=\"_blank\" href=\"javascript(void);\">\(benefit.programCategory) for \(benefit.populationServed)</a><br/>"
        htmlString += "<i>\(benefit.governmentAgency)</i></br>"
        htmlString += "\(benefit.helpSummary)"
        
        detailTextView.attributedText = htmlString.attributedString
    }
}
