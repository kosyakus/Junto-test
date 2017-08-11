//
//  Router.swift
//  Junto test task
//
//  Created by Admin on 09.08.17.
//  Copyright © 2017 NS. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    private var besePath: String {
        return "https://api.producthunt.com"
    }
    
    case getNews(search: String, access_token: String)
    
    private var path: String {
        switch self {
        case .getNews:
            return "/v1/posts/all/"
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getNews:
            return .get
        }
    }
    
    private var parameters: Parameters {
        switch self {
        case let .getNews(search, access_token):
            return ["search[category]": search, "access_token": access_token]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try besePath.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        return try URLEncoding.default.encode(urlRequest, with: parameters)
        
    }
}
