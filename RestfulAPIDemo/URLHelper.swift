//
//  URLComponentsHelper.swift
//  RestfulAPIDemo
//
//  Created by mengjiao on 5/16/18.
//  Copyright © 2018 mengjiao. All rights reserved.
//

import Foundation

class URLHelper {
    static let sharedInstance = URLHelper()
    public var urlComponenets = URLComponents()
    private init() {
        urlComponenets.scheme = "http"
        urlComponenets.host = "172.19.141.15"
        urlComponenets.port = 5555
    }
    
    func getLoginURL() -> URL? {
        urlComponenets.path = "/api/account"
        return urlComponenets.url
    }
    
}
