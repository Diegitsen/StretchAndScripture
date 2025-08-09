//
//  StretchesListFeature.swift
//  StretchAndScripture
//
//  Created by diegitsen on 9/08/25.
//

import Combine
import ComposableArchitecture
import SwiftUI

struct StretchesListFeature: Reducer, NetworkHelper {
    
    let client: YogaClient
    init(client: YogaClient) { self.client = client }
    
    struct State: Equatable {
        var viewState: ViewState = .loading
        var stretchesList: [Stretch] = []
        var selectedStretch: Stretch?
    }
    
    enum Action: Equatable {
        case fetchStretches
        case stretchesResponse(Result<[Stretch], ActionError>)
        case didSelectStretch(stretch: Stretch?)
    }
        
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        
        switch action {
        case .fetchStretches:
            print("hey! aaaa")
//            guard isConnectedToInternet() else {
//                state.viewState = .offline(description: Str.youAreOffline.key)
//                return .none
//            }
            return .run { send in
                await send(
                    .stretchesResponse(
                        .success(
                            try await self.client.stretches()
                        )
                    )
                )
            }
            
        case .stretchesResponse(.success(let stretches)):
            print("hey! bbbb")
            state.stretchesList = stretches
            state.viewState = .loaded
            return .none
        case .stretchesResponse(.failure(let error)):
            print("hey! cccc")
            state.viewState = failHandler(error)
            return .none
        case .didSelectStretch(let stretch):
            print("hey! dddddd")
            state.selectedStretch = stretch
            return .none
        }
    }
}

protocol NetworkHelper: InternetConnectionChecker {
    func failHandler(_ error: Error) -> ViewState
}

extension NetworkHelper {
    func failHandler(_ error: Error) -> ViewState {
        
        guard isConnectedToInternet() else {
            return .offline(description: "Please Connectect to the internet to enjoy our service")
        }
        
        guard let error = error as? NetworkError else {
           return .unexpected(description: "UnExpected")
        }
        
        switch error {
        case .nonHTTPResponse,
                .incorrectStatusCode(_),
                .badURL(_),
                .apiError(_,_),
                .badRequest(_,_),
                .serverError(_,_),
                .noResponse(_):
            return .serverError(description: "Server Error")
        
        case .invalidJSON(_),
                .decodingError(_),
                .unknown(_,_):
            return .unexpected(description: "UnExpected")
        case .unauthorized(_,_):
            //Should be Custom error
            return .unexpected(description: "unauthorized")
        }
    }
}

enum ActionError: Error, Equatable {
    case decodingError
    case networkError(String)
}
