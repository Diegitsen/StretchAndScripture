//
//  BibleRequests.swift
//  StretchAndScripture
//
//  Created by diegitsen on 10/08/25.
//


import Foundation
enum BibleRequests: BaseRequestProtocol {
    case getBooks(version: String)
    case getChapters(book: String)
    
    var path: String {
        switch self {
        case .getBooks(let version):
            return "/data/\(version)"
        case .getChapters(let book):
            return "/data/web/\(book)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getBooks(let version):
            return .GET
        case .getChapters(let book):
            return .GET
        }
    }
    
    var parameters: Parameters?{
        switch self {
        case .getBooks(let version):
            return nil
        case .getChapters(let book):
            return nil
        }
    }
}
