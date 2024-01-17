//
//  NetworkClient.swift
//  PetFinder
//
//  Created by Dwi Randy H on 16/01/24.
//

import Foundation

protocol NetworkClient {
    func get<T: Decodable>(from urlProvider: URLProvider) async throws -> T
}

extension NetworkClient {
    static func create() -> NetworkClientImpl {
        return NetworkClientImpl()
    }
}

class NetworkClientImpl: NetworkClient {
    
    func get<T>(from urlProvider: URLProvider) async throws -> T where T : Decodable {
        return try await performRequest(urlProvider: urlProvider, method: .get)
    }
    
    private func performRequest<T: Decodable>(
        urlProvider: URLProvider,
        method: HTTPMethod,
        body: Data? = nil
    ) async throws -> T {
        do {
            var request = try createURLRequest(for: urlProvider)
            request.httpMethod = method.rawValue
            
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.unknown}
            
            switch httpResponse.statusCode {
            case 200..<300:
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: data)
            case 404:
                throw NetworkError.notFound
            case 400:
                throw NetworkError.badRequest
            default:
                throw NetworkError.unknown
            }
        } catch {
            throw error
        }
    }
    
    private func createURLRequest(for urlProvider: URLProvider) throws ->  URLRequest {
        guard let url = urlProvider.url else { throw NetworkError.invalidURL }
        var request: URLRequest = URLRequest(url: url)
        urlProvider.headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        return request
    }
}
