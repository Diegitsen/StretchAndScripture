//
//  YogaRequests.swift
//  StretchAndScripture
//
//  Created by diegitsen on 9/08/25.
//


import Foundation
enum YogaRequests: BaseRequestProtocol {
    case getStretches
    case getStretchesById(id: String)
    
    var path: String {
        switch self {
        case .getStretches:
            return "/poses"
        case .getStretchesById:
            return "/poses"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getStretches:
            return .GET
        case .getStretchesById(let id):
            return .GET
        }
    }
    
    var parameters: Parameters?{
        switch self {
        case .getStretches:
            return nil
        case .getStretchesById(let id):
            return [
                "id": id
            ]
        }
    }
}
