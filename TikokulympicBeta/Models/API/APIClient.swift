//
//  APIClient.swift
//  TikokulympicBeta
//
//  Created by 株丹優一郎 on 2024/09/15.
//

import Foundation
import Alamofire

class APIClient {
    static let shared = APIClient()
    private init() {}
    
    func call<T: RequestProtocol>(request: T, completion: @escaping (Result<T.Response, APIError>) -> Void) {
        let requestUrl = request.baseUrl + request.path
        
        let method = request.method
        let headers = request.headers

        // ベースURLとパスを結合
        var urlComponents = URLComponents(string: request.baseUrl + request.path)
        
        // クエリパラメータを追加
        if let queryParameters = request.query {
            let queryItems = queryParameters.map { key, value -> URLQueryItem in
                URLQueryItem(name: key, value: "\(value)")
            }
            urlComponents?.queryItems = queryItems
        }

        guard let url = urlComponents?.url else {
            completion(.failure(.invalidResponse))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.method = method
        urlRequest.headers = headers ?? HTTPHeaders()

        if let bodyParameters = request.parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyParameters)
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                completion(.failure(.requestFailed(error)))
                return
            }
        }
        
        AF.request(urlRequest)
        .validate()
        .responseDecodable(of: T.Response.self, decoder: request.decoder) { response in
            let statusCode = response.response?.statusCode ?? -1
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                let data = response.data
                if (200..<300).contains(statusCode) {
                    // ステータスコードは成功だが、デコードに失敗した場合
                    completion(.failure(.decodingError(error)))
                } else if (400..<500).contains(statusCode) {
                    // クライアントエラー
                    completion(.failure(.clientError(statusCode: statusCode, data: data)))
                } else if (500..<600).contains(statusCode) {
                    // サーバーエラー
                    completion(.failure(.serverError(statusCode: statusCode, data: data)))
                } else {
                    // その他のエラー
                    completion(.failure(.unknownError(statusCode: statusCode, data: data, error: error)))
                }
            }
        }
    }
}
