//
//  BenefitViewController.swift
//  OpenNY
//
//  Created by Mihaela Miches on 3/26/17.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit
import MessageUI

class BenefitViewController: UIViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var applyButton: UIButton!
    
    @IBAction func didTapApply(_ sender: Any) {
        sendMail()
    }
    
    func sendMail() {
        guard let benefit = benefit, MFMailComposeViewController.canSendMail() else { return print("Mail services are not available")}
        let mailVC = MFMailComposeViewController()
        mailVC.setToRecipients([])
        mailVC.setSubject(benefit.programName + " " + benefit.programCode)
        mailVC.setMessageBody("Steps:<br/>" + benefit.howToApplySummary + "<b>" + benefit.requiredDocuments + "</b><br/><i>\(benefit.governmentAgency)</i><br/>" + benefit.helpSummary, isHTML: true)
        mailVC.mailComposeDelegate = self
        
        present(mailVC, animated: true, completion: nil)
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
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
}

