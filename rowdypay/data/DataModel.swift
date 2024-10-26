//
//  DataModel.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import Foundation

class DataModel {
    static func getHelloWorld() {
        guard let url = URL(string: "https://e48f-129-115-2-245.ngrok-free.app/api/hello_world") else {
            print("URL not found: https://e48f-129-115-2-245.ngrok-free.app/api/hello_world")
            return
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error performing hello_world: \(error)")
                return
            }
            
            print(response ?? "no response")
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Server error performing hello_world")
                return
            }

            if let data = data {
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response from hello_world: "+responseString)
                } else {
                    print("Unable to convert data to string when performing hello_world.")
                }
            }
        }
        .resume()
    }
    
    
    static func getGroup(id: UUID) -> Group {
        return Group()
    }
    
    static func getPayment(id: UUID) -> Payment {
        return Payment()
    }
    
    static func getUser(id:UUID) -> User{
        return User()
    }
}
