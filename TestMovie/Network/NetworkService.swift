//
//  NetworkService.swift
//  TestMovie
//
//  Created by Pungki Busneri on 27/10/23.
//

import Foundation
import Moya
import Alamofire
import SwiftyJSON

final class NetworkService {
    static func request(endpoint: Endpoint, completion: @escaping ((_ data: JSON?,_ error: String?,_ statusCode: Int?) -> Void)) {
        let provider = MoyaProvider<Endpoint>(session: DefaultAlamofireSession.shared, plugins: [VerbosePlugin(isVerbose: true)])
        
        
        provider.request(endpoint) { result in
            switch result {
            case .success(let moyaResponse):
                let statusCode = moyaResponse.statusCode
                do {
                    let dataMap = try moyaResponse.mapJSON()
                    let dataJSON = JSON(dataMap)
                    completion(dataJSON, nil, statusCode)
                } catch {
                    if let error = error as? MoyaError {
                        do {
                            let body = try error.response?.mapJSON()
                            completion(nil, body.debugDescription, statusCode)
                        } catch {
                            completion(nil, "please try again", statusCode)
                        }
                    }
                }
            case .failure(let error):
                if error.errorCode == 6 {
                    completion(nil, "Internet Offline", 6)
                } else {
                    completion(nil, error.localizedDescription, 0)
                }
            }
        }
    }
}
