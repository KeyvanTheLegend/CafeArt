//
//  ServerCommands.swift
//  CafeArt
//
//  Created by Keyvan Yaghoubian on 8/17/19.
//  Copyright © 2019 Keyvan Yaghoubian. All rights reserved.
//

import Foundation
public class ServerCommands {
    let Formatter = NumberFormatter()
    /*let sharedPref = UserDefaults.standard
    if(sharedPref.object(forKey: "NikaPayisFristTime") == nil){
    sharedPref.setValue("false", forKey: "NikaPayisFristTime")
    sharedPref.setValue("0", forKey: "NikaPayConfig")
    let sessionConfiguration = URLSessionConfiguration.default
    let additionalHeadersDict = ["SubscriberToken": sharedPref.object(forKey: "NikaPayToken")]
    sessionConfiguration.httpAdditionalHeaders = additionalHeadersDict as [AnyHashable : Any]
    PINRemoteImageManager.setSharedImageManagerWith(sessionConfiguration)
    
    }
    else{
    isFirstTime = sharedPref.object(forKey: "NikaPayisFristTime") as! String
    */
    let SERVER_URL = "https://cafe-art-backend.liara.run/"
    public func SendActivationCode (MobileNumber : String ,completion: @escaping (_ success: NSDictionary) -> (),unauthorized: @escaping (_ unauthorized: String) -> (),onError: @escaping (_ error: Error) -> ()) -> () {
        let SERVER_URL = "\(self.SERVER_URL)categories"
        let url :URL! = URL(string: SERVER_URL)
        var request = URLRequest(url: url)
        let token = sharedPref.object(forKey: "Token") as! String
        let Id = sharedPref.object(forKey: "Id") as! String

        request.setValue(Id, forHTTPHeaderField: "Id")
        request.setValue(token, forHTTPHeaderField: "Token")
        print(token)
        print(Id)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with:request) { (data, oncompele, error) -> Void in
            if (error == nil){
                _ = String(data: data!, encoding: String.Encoding.utf8)
                if let httpResponse = oncompele as? HTTPURLResponse {
                    if(httpResponse.statusCode == 200){
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!,    options:JSONSerialization.ReadingOptions.mutableContainers) as!    NSDictionary
                            completion(json)
                           
                        }
                        catch{
                            print("not a valid json")
                        }
                    }
                    else if(httpResponse.statusCode == 401){
                        //print("unathorized")
                        unauthorized("unathorized")
                    }
                }
            }
            else{
                onError(error!)
                print("abas")
            }
        }
        task.resume()
        return
    }
    public func GetImage (Link : String ,completion: @escaping (_ success: String) -> (),unauthorized: @escaping (_ unauthorized: String) -> (),onError: @escaping (_ error: Error) -> ()) -> () {
        let SERVER_URL = Link
        let url :URL! = URL(string: SERVER_URL)
        var request = URLRequest(url: url)
        let token = sharedPref.object(forKey: "Token") as! String
        let Id = sharedPref.object(forKey: "Id") as! String
        
        request.setValue(Id, forHTTPHeaderField: "Id")
        request.setValue(token, forHTTPHeaderField: "Token")
        print(token)
        print(Id)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with:request) { (data, oncompele, error) -> Void in
            if (error == nil){
                let x = String(data: data!, encoding: String.Encoding.utf8)
                if let httpResponse = oncompele as? HTTPURLResponse {
                    if(httpResponse.statusCode == 200){
                        completion(x!)
                    }
                    else if(httpResponse.statusCode == 401){
                        //print("unathorized")
                        unauthorized("unathorized")
                    }
                }
            }
            else{
                onError(error!)
                print("abas")
            }
        }
        task.resume()
        return
    }
    
    let sharedPref = UserDefaults.standard

    public func GuestLogin (completion: @escaping (_ success: NSDictionary) -> (),unauthorized: @escaping (_ unauthorized: String) -> (),onError: @escaping (_ error: Error) -> ()) -> () {
        let SERVER_URL = "\(self.SERVER_URL)user/login/guest"
        let url :URL! = URL(string: SERVER_URL)
        var request = URLRequest(url: url)
        var token = ""
        if(sharedPref.object(forKey: "uuid") != nil){
            token = sharedPref.object(forKey: "uuid") as! String
        }
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let json: [String: Any] = ["UUID": "\(token)"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        let session = URLSession.shared
        request.httpBody = jsonData

        let task = session.dataTask(with:request) { (data, oncompele, error) -> Void in
            if (error == nil){
                _ = String(data: data!, encoding: String.Encoding.utf8)
                if let httpResponse = oncompele as? HTTPURLResponse {
                    if(httpResponse.statusCode == 200){
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!,    options:JSONSerialization.ReadingOptions.mutableContainers) as!    NSDictionary
                            completion(json)
                            let json2 = json["Description"] as! String
                            print(json2)
                            if let data = json2.data(using: .utf8) {
                                do {
                                    let json3 = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers) as!    NSDictionary
                                    self.sharedPref.setValue(json3["Token"] as! String, forKey: "Token")
                                    self.sharedPref.setValue(json3["Id"] as! String, forKey: "Id")
                                    self.sharedPref.setValue("guest" , forKey: "UserType")
                                }
                                catch{
                                    print("not a valid json2222")
                                }
                                
                            }
                            
                        }
                        catch{
                            print("not a valid json")
                        }
                    }
                    else if(httpResponse.statusCode == 401){
                        //print("unathorized")
                        unauthorized("unathorized")
                    }
                }
            }
            else{
                onError(error!)
                print("abas")
            }
        }
        task.resume()
        return
    }
    
    
    public func getGallary (completion: @escaping (_ success: NSDictionary) -> (),unauthorized: @escaping (_ unauthorized: String) -> (),onError: @escaping (_ error: Error) -> ()) -> () {
        let SERVER_URL = "\(self.SERVER_URL)cafe/image/urls"
        let url :URL! = URL(string: SERVER_URL)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let token = sharedPref.object(forKey: "Token") as! String
        let Id = sharedPref.object(forKey: "Id") as! String
        
        request.setValue(Id, forHTTPHeaderField: "Id")
        request.setValue(token, forHTTPHeaderField: "Token")
        let session = URLSession.shared
        let task = session.dataTask(with:request) { (data, oncompele, error) -> Void in
            if (error == nil){
                _ = String(data: data!, encoding: String.Encoding.utf8)
                if let httpResponse = oncompele as? HTTPURLResponse {
                    if(httpResponse.statusCode == 200){
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!,    options:JSONSerialization.ReadingOptions.mutableContainers) as!    NSDictionary
                            completion(json)
                        }
                        catch{
                            print("not a valid json")
                        }
                    }
                    else if(httpResponse.statusCode == 401){
                        //print("unathorized")
                        unauthorized("unathorized")
                    }
                }
            }
            else{
                onError(error!)
                print("abas")
            }
        }
        task.resume()
        return
    }
    public func getEvents (completion: @escaping (_ success: NSDictionary) -> (),unauthorized: @escaping (_ unauthorized: String) -> (),onError: @escaping (_ error: Error) -> ()) -> () {
        let SERVER_URL = "\(self.SERVER_URL)events/sorted"
        let url :URL! = URL(string: SERVER_URL)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let token = sharedPref.object(forKey: "Token") as! String
        let Id = sharedPref.object(forKey: "Id") as! String
        
        request.setValue(Id, forHTTPHeaderField: "Id")
        request.setValue(token, forHTTPHeaderField: "Token")
        let session = URLSession.shared
        let task = session.dataTask(with:request) { (data, oncompele, error) -> Void in
            if (error == nil){
                _ = String(data: data!, encoding: String.Encoding.utf8)
                if let httpResponse = oncompele as? HTTPURLResponse {
                    if(httpResponse.statusCode == 200){
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!,    options:JSONSerialization.ReadingOptions.mutableContainers) as!    NSDictionary
                            completion(json)
                        }
                        catch{
                            print("not a valid json")
                        }
                    }
                    else if(httpResponse.statusCode == 401){
                        //print("unathorized")
                        unauthorized("unathorized")
                    }
                }
            }
            else{
                onError(error!)
                print("abas")
            }
        }
        task.resume()
        return
    }
    public func profile (completion: @escaping (_ success: NSDictionary) -> (),unauthorized: @escaping (_ unauthorized: String) -> (),onError: @escaping (_ error: Error) -> ()) -> () {
        let SERVER_URL = "\(self.SERVER_URL)user/profile"
        let url :URL! = URL(string: SERVER_URL)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let token = sharedPref.object(forKey: "Token") as! String
        let Id = sharedPref.object(forKey: "Id") as! String
        
        request.setValue(Id, forHTTPHeaderField: "Id")
        request.setValue(token, forHTTPHeaderField: "Token")
        let session = URLSession.shared
        let task = session.dataTask(with:request) { (data, oncompele, error) -> Void in
            if (error == nil){
                _ = String(data: data!, encoding: String.Encoding.utf8)
                if let httpResponse = oncompele as? HTTPURLResponse {
                    if(httpResponse.statusCode == 200){
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!,    options:JSONSerialization.ReadingOptions.mutableContainers) as!    NSDictionary
                            completion(json)
                        }
                        catch{
                            print("not a valid json")
                        }
                    }
                    else if(httpResponse.statusCode == 401){
                        //print("unathorized")
                        unauthorized("unathorized")
                    }
                }
            }
            else{
                onError(error!)
                print("abas")
            }
        }
        task.resume()
        return
    }
    public func gallary (completion: @escaping (_ success: NSDictionary) -> (),unauthorized: @escaping (_ unauthorized: String) -> (),onError: @escaping (_ error: Error) -> ()) -> () {
        let SERVER_URL = "\(self.SERVER_URL)cafe/images"
        let url :URL! = URL(string: SERVER_URL)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let token = sharedPref.object(forKey: "Token") as! String
        let Id = sharedPref.object(forKey: "Id") as! String
        
        request.setValue(Id, forHTTPHeaderField: "Id")
        request.setValue(token, forHTTPHeaderField: "Token")
        let session = URLSession.shared
        let task = session.dataTask(with:request) { (data, oncompele, error) -> Void in
            if (error == nil){
                _ = String(data: data!, encoding: String.Encoding.utf8)
                if let httpResponse = oncompele as? HTTPURLResponse {
                    if(httpResponse.statusCode == 200){
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!,    options:JSONSerialization.ReadingOptions.mutableContainers) as!    NSDictionary
                            completion(json)
                        }
                        catch{
                            print("not a valid json")
                        }
                    }
                    else if(httpResponse.statusCode == 401){
                        //print("unathorized")
                        unauthorized("unathorized")
                    }
                }
            }
            else{
                onError(error!)
                print("abas")
            }
        }
        task.resume()
        return
    }
    
    public func SendActivationCode2 (MobileNumber : String ,completion: @escaping (_ success: NSDictionary) -> (),unauthorized: @escaping (_ unauthorized: String) -> (),onError: @escaping (_ error: Error) -> ()) -> () {
        let SERVER_URL = "\(self.SERVER_URL)user/enter"
        let sharedPref = UserDefaults.standard
        let url :URL! = URL(string: SERVER_URL)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.setValue(sharedPref.object(forKey: "NikaPayToken") as? String, forHTTPHeaderField: "SubscriberToken")
        request.httpMethod = "POST"
        Formatter.locale = NSLocale(localeIdentifier: "EN") as Locale
        let mobileNumberEn = Formatter.number(from: MobileNumber)
        let session = URLSession.shared
        var token = ""
        if(sharedPref.object(forKey: "uuid") != nil){
            token = sharedPref.object(forKey: "uuid") as! String
        }
        
        let json: [String: Any] = ["PhoneNumber": "0\(mobileNumberEn!)","UUID": "0\(token)"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        let task = session.dataTask(with:request) { (data, oncompele, error) -> Void in
            if (error == nil){
                _ = String(data: data!, encoding: String.Encoding.utf8)
                if let httpResponse = oncompele as? HTTPURLResponse {
                    if(httpResponse.statusCode == 200){
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!,    options:JSONSerialization.ReadingOptions.mutableContainers) as!    NSDictionary
                            completion(json)
                           
                        }
                        catch{
                            print("not a valid json")
                        }
                    }
                    else if(httpResponse.statusCode == 401){
                        //print("unathorized")
                        unauthorized("unathorized")
                    }
                }
            }
            else{
                onError(error!)
            }
        }
        task.resume()
        return
    }
    
    public func Login_Veri (MobileNumber : String,code : String,completion: @escaping (_ success: NSDictionary) -> (),unauthorized: @escaping (_ unauthorized: String) -> (),onError: @escaping (_ error: Error) -> ()) -> () {
        let SERVER_URL = "\(self.SERVER_URL)user/login_verification"
        let sharedPref = UserDefaults.standard
        let url :URL! = URL(string: SERVER_URL)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.setValue(sharedPref.object(forKey: "NikaPayToken") as? String, forHTTPHeaderField: "SubscriberToken")
        request.httpMethod = "POST"
        Formatter.locale = NSLocale(localeIdentifier: "EN") as Locale
        let mobileNumberEn = Formatter.number(from: MobileNumber)
        print(mobileNumberEn)
        let session = URLSession.shared
        let json: [String: Any] = ["PhoneNumber": "0\(mobileNumberEn!)" ,"VerificationCode" : "\(code)"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        let task = session.dataTask(with:request) { (data, oncompele, error) -> Void in
            if (error == nil){
                _ = String(data: data!, encoding: String.Encoding.utf8)
                if let httpResponse = oncompele as? HTTPURLResponse {
                    if(httpResponse.statusCode == 200){
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!,    options:JSONSerialization.ReadingOptions.mutableContainers) as!    NSDictionary
                            completion(json)
                            let json2 = json["Description"] as! String
                            print(json2)
                            if let data = json2.data(using: .utf8) {
                                do {
                                    let json3 = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers) as!    NSDictionary
                                    self.sharedPref.setValue(json3["Token"] as! String, forKey: "Token")
                                    self.sharedPref.setValue(json3["Id"] as! String, forKey: "Id")
                                    self.sharedPref.setValue("activated" , forKey: "UserType")
                                }
                                catch{
                                    print("not a valid json2222")
                                }
                                
                            }
                        }
                        catch{
                            print("not a valid json")
                        }
                    }
                    else if(httpResponse.statusCode == 401){
                        //print("unathorized")
                        unauthorized("unathorized")
                    }
                }
            }
            else{
                onError(error!)
            }
        }
        task.resume()
        return
    }
    public func update (Name : String,Birthdate : String,completion: @escaping (_ success: NSDictionary) -> (),unauthorized: @escaping (_ unauthorized: String) -> (),onError: @escaping (_ error: Error) -> ()) -> () {
        let SERVER_URL = "\(self.SERVER_URL)user/profile/update"
        let sharedPref = UserDefaults.standard
        let url :URL! = URL(string: SERVER_URL)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.setValue(sharedPref.object(forKey: "NikaPayToken") as? String, forHTTPHeaderField: "SubscriberToken")
        request.httpMethod = "POST"
        Formatter.locale = NSLocale(localeIdentifier: "EN") as Locale
        let token = sharedPref.object(forKey: "Token") as! String
        let Id = sharedPref.object(forKey: "Id") as! String
        
        request.setValue(Id, forHTTPHeaderField: "Id")
        request.setValue(token, forHTTPHeaderField: "Token")
        let session = URLSession.shared
        let json: [String: Any] = ["Name": "\(Name)" ,"Birthdate" : "\(Birthdate)"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        let task = session.dataTask(with:request) { (data, oncompele, error) -> Void in
            if (error == nil){
                _ = String(data: data!, encoding: String.Encoding.utf8)
                if let httpResponse = oncompele as? HTTPURLResponse {
                    if(httpResponse.statusCode == 200){
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!,    options:JSONSerialization.ReadingOptions.mutableContainers) as!    NSDictionary
                            completion(json)
 
                                
                            
                        }
                        catch{
                            print("not a valid json")
                        }
                    }
                    else if(httpResponse.statusCode == 401){
                        //print("unathorized")
                        unauthorized("unathorized")
                    }
                }
            }
            else{
                onError(error!)
            }
        }
        task.resume()
        return
    }
    
    public func Comment (id : String,Comment1 : String,Rate : Int,completion: @escaping (_ success: NSDictionary) -> (),unauthorized: @escaping (_ unauthorized: String) -> (),onError: @escaping (_ error: Error) -> ()) -> () {
        let SERVER_URL = "\(self.SERVER_URL)item/comment/submit"
        let sharedPref = UserDefaults.standard
        let url :URL! = URL(string: SERVER_URL)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.setValue(sharedPref.object(forKey: "NikaPayToken") as? String, forHTTPHeaderField: "SubscriberToken")
        let token = sharedPref.object(forKey: "Token") as! String
        let Id = sharedPref.object(forKey: "Id") as! String
        
        request.setValue(Id, forHTTPHeaderField: "Id")
        request.setValue(token, forHTTPHeaderField: "Token")
        
        request.httpMethod = "POST"
        let session = URLSession.shared
        
        let json: [String: Any] = ["ItemId": "\(id)","Comment": "\(Comment1)","Rate": "\(Rate)"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        let task = session.dataTask(with:request) { (data, oncompele, error) -> Void in
            if (error == nil){
                _ = String(data: data!, encoding: String.Encoding.utf8)
                if let httpResponse = oncompele as? HTTPURLResponse {
                    if(httpResponse.statusCode == 200){
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!,    options:JSONSerialization.ReadingOptions.mutableContainers) as!    NSDictionary
                            completion(json)
                        }
                        catch{
                            print("not a valid json")
                        }
                    }
                    else if(httpResponse.statusCode == 401){
                        //print("unathorized")
                        unauthorized("unathorized")
                    }
                }
            }
            else{
                onError(error!)
            }
        }
        task.resume()
        return
    }
    public func Like (id : String,completion: @escaping (_ success: NSDictionary) -> (),unauthorized: @escaping (_ unauthorized: String) -> (),onError: @escaping (_ error: Error) -> ()) -> () {
        let SERVER_URL = "\(self.SERVER_URL)item/likeunlike"
        let sharedPref = UserDefaults.standard
        let url :URL! = URL(string: SERVER_URL)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.setValue(sharedPref.object(forKey: "NikaPayToken") as? String, forHTTPHeaderField: "SubscriberToken")
        let token = sharedPref.object(forKey: "Token") as! String
        let Id = sharedPref.object(forKey: "Id") as! String
        
        request.setValue(Id, forHTTPHeaderField: "Id")
        request.setValue(token, forHTTPHeaderField: "Token")

        request.httpMethod = "POST"
        let session = URLSession.shared
        let json: [String: Any] = ["ItemId": "\(id)"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        let task = session.dataTask(with:request) { (data, oncompele, error) -> Void in
            if (error == nil){
                _ = String(data: data!, encoding: String.Encoding.utf8)
                if let httpResponse = oncompele as? HTTPURLResponse {
                    if(httpResponse.statusCode == 200){
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!,    options:JSONSerialization.ReadingOptions.mutableContainers) as!    NSDictionary
                            completion(json)
                        }
                        catch{
                            print("not a valid json")
                        }
                    }
                    else if(httpResponse.statusCode == 401){
                        //print("unathorized")
                        unauthorized("unathorized")
                    }
                }
            }
            else{
                onError(error!)
            }
        }
        task.resume()
        return
    }
    
    public func Sign_up (MobileNumber : String,name : String,BirthDate:String,Gender:Int,completion: @escaping (_ success: NSDictionary) -> (),unauthorized: @escaping (_ unauthorized: String) -> (),onError: @escaping (_ error: Error) -> ()) -> () {
        let SERVER_URL = "\(self.SERVER_URL)user/sign_up/complete"
        let sharedPref = UserDefaults.standard
        let url :URL! = URL(string: SERVER_URL)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.setValue(sharedPref.object(forKey: "NikaPayToken") as? String, forHTTPHeaderField: "SubscriberToken")
        request.httpMethod = "POST"
        Formatter.locale = NSLocale(localeIdentifier: "EN") as Locale
        let token = sharedPref.object(forKey: "Token") as! String
        let Id = sharedPref.object(forKey: "Id") as! String
        
        request.setValue(Id, forHTTPHeaderField: "Id")
        request.setValue(token, forHTTPHeaderField: "Token")
        let mobileNumberEn = Formatter.number(from: MobileNumber)
        let session = URLSession.shared
        let json: [String: Any] = ["PhoneNumber": "0\(mobileNumberEn!)" ,"Name" : "\(name)","BirthDate" : "\(BirthDate)","Gender" : "\(Gender)"]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        let task = session.dataTask(with:request) { (data, oncompele, error) -> Void in
            if (error == nil){
                _ = String(data: data!, encoding: String.Encoding.utf8)
                if let httpResponse = oncompele as? HTTPURLResponse {
                    if(httpResponse.statusCode == 200){
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!,    options:JSONSerialization.ReadingOptions.mutableContainers) as!    NSDictionary
                            completion(json)
                        }
                        catch{
                            print("not a valid json")
                        }
                    }
                    else if(httpResponse.statusCode == 401){
                        //print("unathorized")
                        unauthorized("unathorized")
                    }
                }
            }
            else{
                onError(error!)
            }
        }
        task.resume()
        return
    }
    public func Items (rowId : String ,completion: @escaping (_ success: NSDictionary) -> (),unauthorized: @escaping (_ unauthorized: String) -> (),onError: @escaping (_ error: Error) -> ()) -> () {
        let SERVER_URL = "\(self.SERVER_URL)items/\(rowId)"
        print(rowId)
        let url :URL! = URL(string: SERVER_URL)
        var request = URLRequest(url: url)
        let token = sharedPref.object(forKey: "Token") as! String
        let Id = sharedPref.object(forKey: "Id") as! String
        
        request.setValue(Id, forHTTPHeaderField: "Id")
        request.setValue(token, forHTTPHeaderField: "Token")
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with:request) { (data, oncompele, error) -> Void in
            if (error == nil){
                _ = String(data: data!, encoding: String.Encoding.utf8)
                if let httpResponse = oncompele as? HTTPURLResponse {
                    if(httpResponse.statusCode == 200){
                        print(data!)
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!,    options:JSONSerialization.ReadingOptions.mutableContainers) as!    NSDictionary
                            completion(json)
                        }
                        catch{
                            print("not a valid json")
                        }
                    }
                    else if(httpResponse.statusCode == 401){
                        //print("unathorized")
                        unauthorized("unathorized")
                    }
                }
            }
            else{
                onError(error!)
                print("abas")
            }
        }
        task.resume()
        return
    }
    
}
