//
//  SocialBenefit.swift
//  OpenNY
//
//  Created by Mihaela Miches on 3/25/17.
//  Copyright © 2017 me. All rights reserved.
//

import Foundation

struct SocialBenefit: Scrappable {
    let pageType: String
    
    let uniqueId: String
    let date: Date
    let language: String
    
    let briefExcerpt: String
    let programCode: String
    let programName: String
    let programAcronym: String
    let programCategory: String
    let programDescription: String
    
    let governmentAgency: String
    let populationServed: String
    let ageGroup: String
    

    let plainLanguageName: String
    let plainLanguageEligibility: String
    
    let requiredDocuments: String
    let headsUp: String
    
    let applicationForms: String
    let applicationFormsUrl: String
    
    let howToApplySummary: String
    let howToApplyOnline: String
    let applyOnlineCallToAction: String
    let applyOnlineUrl: String
    
    let howToApplyByEmailSummary: String
    let applyEmailCallToAction: String
    
    let howToApplyInPerson: String
    let applyInPersonCallToAction: String
    
    let howToApplyByPhone: String
    
    let helpSummary: String
    let onlineHelp: String
    let byEmailHelp: String
    let inPersonHelp: String
    let help311: String
    let no311Help: String
    
    let officeLocations: String

    init(_ json: Dictionary) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        self.date = dateFormatter.date(from: (json["date"] as? String  ?? ""))  ?? Date.distantPast
        self.uniqueId = json["unique_id_number"] as? String  ?? ""
        self.pageType = json["page_type"] as? String  ?? ""
        self.programCode = json["program_code"] as? String  ?? ""
        self.language = json["language"] as? String  ?? ""
        self.programName = json["program_name"] as? String  ?? ""
        self.programCategory = json["program_category"] as? String  ?? ""
        self.governmentAgency = json["government_agency"] as? String  ?? ""
        self.programAcronym = json["program_acronym_if_any"] as? String  ?? ""
        self.populationServed = json["population_served"] as? String  ?? ""
        self.ageGroup = json["age_group"] as? String  ?? ""
        self.plainLanguageName = json["plain_language_program_name"] as? String  ?? ""
        self.programDescription = json["program_description"] as? String  ?? ""
        self.briefExcerpt = json["brief_excerpt"] as? String  ?? ""
        self.headsUp  = json["heads_up "] as? String  ?? ""
        self.plainLanguageEligibility = json["plain_language_eligibility"] as? String  ?? ""
        self.howToApplySummary = json["how_to_apply_summary"] as? String  ?? ""
        self.howToApplyOnline = json["how_to_apply_or_enroll_online"] as? String  ?? ""
        self.applyOnlineCallToAction = json["apply_online_call_to_action"] as? String  ?? ""
        self.applyOnlineUrl = json["url_of_online_application"] as? String  ?? ""
        self.howToApplyByEmailSummary = json["how_to_apply_or_enroll_by_mail"] as? String  ?? ""
        self.applyEmailCallToAction = json["apply_by_mail_call_to_action"] as? String  ?? ""
        self.applicationForms = json["application_forms"] as? String  ?? ""
        self.applicationFormsUrl = json["url_of_pdf_application_forms"] as? String  ?? ""
        self.howToApplyInPerson = json["how_to_apply_or_enroll_in_person"] as? String  ?? ""
        self.applyInPersonCallToAction = json["apply_in_person_call_to_action"] as? String  ?? ""
        self.officeLocations = json["office_locations_url"] as? String  ?? ""
        self.howToApplyByPhone = json["how_to_apply_or_enroll_by_phone"] as? String  ?? ""
        self.requiredDocuments = json["required_documents_summary"] as? String  ?? ""
        self.helpSummary = json["get_help_summary"] as? String  ?? ""
        self.inPersonHelp = json["get_help_in_person"] as? String  ?? ""
        self.onlineHelp = json["get_help_online"] as? String  ?? ""
        self.byEmailHelp = json["get_help_by_email"] as? String  ?? ""
        self.help311 = json["get_help_by_calling_other_than_311"] as? String  ?? ""
        self.no311Help = json["get_help_by_calling_311_please_provide_what_to_ask_for_when_calling_311"] as? String  ?? ""
    }
}

extension SocialBenefit: Hashable, Equatable {
    static func ==(lhs: SocialBenefit, rhs: SocialBenefit) -> Bool {
        return lhs.uniqueId == rhs.uniqueId
    }

    var hashValue: Int {
        return uniqueId.hashValue
    }
}
