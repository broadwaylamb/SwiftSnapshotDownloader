//
//  HTMLParser.swift
//  SwiftSnapshotDownloader
//
//  Created by Sergej Jaskiewicz on 19/01/2017.
//
//

import Scrape
import Foundation

class HTMLParser {
    
    private let document: HTMLDocument
    private let baseURL: URL
    private let pageURL: URL
    
    init?() {
        
        baseURL = URL(string: "https://swift.org")!
        pageURL = baseURL.appendingPathComponent("download")
        
        guard let document = HTMLDocument(url: pageURL, encoding: .utf8) else { return nil }
        
        self.document = document
    }
    
    func getDownloadURL() -> URL? {
        
        guard let element = document.element(atXPath: "//a[starts-with(@href, " +
            "'/builds/development/xcode/swift-DEVELOPMENT-SNAPSHOT') and @title='Download']"),
            let url = element["href"] else { return nil }
        
        return baseURL.appendingPathComponent(url)
    }
}
