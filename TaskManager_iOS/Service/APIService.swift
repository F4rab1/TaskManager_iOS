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
    
    func fetchTasks(completion: @escaping (Tasks?, Error?) -> ()) {
        
        let urlString = baseURL + "tasks/"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
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
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
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
    
}
