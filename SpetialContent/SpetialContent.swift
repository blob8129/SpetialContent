//
//  Model.swift
//  SpetialContent
//
//  Created by Andrey Volobuev on 16/05/16.
//  Copyright © 2016 Andrey Volobuev. All rights reserved.
//

import Foundation
/**
 Structure containig model information about the special content
 */
struct SpetialContent{
    
    static let mentions = (group: 1, pattern:"(@\\w+\\b)", key: "mentions")
    static let emoticons = (group: 2, pattern:"\\((\\w{1,15})\\)", key: "emoticons")
    static let links = (group: 3, pattern:"(http(?:s)?://\\S+)", key: "links")
    /**
    Regular expression pattern
     - Returns: reg exp pattern for parsing special content
     */
    static var pattern: String {
        get {
            return "\(mentions.pattern)|\(emoticons.pattern)|\(links.pattern)"
        }
    }
    /**
     Finds group key for a JSONDictionary
     - parameter group: regular expression matching group
     - Returns: special content key in a JSONDictionary
     */
    static func getKeyByGroup(group: Int) -> String{
        var key = ""
        switch group {
        case mentions.group :
            key = mentions.key
        case emoticons.group:
            key = emoticons.key
        case links.group:
            key = links.key
        default:
            break
        }
        return key
    }
}