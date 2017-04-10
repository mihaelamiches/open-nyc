//
//  ApplicationError.swift
//  OpenNY
//
//  Created by Mihaela Miches on 3/25/17.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit

extension String {
    var attributedString: NSAttributedString? {
        return try? NSAttributedString(data: self.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil)
    }
    
    var length: Int {
        return self.characters.count
    }
}

public typealias Dictionary = [AnyHashable: AnyObject]

public protocol Scrappable {
    init?(_ json: Dictionary)
}

public typealias ScrapedCallback = (([Dictionary]) -> Void)

enum ApplicationError {
    case invalidUrl(_: String)
    case invalidIdentifier(_: String)
    case invalidResponse(_: URLResponse?)
    case rogue(_: Error?)
}
