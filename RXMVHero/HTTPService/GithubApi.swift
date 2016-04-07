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
    case GetUser
    case GetUserWithLoginName(login: String)
}

extension ApiService: TargetType {
    
    var baseURL: NSURL {
        return NSURL(string: "https://api.github.com/")!
    }
    
    var path: String {
        switch self {
        case .GetUser:
            return "users"
        case .GetUserWithLoginName(let login):
            return "users/\(login)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .GetUser, .GetUserWithLoginName(_):
            return .GET
        }
    }
    
    var parameters: [String: AnyObject]? {
        switch self {
        case .GetUser:
            return nil
        case .GetUserWithLoginName(let login):
            return ["login": login]
        }
    }
    
    var sampleData: NSData {
        switch self {
        case .GetUser:
            return "[]".dataUsingEncoding(NSUTF8StringEncoding)!
        case .GetUserWithLoginName(_):
            return "[]".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
}