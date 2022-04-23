//
//  MovieEndPoint.swift
//  NetworkLayer
//

import Foundation


enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum FlightApi {
    case flightWithAirline(page:Int, name: String)
    case flights(page:Int)
}

extension FlightApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "http://api.aviationstack.com/v1/"
        case .qa: return ""
        case .staging: return ""
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .flightWithAirline:
            return "flights"
        case .flights:
            return "flights"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .flightWithAirline(let page, let name):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["page":page, "limit":20,"airline_name":name,
                                                      "access_key":NetworkManager.accessKey])
        case .flights(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["page":page,"limit":20,
                                                      "access_key":NetworkManager.accessKey])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


