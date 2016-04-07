//
//  GithubUser.swift
//  RXMVHero
//
//  Created by Anak Mirasing on 4/7/16.
//  Copyright © 2016 iGROOMGRiM. All rights reserved.
//

struct GithubUser {
    
    var login: String
    var avatarUrl: String
    var htmlUrl: String
    var siteAdmin: Bool
    
    init(login: String, avatarUrl: String, htmlUrl: String, siteAdmin: Bool) {
        self.login = login
        self.avatarUrl = avatarUrl
        self.htmlUrl = htmlUrl
        self.siteAdmin = siteAdmin
    }
    
}
