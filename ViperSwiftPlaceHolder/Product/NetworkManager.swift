//
//  NetworkManager.swift
//  ViperSwiftPlaceHolder
//
//  Created by vb10 on 28.07.2023.
//

import Alamofire
import Foundation

protocol INetworkManager {
    var config: NetworkConfig { get set }
    func fetch<T: Decodable>(url: NetworkPath, method: NetworkType, type: T.Type) async -> Result<T?, Error>
}

// MARK: IT WILL USE ALL REQUEST

class AlamofireNetworkManager: INetworkManager {
    var config: NetworkConfig

    init(config: NetworkConfig) {
        self.config = config
    }

    static let shared: INetworkManager = AlamofireNetworkManager(config: NetworkConfig(baseUrl: NetworkPath.baseUrl))

    /// Fetch all request
    /// - Parameters:
    ///   - url: Network Path
    ///   - method: NetworkType
    /// - Returns: if everything okey it will return T type else it will return error
    func fetch<T: Decodable>(url: NetworkPath, method: NetworkType, type: T.Type) async -> Result<T?, Error> {
        let request = AF.request("\(config.baseUrl)/\(url.rawValue)",
                                 method: method.toAlamofire())
            .validate()
            .serializingDecodable(T.self)
        let result = await request.response
        guard let value = result.value else {
            return .failure(result.error ?? CustomError.networkError)
        }

        return .success(value)
    }
}
