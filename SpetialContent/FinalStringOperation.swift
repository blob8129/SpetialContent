//
//  FinalStringOperation.swift
//  SpetialContent
//
//  Created by Andrey Volobuev on 16/05/16.
//  Copyright © 2016 Andrey Volobuev. All rights reserved.
//

import UIKit
/**
 Creates JSON string containing information about chat message contents.
 
- parameter input: dictionary with all spetial content except links titles
- Returns: calls finalStringCallback with the JSONDictionary containig all the spetial content and links titles
 
*/
class FinalStringOperation: NSOperation {
    
    var input: [String: [String]]
    var finalStringCallback: (JSONDictionary) -> Void
    
    init(input: [String: [String]], finalStringCallback: (JSONDictionary) -> Void){
        self.input = input
        self.finalStringCallback = finalStringCallback
    }
    
    internal func getLinks() -> [[String: String]]{
        return dependencies.filter{dependency in
            dependency is LinkTileProtocol
            }.map{dependency in
                dependency as! LinkTileProtocol
            }.map{dependency in
                ["url": dependency.link, "title": dependency.title]
        }
    }
    
    override func main() {
        let links = getLinks()
        
        var final = JSONDictionary()
        for key in input.keys where key != SpetialContent.links.key{
            final[key] = input[key]
        }
        final[SpetialContent.links.key] = links
        
        dispatch_async(dispatch_get_main_queue()) {
            self.finalStringCallback(final)
        }
    }
}