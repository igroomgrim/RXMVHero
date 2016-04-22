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
    case GetComics
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

let MVProvider = RxMoyaProvider<ApiService>(plugins: [NetworkLoggerPlugin(verbose: false, responseDataFormatter: JSONResponseDataFormatter)])

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
        case .GetComics:
            return "/v1/public/comics"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .GetCharacters, .GetCharactersByID(_), .GetComics:
            return .GET
        }
    }
    
    var parameters: [String: AnyObject]? {
        
        let ts = NSDate().timeIntervalSince1970.description
        let hash = "\(ts)\(MVPrivateKey)\(MVPublicKey)".md5
        
        switch self {
        case .GetCharacters, .GetComics:
            return ["apikey":MVPublicKey, "ts":ts, "hash": hash]
        case .GetCharactersByID(let id):
            return ["apikey":MVPublicKey, "ts":ts, "hash": hash, "id": id]
        }
    }
    
    var sampleData: NSData {
        switch self {
        case .GetCharacters, .GetComics:
            return "[]".dataUsingEncoding(NSUTF8StringEncoding)!
        case .GetCharactersByID(_):
            return "[]".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
}