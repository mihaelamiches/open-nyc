//
//  Scraper.swift
//  OpenNY
//
//  Created by Mihaela Miches on 3/25/17.
//  Copyright © 2017 me. All rights reserved.
//

import Foundation

public struct Scraper {
    public static func scrape(_ urlString: String, ofType: Scrappable, resultsCallback: @escaping ScrapedCallback) {
        guard let url = URL(string: urlString) else {
            print(ApplicationError.invalidUrl(urlString))
            return resultsCallback([])
        }
        
        scrape(url) { raw in
            let results: [Scrappable]? = raw.flatMap { el in
                guard let dictionary = el as? [AnyHashable: AnyObject] else { return nil }
                return type(of: ofType).init(dictionary)
            }
        
            resultsCallback(results ?? [])
        }
    }
    
    public static func scrape(_ url: URL, callback: @escaping (([AnyObject]) -> Void)) {
        let urlSession = URLSession(configuration: .default)
        
        urlSession.dataTask(with: url, completionHandler: {(data, response, error) in
            guard error == nil else  { print(ApplicationError.rogue(error)); return callback([]) }
            guard let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
                let raw = json as? [AnyObject]
                else { print(ApplicationError.invalidResponse(response)); return callback([]) }
            
            //print(raw)
            callback(raw)
        }).resume()
    }
}
