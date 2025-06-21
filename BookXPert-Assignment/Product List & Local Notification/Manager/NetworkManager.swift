//
//  NetworkManager.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 20/06/25.
//


import Alamofire

typealias NetworkResult<T> = (Result<T, AFError>) -> Void

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func request<T: Decodable>(_ type: T.Type,
                               url: String,
                               completion: @escaping (Result<T, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: type) { response in
                completion(response.result)
            }
    }
}
