//
//  NetworkService.swift
//  ChucksWisdom
//
//  Created by Apple Mac Air on 15.03.2024.
//

import Foundation

final class NetworkService {
    
    let url = URL(string: "https://api.chucknorris.io/jokes/random")
    
    func requestValue(completion: @escaping (String, [String]) -> Void) {
        
        let request = URLRequest(url: url!)
        let session  = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let HTTPResponse = response as? HTTPURLResponse {
                switch HTTPResponse.statusCode {
                case 200:
                    guard let data = data else {
                        return
                    }
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                            if let joke = json ["value"] as? String, let categories = json ["categories"] as? [String] {
                                completion(joke, categories)
                            }
                        }
                    } catch {
                        print (error.localizedDescription)
                    }
                case 404:
                    print("error")
                default:
                    break
                }
            }
        }
        dataTask.resume()
    }
}
