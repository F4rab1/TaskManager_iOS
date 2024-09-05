//
//  APIService.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 27.07.2024.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    
    private let baseURL = "http://127.0.0.1:8000/api/"
    
    var accessToken: String? = AuthManager.shared.accessToken
    
    func get(endpoint: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
                completion(.failure(error))
                return
            }
            
            let statusCode = httpResponse.statusCode
            if 200...299 ~= statusCode {
                if let data = data {
                    completion(.success(data))
                } else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Empty response data"])
                    completion(.failure(error))
                }
            } else {
                let error = NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Request failed with status code: \(statusCode)"])
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getWithToken(endpoint: String, token: String?, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = token {
            request.addValue("JWT \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
                completion(.failure(error))
                return
            }
            
            let statusCode = httpResponse.statusCode
            if 200...299 ~= statusCode {
                if let data = data {
                    completion(.success(data))
                } else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Empty response data"])
                    completion(.failure(error))
                }
            } else {
                let error = NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Request failed with status code: \(statusCode)"])
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func post(endpoint: String, parameters: [String: Any], completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
                completion(.failure(error))
                return
            }
            
            let statusCode = httpResponse.statusCode
            if 200...299 ~= statusCode {
                if let data = data {
                    completion(.success(data))
                } else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Empty response data"])
                    completion(.failure(error))
                }
            } else {
                let error = NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Request failed with status code: \(statusCode)"])
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func postWithToken(endpoint: String, parameters: [String: Any], token: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue("JWT \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
                completion(.failure(error))
                return
            }
            
            let statusCode = httpResponse.statusCode
            if 200...299 ~= statusCode {
                if let data = data {
                    completion(.success(data))
                } else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Empty response data"])
                    completion(.failure(error))
                }
            } else {
                let error = NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Request failed with status code: \(statusCode)"])
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func putWithToken(endpoint: String, parameters: [String: Any], token: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue("JWT \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
                completion(.failure(error))
                return
            }
            
            let statusCode = httpResponse.statusCode
            if 200...299 ~= statusCode {
                if let data = data {
                    completion(.success(data))
                } else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Empty response data"])
                    completion(.failure(error))
                }
            } else {
                let error = NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Request failed with status code: \(statusCode)"])
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func delete(endpoint: String, token: String?, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = token {
            request.addValue("JWT \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
                completion(.failure(error))
                return
            }
            
            let statusCode = httpResponse.statusCode
            if 200...299 ~= statusCode {
                if let data = data {
                    completion(.success(data))
                } else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Empty response data"])
                    completion(.failure(error))
                }
            } else {
                let error = NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Request failed with status code: \(statusCode)"])
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchTasks(completion: @escaping (Tasks?, Error?) -> ()) {
        
        let urlString = baseURL + "tasks/"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let token = accessToken {
            request.setValue("JWT \(token)", forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: request) { (data, resp, err) in
            
            if let err = err {
                completion(nil, err)
                return
            }
            
            do {
                let objects = try JSONDecoder().decode(Tasks.self, from: data!)
                completion(objects, nil)
            } catch {
                completion(nil, error)
            }
            
        }.resume()
        
    }
    
    func fetchTasksByCompletionDate(completionDate: String, completion: @escaping (Tasks?, Error?) -> ()) {
        
        let urlString = baseURL + "tasks/?completion_date=" + completionDate
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let token = accessToken {
            request.setValue("JWT \(token)", forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: request) { (data, resp, err) in
            
            if let err = err {
                completion(nil, err)
                return
            }
            
            do {
                let objects = try JSONDecoder().decode(Tasks.self, from: data!)
                completion(objects, nil)
            } catch {
                completion(nil, error)
            }
            
        }.resume()
        
    }
    
    func deleteTask(taskId: Int, completion: @escaping (Error?) -> ()) {
        let urlString = baseURL + "tasks/\(taskId)/"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        if let token = accessToken {
            request.setValue("JWT \(token)", forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: request) { (_, resp, err) in
            if let err = err {
                completion(err)
                return
            }
            
            if let httpResponse = resp as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
                completion(nil)
            } else {
                let statusError = NSError(domain: "", code: (resp as? HTTPURLResponse)?.statusCode ?? 500, userInfo: [NSLocalizedDescriptionKey: "Failed to delete the task."])
                completion(statusError)
            }
        }.resume()
    }
    
    func fetchAndStoreCategories(completion: @escaping (Error?) -> ()) {
        
        let urlString = baseURL + "categories/"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let token = accessToken {
            request.setValue("JWT \(token)", forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let categories = try JSONDecoder().decode([Category].self, from: data)
                let categoryDict = categories.reduce(into: [String: String]()) { dict, category in
                    dict[String(category.id)] = category.title
                }
                UserDefaults.standard.set(categoryDict, forKey: "categories")
                completion(nil)
            } catch {
                completion(error)
            }
        }.resume()
    }
    
}
