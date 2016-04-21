//
//  MVApi.swift
//  RXMVHero
//
//  Created by Anak Mirasing on 4/7/16.
//  Copyright © 2016 iGROOMGRiM. All rights reserved.
//

import Foundation
import Moya

enum ApiService {
    case GetCharacters
    case GetCharactersByID(id: String)
}

private func JSONResponseDataFormatter(data: NSData) -> NSData {
    do {
        let dataAsJSON = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        let prettyData =  try NSJSONSerialization.dataWithJSONObject(dataAsJSON, options: .PrettyPrinted)
        return prettyData
    } catch {
        return data //fallback to original data if it cant be serialized
    }
}

let MVProvider = RxMoyaProvider<ApiService>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

extension ApiService: TargetType {
    
    var baseURL: NSURL {
        return NSURL(string: "http://gateway.marvel.com")!
    }
    
    var path: String {
        
        switch self {
        case .GetCharacters:
            return "/v1/public/characters"
        case .GetCharactersByID(let id):
            return "/v1/public/characters/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .GetCharacters, .GetCharactersByID(_):
            return .GET
        }
    }
    
    var parameters: [String: AnyObject]? {
        
        let publicKey = ""
        let privateKey = ""
        let apiKey = ""
        let ts = NSDate().timeIntervalSince1970.description
        let hash = "\(ts)\(privateKey)\(publicKey)".md5
        
        switch self {
        case .GetCharacters:
            return ["apikey":apiKey, "ts":ts, "hash": hash]
        case .GetCharactersByID(let id):
            return ["apikey":apiKey, "ts":ts, "hash": hash, "id": id]
        }
    }
    
    var sampleData: NSData {
        switch self {
        case .GetCharacters:
            return "[]".dataUsingEncoding(NSUTF8StringEncoding)!
        case .GetCharactersByID(_):
            return "[]".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
}