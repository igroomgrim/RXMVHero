//
//  GithubApi.swift
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
        switch self {
        case .GetCharacters:
            return nil
        case .GetCharactersByID(let id):
            return ["id": id]
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