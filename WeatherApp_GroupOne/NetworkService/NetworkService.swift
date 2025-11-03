//
//  NetworkService.swift
//  WeatherApp_GroupOne
//
//  Created by Tatarella on 02.11.25.
//


import Foundation

class NetworkService {

    static let shared = NetworkService()

    func getData<T: Decodable>(baseURL: String, completion: @escaping (Result<T,Error>) -> (Void)) {

        guard let url = URL(string: baseURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidURL))
                return
            }

            guard (200...299).contains(response.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {

                let decoder = JSONDecoder()
                let object = try decoder.decode(T.self, from: data)
                completion(.success(object))

            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }

        }.resume()
    }
    
    
    //TODO: რეაფქტორი დასჭირდებააა!!!
    
    func postData<T: Decodable, RequestBody: Encodable>(baseURL: String, requestBody: RequestBody, completion: @escaping (Result<T,Error>) -> (Void)) {
        
        guard let url = URL(string: baseURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(requestBody)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("0615b08668d323d4353be6dc4e773d79", forHTTPHeaderField: "X-Api-Key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidURL))
                return
            }

            guard (200...299).contains(response.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {

                let decoder = JSONDecoder()
                let object = try decoder.decode(T.self, from: data)
                completion(.success(object))

            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }

        }.resume()
    }
}
