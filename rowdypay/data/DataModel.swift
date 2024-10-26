//
//  DataModel.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import Foundation

class DataModel {
    static func getHelloWorld() {
        guard let url = URL(string: "https://localhost/9000/api/hello_world") else {
            print("URL not found: https://localhost/9000/api/hello_world")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            print(response ?? "no response")
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Server error")
                return
            }

            if let data = data {
                if let responseString = String(data: data, encoding: .utf8) {
                    print(responseString)
                } else {
                    print("Unable to convert data to string.")
                }
            }
        }
    }
}
