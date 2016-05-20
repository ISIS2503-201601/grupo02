//
//  JSONMapper.swift
//  SATT Mobile
//
//  Created by Daniel Soto rey on 05/05/16.
//  Copyright © 2016 Daniel Soto Rey. All rights reserved.
//

import Foundation
import Gloss

//{ "_id" : { "$oid" : "56c3f51c38df010003cade3a"} , "perfil" : "Informativo" , "zona" : "Magdalena" , "tLlegada" : 581498 , "altura" : 3.077}

public struct Alerta: Decodable {
    
    public let id: String
    public let perfil: String
    public let zona: String
    public let tiempoLlegada: Double
    public let altura: Double
    
    public init?(json: JSON) {
        guard let objId: JSON = "_id"  <~~ json,
            let id: String = "$oid"  <~~ objId
            else {return nil}
        
        guard let perfil: String = "perfil"  <~~ json
            else {return nil}
        
        guard let zona: String = "zona" <~~ json
            else{return nil}
        
        guard let tiempoLlegada: Double = "tLlegada" <~~ json
            else{return nil}
        
        guard let altura: Double = "altura" <~~ json
            else{return nil}
        
        self.id = id
        self.perfil = perfil
        self.zona = zona
        self.tiempoLlegada = tiempoLlegada
        self.altura = altura
        
        
        
    }
}

//{"_id":{"$oid":"56c3f51c38df010003cadb93"},"lat":10.9667833,"lng":-74.8887452,"distancia":20},

public struct Evento: Decodable {
    
    public let id: String
    public let lat: Double
    public let lng: Double
    public let distancia: Double
    
    public init?(json: JSON) {
        guard let objId: JSON = "_id"  <~~ json,
            let id: String = "$oid"  <~~ objId
            else {return nil}
        
        guard let lat: Double = "lat" <~~ json
            else{return nil}
        
        guard let lng: Double = "lng" <~~ json
            else{return nil}
        
        guard let distancia: Double = "distancia" <~~ json
            else{return nil}
        
        self.id = id
        self.lat = lat
        self.lng = lng
        self.distancia = distancia
        
        
        
    }
}
/*
{
"auth":1,
"accesToken":...
"id": 98347184,
"name": "Juan Santiago",
"role": "ADMIN"
}
*/
public struct Usuario: Decodable {
    
    public let id: String
    public let name: String
    public let auth: Bool
    public let accessToken: String
    public let role: String
    
    public init?(json: JSON) {
        guard let id: String = "id"  <~~ json
            else {return nil}
        
        guard let name: String = "name" <~~ json
            else{return nil}
        
        guard let auth: Bool = "auth" <~~ json
            else{return nil}
        
        guard let accessToken: String = "accessToken" <~~ json
            else{return nil}
        
        guard let role: String = "role" <~~ json
            else{return nil}
        
        self.id = id
        self.name = name
        self.auth = auth
        self.accessToken = accessToken
        self.role = role
    }
}