//
//  SpecialContentOperation.swift
//  SpetialContent
//
//  Created by Andrey Volobuev on 16/05/16.
//  Copyright © 2016 Andrey Volobuev. All rights reserved.
//

import UIKit
/**
 Operation for parsing special content from string
 ### Special content
 - @mentions - A way to mention a user. Always starts with an '@' and ends when hitting a non-word character.
 - Emoticons - 😀'custom' emoticons which are alphanumeric strings, no longer than 15 characters, contained in parenthesis 😀.
 - Links - Any URLs contained in the message, along with the page's title.
 - parameter input string to parse
 */
class SpecialContentOperation: NSOperation {
    private let input: String
    private var result: [String: [String]]?
    private let spetialContentCallback: (([String:[String]]) -> Void)
    private let noSpetialContentCallback: () -> Void

    init(input: String, callback: ([String:[String]]) -> Void, noContentCallback: () -> Void) {
        self.input = input
        self.spetialContentCallback = callback
        self.noSpetialContentCallback = noContentCallback
    }
    
    override func main() {
        guard let regexp = try? NSRegularExpression(pattern: SpetialContent.pattern, options: []) else { return }
        
        let matches = regexp.matchesInString(input, options: [], range: NSMakeRange(0, input.characters.count))
        if matches.isEmpty == true {
            dispatch_async(dispatch_get_main_queue(), {
                self.noSpetialContentCallback()
            })
            return
        }
        let result = getResultFomMathes(matches, andInput: input)
        dispatch_async(dispatch_get_main_queue(), {
            self.spetialContentCallback(result)
        })
    }
    
    private func getResultFomMathes(matches: [NSTextCheckingResult], andInput input: String) -> [String: [String]] {
        var ret = [String:[String]]()
        
        for match in matches {
            for group in 1..<match.numberOfRanges {
                
                let rangeOfGroup = match.rangeAtIndex(group)
                
                if rangeOfGroup.length > 0 {

                    let key = SpetialContent.getKeyByGroup(group)
                    let start = input.startIndex.advancedBy(rangeOfGroup.location)
                    let end = start.advancedBy(rangeOfGroup.length)
                    let result = input.substringWithRange(start..<end)
                    
                    if ret[key] == nil {
                        ret[key] = [result]
                    } else {
                        if var arr = ret[key] {
                            arr.append(result)
                            ret[key] = arr
                        }
                    }
                }
            }
        }
        return ret
    }
}
