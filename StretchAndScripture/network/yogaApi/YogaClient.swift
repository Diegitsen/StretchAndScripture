//
//  YogaClient.swift
//  StretchAndScripture
//
//  Created by diegitsen on 9/08/25.
//

import ComposableArchitecture
import XCTestDynamicOverlay
import Foundation

struct YogaClient {
    var stretches: () async throws -> [Stretch]
}

extension DependencyValues {
    var yogaClient: YogaClient {
        get { self[YogaClient.self] }
        set { self[YogaClient.self] = newValue }
    }
}
//extension DependencyValues {
//  var yogaClient: YogaClient {
//    get { self[YogaClient.self] }
//    set { self[YogaClient.self] = newValue }
//  }
//}

//extension YogaClient: DependencyKey {
//  
//}

extension YogaClient: TestDependencyKey {
    static var previewValue: YogaClient {
        return .init(
            stretches: { [] }
        )
    }
    
    static var testValue: YogaClient {
        return .init (
            stretches: unimplemented("\(Self.self).List")
        )
    }
}

extension YogaClient: DependencyKey {
    static let liveValue = YogaClient (
        stretches: {
            let request = YogaRequests.getStretches
            return try await APIFetcher.shared.fetch(request: request, responseClass: [Stretch].self)
        }
    )
}

//extension YogaClient: DependencyKey {
//    static let liveValue = YogaClient(
//        stretches: {
//            let request = YogaRequests.getStretches
//            return try await APIFetcher.shared.fetch(request: request, responseClass: [Stretch].self)
//        }
//    )
//}
