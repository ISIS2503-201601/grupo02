//
//  SATTModel.swift
//  SATT Mobile
//
//  Created by Daniel Soto rey on 17/05/16.
//  Copyright © 2016 Daniel Soto Rey. All rights reserved.
//

import Foundation

extension String {
    
    
    /**
    Encode a String to Base64
    
    :returns:
    */
    func toBase64()->String{
        
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)
        
        return data!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
    }
    
}

struct SATT{
    
    enum Errors: ErrorType {
        case Unauthorized
        case NoCast
    }
    
    static var sessionManager:SessionManager = SessionManager()
    static var infoManager:InfoManager = InfoManager()
}


struct SessionManager{
    
    var currentUser: Usuario?
    
    mutating func logInWithUser(user:String, pass:String, block:(Bool, ErrorType?, [String:AnyObject]?)->Void){
        let json = ["email": user, "password": pass.toBase64()]
        
        do {
            
            let data = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
            
            // create post request
            let url = NSURL(string: "https://uniandes-satt.herokuapp.com/auth")!
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            
            // insert json data to the request
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = data
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
                if error != nil{
                    print("Error -> \(error)")
                    block(false, error, nil)
                    return
                }
                
                do {
                    let result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:AnyObject]
                    if let _ = Usuario(json: result!){
                        block(true, nil, result!)
                    }
                    else{
                        block(false, nil, result!)
                    }
                    
                    
                } catch {
                    print("Error -> \(error)")
                    block(false, error, nil)
                }
            }
            
            task.resume()
            
        } catch {
            print(error)
            block(false,error,nil)
            
        }
    }
    func logOut(){
        
    }
    
}

struct InfoManager{
    
    func getAlertasWithBlock(block:([Alerta]?, ErrorType?)->Void){
        
        if (SATT.sessionManager.currentUser == nil){
            block(nil, SATT.Errors.Unauthorized)
            return
        }
        
        do {
            
            // create post request
            let url = NSURL(string: "https://uniandes-satt.herokuapp.com/alertas")!
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "GET"
            
            // insert json data to the request
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue(SATT.sessionManager.currentUser!.accessToken, forHTTPHeaderField: "Authorization")

            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
                if error != nil{
                    print("Error -> \(error)")
                    block(nil, error)
                    return
                }
                
                do {
                    let result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [[String:AnyObject]]
                    let alertas = [Alerta].fromJSONArray(result!)
                    if (alertas.count>0){
                        block(alertas, nil)
                    }
                    else{
                        block(nil, SATT.Errors.NoCast)
                    }
                    
                    
                } catch {
                    print("Error -> \(error)")
                    block(nil, SATT.Errors.Unauthorized)
                }
            }
            
            task.resume()
            
        } catch {
            print(error)
            block(nil,error)
            
        }
    }
    
    
    func getEventosWithBlock(block:([Evento]?, ErrorType?)->Void) ->Bool{
        
        if (SATT.sessionManager.currentUser == nil){
            block(nil, SATT.Errors.Unauthorized)
            return true
        }
        
        do {
            
            // create post request
            let url = NSURL(string: "https://uniandes-satt.herokuapp.com/eventos")!
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "GET"
            
            // insert json data to the request
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue(SATT.sessionManager.currentUser!.accessToken, forHTTPHeaderField: "Authorization")
            
            var unauth = false
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
                if error != nil{
                    print("Error -> \(error)")
                    block(nil, error)
                    unauth = true
                    return
                }
                
                do {
                    let result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [[String:AnyObject]]
                    
                    if (result == nil){
                        unauth = true
                        return
                    }
                    
                    let eventos = [Evento].fromJSONArray(result!)
                
                    if (eventos.count>0){
                        block(eventos, nil)
                    }
                    else{
                        block(nil, SATT.Errors.NoCast)
                        unauth = true
                    }
                    
                    
                } catch {
                    print("Error -> \(error)")
                    block(nil, SATT.Errors.Unauthorized)
                    unauth = true
                }
            }
            
            task.resume()
            return unauth
            
        } catch {
            print(error)
            block(nil,error)
            return true
            
        }
    }
}