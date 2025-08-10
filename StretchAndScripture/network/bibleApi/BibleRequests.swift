//
//  BibleRequests.swift
//  StretchAndScripture
//
//  Created by diegitsen on 10/08/25.
//


import Foundation
enum BibleRequests: BaseRequestProtocol {
    case getBooks(version: String)
    
    var path: String {
        switch self {
        case .getBooks(let version):
            return "/data/\(version)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getBooks(let version):
            return .GET
        }
    }
    
    var parameters: Parameters?{
        switch self {
        case .getBooks(let version):
            return nil
//            return [
//                "version": version
//            ]
        }
    }
}
