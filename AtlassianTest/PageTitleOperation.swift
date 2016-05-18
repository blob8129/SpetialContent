//
//  PageTitleOperation.swift
//  AtlassianTest
//
//  Created by Andrey Volobuev on 16/05/16.
//  Copyright © 2016 Andrey Volobuev. All rights reserved.
//

import Foundation

protocol LinkTileProtocol {
    var link: String {get}
    var title: String {get}
}
/**
 Operation for loading web page titles
 
- parameter link: web page url in string
- Returns: loaded web page title
 */
class PageTitleOperation: NSOperation, LinkTileProtocol{
    
    let link: String
    var title: String = ""
    
    init(link: String){
        self.link = link
    }
    
    override func main() {
        
        guard let url = NSURL(string: link) else{ return }
        guard let input = getWebPageContentForUrl(url) else { return }
        title = getFirstMatchInString(input, withPattern: "<title>(.+)</title>")
    }
    
    internal func getWebPageContentForUrl(url: NSURL) -> String?{
        return try? String(contentsOfURL: url, encoding: NSISOLatin1StringEncoding)
    }
    
    private func getFirstMatchInString(input: String, withPattern pattern: String) ->  String {
        
        guard let regexp = try? NSRegularExpression(pattern: pattern, options: []) else { return "" }
        
        guard let match = regexp.firstMatchInString(input, options: [], range: NSMakeRange(0, input.characters.count)) else { return "" }
        
        let range = match.rangeAtIndex(1)
        let start = input.startIndex.advancedBy(range.location)
        let end = start.advancedBy(range.length)
        return input.substringWithRange(start..<end)
    }

}
