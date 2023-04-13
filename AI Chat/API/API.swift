//
//  API.swift
//  AI Chat
//
//  Created by Johan Wigmo on 2023-04-12.
//

import Foundation

class API {
    static let shared = API()

    private init() {}

    private func request(endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void) {

        guard let url = endpoint.url else {
            completion(.failure(APIError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(UserDefaults.ApiKey)", forHTTPHeaderField: "Authorization")

        if let params = endpoint.params {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params)
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }

            guard let data, let response = response as? HTTPURLResponse else {
                completion(.failure(APIError.invalidResponse))
                return
            }

            guard response.statusCode == 200 else {
                completion(.failure(APIError.statusCode(response.statusCode)))
                return
            }

            completion(.success(data))
        }.resume()
    }

}

extension API {

    func validate(completion: @escaping (Bool, Error?) -> Void) {
        request(endpoint: .gpt_turbo) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    completion(true, nil)
                case .failure(let error):
                    completion(false, error)
                }
            }
        }
    }

    func chat(conversation: Conversation, completion: @escaping (Message?, Error?) -> Void) {
        request(endpoint: .chat(conversation)) { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    DispatchQueue.main.async {
                        completion(response.choices.first?.message, nil)
                    }
                } catch(let error) {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
    }
}

extension API {

    enum APIError: Error {
        case invalidURL
        case invalidResponse
        case statusCode(Int)
    }
}
