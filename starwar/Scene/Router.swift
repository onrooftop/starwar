//
//  Router.swift
//  starwar
//
//  Created by Panupong Kukutapan on 9/10/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    case people(parameters: Parameters)
    case person(id: Int)
    case homeworld(id :Int)
    case film(id: Int)
    case specie(id: Int)
    case vehicle(id: Int)
    case starship(id: Int)
    
    private static let baseURLString = "https://swapi.co/api"
    
    private var method: Alamofire.HTTPMethod {
        switch self {
        case .people:
            return .get
        case .person:
            return .get
        case .homeworld:
            return .get
        case .film:
            return .get
        case .specie:
            return .get
        case .vehicle:
            return .get
        case .starship:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .people:
            return "/people"
        case .person(let id):
            return "/people/\(id)"
        case .homeworld(let id):
            return "/planets/\(id)"
        case .film(let id):
            return "/films/\(id)"
        case .specie(let id):
            return "/species/\(id)"
        case .vehicle(let id):
            return "/vehicles/\(id)"
        case .starship(let id):
            return "/starships/\(id)"
        }
    }
    
    private var parameters: Parameters? {
        switch self {
        case .people(let parameters):
            return parameters
        default:
            return nil
        }
    }
        
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: "https://swapi.co/api")!
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
    
        switch self {
        case .people(let parameters):
            let encoding = Alamofire.URLEncoding.queryString
            urlRequest = try encoding.encode(urlRequest, with: parameters)
        default:
            break
        }
        
        return urlRequest
        
    }
}
