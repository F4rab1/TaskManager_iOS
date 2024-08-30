//
//  APIServiceNotes.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 26.08.2024.
//

import Foundation

class APIServiceNotes {
    
    static let shared = APIServiceNotes()
    
    private let baseURL = "http://127.0.0.1:8000/api/"
    
    var accessToken: String? = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzI1MTI5NDk4LCJpYXQiOjE3MjUwNDMwOTgsImp0aSI6ImQ5NDRhMDRlMzIyZjQ5MGRhYjEwNGY2YjQxODRiMWFkIiwidXNlcl9pZCI6M30.I08Z7M_ka3W7HO4hDaJK5fkwHAiaXS3I35-aEwgel88"
    
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
    
    func postNote(title: String, text: String, completion: @escaping (Note?, Error?) -> ()) {
        
        let urlString = baseURL + "notes/"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = accessToken {
            request.setValue("JWT \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let parameters = ["title": title, "text": text]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion(nil, error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, resp, err) in
            
            if let err = err {
                completion(nil, err)
                return
            }
            
            do {
                let note = try JSONDecoder().decode(Note.self, from: data!)
                print(note)
                completion(note, nil)
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
