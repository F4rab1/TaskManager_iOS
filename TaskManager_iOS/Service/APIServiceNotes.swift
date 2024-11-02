//
//  APIServiceNotes.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 26.08.2024.
//

import Foundation
import UIKit

class APIServiceNotes {
    
    static let shared = APIServiceNotes()
    
    private let baseURL = "http://127.0.0.1:8000/api/"
    
    var accessToken: String? = AuthManager.shared.accessToken
    
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
    
    func uploadImage(noteID: Int, image: UIImage, completion: @escaping (Bool, Error?) -> Void) {
        guard let url = URL(string: baseURL + "notes/\(noteID)/images/") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        if let token = accessToken {
            request.setValue("JWT \(token)", forHTTPHeaderField: "Authorization")
        }
        
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            completion(false, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Image conversion failed"]))
            return
        }
        
        let body = createBody(imageData: imageData, boundary: boundary)
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                    completion(true, nil)
                } else {
                    if let data = data, let responseBody = String(data: data, encoding: .utf8) {
                        print("Response body: \(responseBody)")
                    }
                    completion(false, NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Upload failed with status code: \(httpResponse.statusCode)"]))
                }
            }
        }.resume()    }
    
    // Helper function to create the body for the multipart request
    private func createBody(imageData: Data, boundary: String) -> Data {
        var body = Data()
        let lineBreak = "\r\n"
        
        body.append("--\(boundary + lineBreak)".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"image_link\"; filename=\"image.jpg\"\(lineBreak)".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\(lineBreak + lineBreak)".data(using: .utf8)!)
        body.append(imageData)
        body.append(lineBreak.data(using: .utf8)!)
        body.append("--\(boundary)--\(lineBreak)".data(using: .utf8)!)
        
        return body
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
