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
    
    var accessToken: String? = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzI0NTcwMDc3LCJpYXQiOjE3MjQ0ODM2NzcsImp0aSI6IjllZTIzNDJlNmI4MjQzMjc5MGYzODMyYWM0MmExY2JjIiwidXNlcl9pZCI6M30.80lml_S0IRblQNx-gXS0pW0_B_iPpiCiEP4ONWWbK6I"
    
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
    
    func fetchNotes(completion: @escaping ([Note]?, Error?) -> ()) {
        
        let urlString = baseURL + "notes/"
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
                let objects = try JSONDecoder().decode([Note].self, from: data!)
                completion(objects, nil)
            } catch {
                completion(nil, error)
            }
            
        }.resume()
        
    }
    
    func deleteNote(noteId: Int, completion: @escaping (Error?) -> ()) {
        let urlString = baseURL + "notes/\(noteId)/"
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
                let statusError = NSError(domain: "", code: (resp as? HTTPURLResponse)?.statusCode ?? 500, userInfo: [NSLocalizedDescriptionKey: "Failed to delete the note."])
                completion(statusError)
            }
        }.resume()
    }
    
}
