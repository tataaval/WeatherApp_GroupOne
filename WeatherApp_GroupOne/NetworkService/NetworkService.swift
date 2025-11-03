//
//  NetworkService.swift
//  WeatherApp_GroupOne
//
//  Created by Tatarella on 02.11.25.
//


import Foundation

import Foundation

class NetworkService {

    static let shared = NetworkService()

    private func execute<T: Decodable>(with request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                completion(
                    .failure(
                        NetworkError.invalidStatusCode(httpResponse.statusCode)
                    )
                )
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }

        }.resume()
    }

    func getData<T: Decodable>(
        baseURL: String,
        completion: @escaping (Result<T, Error>) -> (Void)
    ) {

        guard let url = URL(string: baseURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let request = URLRequest(url: url)
        execute(with: request, completion: completion)
    }

    func postData<T: Decodable, RequestBody: Encodable>(baseURL: String, requestBody: RequestBody, completion: @escaping (Result<T, Error>) -> (Void)) {

        guard let url = URL(string: baseURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(requestBody)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("0615b08668d323d4353be6dc4e773d79", forHTTPHeaderField: "X-Api-Key")
        
        execute(with: request, completion: completion)

    }
}

