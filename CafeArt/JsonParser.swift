//
//  JsonParser.swift
//  NikaPay
//
//  Created by Apple on 3/19/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

class JsonParser {
    
    func JsonToNsDictionary(json :String) -> NSDictionary {
        var dictionary : NSDictionary = NSDictionary()
        if let data = json.data(using: String.Encoding.utf8) {
            do {
                 dictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
                print("HIiiiii: \(dictionary)")
            } catch {
                print("Something went wrong")
            }
        
        }
        return dictionary
    }
    func NsDictionaryToJson(dictionary :NSDictionary) -> String {
        var string : String = ""
        do{
            let json: NSData = try JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            string = NSString(data: json as Data, encoding: String.Encoding.utf8.rawValue)! as String
            //print(string)
            print("HIiiii23232i: \(string)")

        }
        catch{}
        return string
    }

}
