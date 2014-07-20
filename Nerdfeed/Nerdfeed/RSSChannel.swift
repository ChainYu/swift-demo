//
//  RSSChannel.swift
//  Nerdfeed
//
//  Created by chain on 14-7-15.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit
import Foundation

class RSSChannel: NSObject,
                  NSXMLParserDelegate {
    
    // - Proporties
    
    
    var parentParserDelegate: ListViewController?
    var title: String = String()
    var infoString: String = String()
    var items: Array<RSSItem> = Array()
    
    var currentString: String = String()
    
    init() {
        super.init()
    }
    
    var parseTag: String!
    
    let titleTag = "title"
    let descriptionTag = "description"
    let itemTag = "item"
    let channelTag = "channel"
    
    
    // - Method
    
    
    func trimItemTitles() {
        //var regx = NSRegularExpression(pattern: "Author", //".* : (.*) : .*",
        //    options: 0, error: nil)
        
    }

    
    
    // Conform NSXMLParserDelegate
    func parser(parser: NSXMLParser!,
        didStartElement elementName: String!,
        namespaceURI: String!,
        qualifiedName qName: String!,
        attributes attributeDict: NSDictionary!) {
            
            //println("\(self) found \(elementName)")
            
            if elementName == titleTag {
                parseTag = elementName
            } else if elementName == descriptionTag {
                parseTag = elementName
            } else if elementName == itemTag {
                var entry = RSSItem()
                entry.parentParserDelegate = self
                parser.delegate = entry
                items.append(entry)
            }
            
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        
        //println("foundCharacter: \(string)")
        
        if parseTag? == titleTag {
            self.title = string
        } else if parseTag? == descriptionTag {
            self.infoString = string
        }
        
    }
    
    func parser(parser: NSXMLParser!,
        didEndElement elementName: String!,
        namespaceURI: String!,
        qualifiedName qName: String!) {
            
            parseTag = nil
            
            if elementName == channelTag {
                parser.delegate = parentParserDelegate!
                self.trimItemTitles()
            }
    }
    
    


}
