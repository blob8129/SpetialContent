//
//  ViewController.swift
//  SpetialContent
//
//  Created by Andrey Volobuev on 16/05/16.
//  Copyright © 2016 Andrey Volobuev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var inputTextField: UITextView!
    @IBOutlet weak var resultTextField: UITextView!
    @IBOutlet weak var parseStringButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private lazy var queue = NSOperationQueue()
    
    func startActivityIndicator() {
        activityIndicator.startAnimating()
        parseStringButton.hidden = true
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        parseStringButton.hidden = false
    }

    // MARK: Actions
    
    @IBAction func parseStringAction(sender: UIButton) {
        parseSpetialContrentForInput(inputTextField.text)
        startActivityIndicator()
        inputTextField.endEditing(true)
    }
    
    // MARK : Operations
    
    private func parseSpetialContrentForInput(input: String) {
        let specialContentOperation = SpecialContentOperation(input: input, callback: spetialContentCallback, noContentCallback: noSpetialContentCallback)
        queue.addOperation(specialContentOperation)
    }
    
    private func createPageTitleOperations(input: [String: [String]]) {
        var final = JSONDictionary()
        for key in input.keys where key != SpetialContent.links.key {
            final[key] = input[key]
        }
        guard let links = input[SpetialContent.links.key] else {
            parsedStringCallback(final)
            return
        }
        resultTextField.text = final.description
        
        let finalStringOperation = FinalStringOperation(input: input, finalStringCallback: parsedStringCallback)
        for link in links {
            let pageTitleOperation = PageTitleOperation(link: link)
            finalStringOperation.addDependency(pageTitleOperation)
            queue.addOperation(pageTitleOperation)
        }
        queue.addOperation(finalStringOperation)
    }
    
    // MARK : Callbacks
    
    private func spetialContentCallback(result: [String:[String]]) {
        self.createPageTitleOperations(result)
    }
    
    private func noSpetialContentCallback() {
        self.stopActivityIndicator()
    }
    
    private func parsedStringCallback(jsonDictionary: JSONDictionary) {
        self.stopActivityIndicator()
        self.resultTextField.text = jsonDictionary.description
    }
}
