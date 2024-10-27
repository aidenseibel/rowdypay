//
//  DataModel.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import Foundation
import UIKit
import OpenAI

class DataModel {

    //MARK: HELLO WORLD
    static func getHelloWorld() {
        guard let url = URL(string: "https://f781-129-115-2-245.ngrok-free.app/api/hello_world") else {
            print("URL not found: https://f781-129-115-2-245.ngrok-free.app/api/hello_world")
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
    
    // MARK: GET GROUP
    static func getGroup(id: Int, completion: @escaping (Group) -> Void) {
        guard let url = URL(string: "https://f781-129-115-2-245.ngrok-free.app/api/get_group") else {
            print("URL not found: https://f781-129-115-2-245.ngrok-free.app/api/get_group")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any] = ["group_id": id]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error performing get_group: \(error)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Server error performing get_group")
                    return
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let group = try decoder.decode(Group.self, from: data)
                        completion(group)
                    } catch {
                        print("Something went wrong with JSON parsing group: \(error)")
                        if let responseString = String(data: data, encoding: .utf8){
                            print(responseString)
                        }
                    }
                }
            }
            .resume()
        } catch {
            print("Error encoding JSON while doing get_group.")
        }
    }
    
    //MARK: GET USER
    static func getUser(id: Int, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: "https://f781-129-115-2-245.ngrok-free.app/api/get_user") else {
            print("URL not found: https://f781-129-115-2-245.ngrok-free.app/api/get_user")
            completion(.failure(URLError(.badURL)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any] = ["user_id": id]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error performing get_user: \(error)")
                    completion(.failure(error))
                    return
                }
                
                print(response ?? "no response")
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Server error performing get_user")
                    completion(.failure(URLError(.badServerResponse)))
                    return
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let user = try decoder.decode(User.self, from: data)
                        completion(.success(user))
                    } catch {
                        print("Something went wrong with JSON parsing user: \(error)")
                        completion(.failure(error))
                    }
                }
            }
            .resume()
        } catch {
            print("Error encoding JSON while doing get_user.")
            completion(.failure(error))
        }
    }

    //MARK: GET PAYMENT
    static func getPayment(id: Int, completion: @escaping (Payment) -> Void) {
        guard let url = URL(string: "https://f781-129-115-2-245.ngrok-free.app/api/get_payment") else {
            print("URL not found: https://f781-129-115-2-245.ngrok-free.app/api/get_payment")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any] = ["payment_id": id]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error performing get_payment: \(error)")
                    return
                }
                
                print(response ?? "no response")
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Server error performing get_payment")
                    return
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let payment = try decoder.decode(Payment.self, from: data)
                        completion(payment)
                    } catch {
                        print("Something went wrong with JSON parsing payment: \(error)")
                    }
                }
            }
            .resume()
        } catch {
            print("Error encoding JSON while doing get_payment.")
        }
    }

    //MARK: GET PAYMENTS FROM USER
    static func getPaymentsFromUser(id: Int, completion: @escaping ([Payment]) -> Void) {
        guard let url = URL(string: "https://f781-129-115-2-245.ngrok-free.app/api/get_user_payments") else {
            print("URL not found: https://f781-129-115-2-245.ngrok-free.app/api/get_user_payments")
            return
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any] = ["user_id": id]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error performing get_payments: \(error)")
                    return
                }

                print(response)
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Server error performing get_payments")
                    return
                }

                if let data = data {
                    do {
                        // Try to convert to an array of dictionaries
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dict = json as? [[String: Any]] {
                            var payments: [Payment] = []
                            
                            for p in dict {
                                do {
                                    // Convert dictionary to JSON data
                                    let paymentData = try JSONSerialization.data(withJSONObject: p, options: [])
                                    
                                    // Decode the JSON data into a Payment object
                                    let payment = try JSONDecoder().decode(Payment.self, from: paymentData)
                                    payments.append(payment)
                                } catch {
                                    print("Error decoding payment: \(error)")
                                }
                            }
                            
                            // Call the completion handler with the payments array
                            completion(payments)
                        } else {
                            print("Failed parsing JSON as array of dictionaries")
                        }
                    } catch {
                        print("Something went wrong with JSON parsing payments from user: \(error)")
                    }
                }
            }
            .resume()
        } catch {
            print("Error encoding JSON while getting payments from user id.")
        }
    }
    
    //MARK: GET PAYMENTS FROM GROUP
    static func getPaymentsFromGroup(id: Int, completion: @escaping ([Payment]) -> Void) {
        guard let url = URL(string: "https://f781-129-115-2-245.ngrok-free.app/api/get_group_payments") else {
            print("URL not found: https://f781-129-115-2-245.ngrok-free.app/api/get_group_payments")
            return
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any] = ["group_id": id]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error performing get_group_payment: \(error)")
                    return
                }

                print(response)
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Server error performing get_group_payment")
                    return
                }

                if let data = data {
                    do {
                        // Try to convert to an array of dictionaries
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dict = json as? [[String: Any]] {
                            var payments: [Payment] = []
                            
                            for p in dict {
                                do {
                                    // Convert dictionary to JSON data
                                    let paymentData = try JSONSerialization.data(withJSONObject: p, options: [])
                                    
                                    // Decode the JSON data into a Payment object
                                    let payment = try JSONDecoder().decode(Payment.self, from: paymentData)
                                    payments.append(payment)
                                } catch {
                                    print("Error decoding payment: \(error)")
                                }
                            }
                            
                            // Call the completion handler with the payments array
                            completion(payments)
                        } else {
                            print("Failed parsing JSON as array of dictionaries")
                        }
                    } catch {
                        print("Something went wrong with JSON parsing get_group_payment: \(error)")
                    }
                }
            }
            .resume()
        } catch {
            print("Error encoding JSON while getting get_group_payment.")
        }
    }
    
    //MARK: GET GROUPS FROM USER
    static func getGroupsFromUser(id: Int, completion: @escaping ([Group]) -> Void) {
        
        guard let url = URL(string: "https://f781-129-115-2-245.ngrok-free.app/api/get_groups") else {
            print("DataModel: Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any] = ["user_id": id]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
            
            print("DataModel: Making network request...")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("DataModel: Network error:", error)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("DataModel: Response status code:", httpResponse.statusCode)
                }
                
                if let data = data {
                    print("DataModel: Received data:", String(data: data, encoding: .utf8) ?? "")
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print("DataModel: Parsed JSON:", json)
                        
                        if let dict = json as? [[String: Any]] {
                            var groups: [Group] = []
                            
                            for g in dict {
                                do {
                                    let groupData = try JSONSerialization.data(withJSONObject: g)
                                    let group = try JSONDecoder().decode(Group.self, from: groupData)
                                    groups.append(group)
                                } catch {
                                    print("DataModel: Error decoding group:", error)
                                }
                            }
                            
                            print("DataModel: Successfully decoded \(groups.count) groups")
                            completion(groups)
                        } else {
                            print("DataModel: Failed to parse JSON as array")
                            completion([])
                        }
                    } catch {
                        print("DataModel: JSON parsing error:", error)
                        completion([])
                    }
                }
            }.resume()
        } catch {
            print("DataModel: JSON encoding error:", error)
        }
    }
    
    //MARK: GET USERS FROM GROUP
    static func getUsersFromGroup(id: Int, completion: @escaping ([User]) -> Void) {
        print("Starting getUsersFromGroup for group ID:", id)
        
        guard let url = URL(string: "https://f781-129-115-2-245.ngrok-free.app/api/get_users_by_group") else {
            print("URL not found: https://f781-129-115-2-245.ngrok-free.app/api/get_users_by_group")
            return
        }
                    
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any] = ["group_id": id]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
            print("Sending request with group_id:", id)

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Network error:", error)
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                    print("Response status code:", httpResponse.statusCode)
                }

                if let data = data {
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print("Parsed JSON:", json)
                        
                        if let dict = json as? [[String: Any]] {
                            print("Number of users in response:", dict.count)
                            var users: [User] = []
                            
                            for (index, u) in dict.enumerated() {
                                do {
                                    let userData = try JSONSerialization.data(withJSONObject: u)
                                    let user = try JSONDecoder().decode(User.self, from: userData)
                                    print("Successfully decoded user \(index + 1):", user.username)
                                    users.append(user)
                                } catch {
                                    print("Error decoding user \(index + 1):", error)
                                    print("Problem user data:", u)
                                }
                            }

                            print("Final number of decoded users:", users.count)
                            print("User names:", users.map { $0.username })
                            completion(users)
                        } else {
                            print("Failed to parse JSON as array. Actual type:", type(of: json))
                        }
                    } catch {
                        print("JSON parsing error:", error)
                    }
                } else {
                    print("No data received from server")
                }
            }
            .resume()
        } catch {
            print("Request creation error:", error)
        }
    }
    static func getBalances(userID: Int, groupID: Int, completion: @escaping (Result<Double, Error>) -> Void) {
        guard let url = URL(string: "https://f781-129-115-2-245.ngrok-free.app/api/get_balance") else {
            print("URL not found: https://f781-129-115-2-245.ngrok-free.app/api/get_balance")
            completion(.failure(URLError(.badURL)))
            return
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "user_id": userID,
            "group_id": groupID
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(URLError(.zeroByteResource)))
                }
                return
            }
            
            // Print raw response and HTTP status
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
            if let responseString = String(data: data, encoding: .utf8) {
                print("Raw response: \(responseString)")
            }
            
            // Try to decode the float value
            do {
                let decoder = JSONDecoder()
                let balance = try decoder.decode(Float.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(Double(balance)))
                }
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
    // MARK: SUBMIT REQUEST (RETURN SUCCESS)
    static func updateBalances(userID: Int, userIDs: [Int], groupID: Int, amount: Double, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://f781-129-115-2-245.ngrok-free.app/api/update_balances") else {
            print("URL not found: https://f781-129-115-2-245.ngrok-free.app/api/update_balances")
            return
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any] = ["submitter_id": userID, "group_id": groupID, "user_ids": userIDs, "amt": amount]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error performing update_balances: \(error)")
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Server error performing update_balances")
                    return
                }

                if let data = data {
                    if let responseString = String(data: data, encoding: .utf8) {
                        if responseString == "true"{
                            completion(true)
                        }
                    }
                    
                    completion(false)
                }
            }
            .resume()
        } catch {
            print("Error encoding JSON while update_balances.")
        }
    }
    static func leavingGroup(userID:Int, groupID:Int, completion: @escaping(Bool) ->Void){
        guard let url = URL(string: "https://f781-129-115-2-245.ngrok-free.app/api/leave_group") else {
            print("URL not found: https://f781-129-115-2-245.ngrok-free.app/api/leave_group")
            completion(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var parameters: [String: Any] = [
            "user_id": userID,
            "group_id": groupID,
        ]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Leave Group error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    if let httpResponse = response as? HTTPURLResponse {
                        print("Server error leaving group. Status code: \(httpResponse.statusCode)")
                    } else {
                        print("Server error leaving group. No response received.")
                    }
                    completion(false)
                    return
                }
                

                completion(true)
            }
            .resume()
        } catch {
            print("Error encoding JSON: \(error.localizedDescription)")
            completion(false)
        }
    }

    
    static func makePayment(userID: Int, groupID: Int, amount: Double, description: String? = nil, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://f781-129-115-2-245.ngrok-free.app/api/make_payment") else {
            print("URL not found: https://f781-129-115-2-245.ngrok-free.app/api/make_payment")
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var parameters: [String: Any] = [
            "user_id": userID,
            "group_id": groupID,
            "amt": amount
        ]
        
        if let desc = description {
            parameters["description"] = desc
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Payment request error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    if let httpResponse = response as? HTTPURLResponse {
                        print("Server error making payment. Status code: \(httpResponse.statusCode)")
                    } else {
                        print("Server error making payment. No response received.")
                    }
                    completion(false)
                    return
                }
                
                // Handle the response data if needed
                // ...
                
                completion(true)
            }
            .resume()
        } catch {
            print("Error encoding JSON: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    static func createGroup(groupName: String, image: String, users:[Int],creatorID:Int, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://f781-129-115-2-245.ngrok-free.app/api/create_group") else {
            print("URL not found: https://f781-129-115-2-245.ngrok-free.app/api/create_group")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var parameters: [String: Any] = [
            "name": groupName,
            "img": image,
            "user_ids":users,
            "creator_id":creatorID
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Create Group error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    if let httpResponse = response as? HTTPURLResponse {
                        print("Server error Creating Group. Status code: \(httpResponse.statusCode)")
                    } else {
                        print("Server error Create Group. No response received.")
                    }
                    completion(false)
                    return
                }
                
                // Handle the response data if needed
                // ...
                
                completion(true)
            }
            .resume()
        } catch {
            print("Error encoding JSON: \(error.localizedDescription)")
            completion(false)
        }
    }
    //MARK: SEND IMAGE FOR ANALYSIS
    static func sendImageToOpenAI(image: UIImage, completion: @escaping (Bool, Double) -> Void) {
        let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 512, height: 512))
        
        let api_key : String = "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"
        
        guard let imageData = resizedImage.jpegData(compressionQuality: 0.5)?.base64EncodedString() else {
            return
        }
        
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(api_key)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let jsonBody: [String: Any] = [
            "model": "gpt-4o", // Specify the model you want to use
            "messages": [
                [
                    "role": "user",
                    "content": [
                        [
                            "type": "text",
                            "text": "Determine if this image is a receipt. If it is a receipt, give the total charge. Output the result as a JSON object with the fields is_receipt as a bool and total_charge as a double."
                        ],
                        [
                            "type": "image_url",
                            "image_url": [
                                "url": "data:image/jpg;base64,\(imageData)" // Use correct Swift string interpolation
                            ]
                        ]
                    ]
                ]
            ]
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: jsonBody, options: [])
        } catch {
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Response status code: \(response.statusCode)")
            }

            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let completionResponse = try decoder.decode(ChatCompletionResponse.self, from: data)

                    if let firstChoice = completionResponse.choices.first {
                        let content = firstChoice.message.content
                        let startIndex = content.index(content.startIndex, offsetBy: 7) // 8th character (0-based index)
                        let endIndex = content.index(content.endIndex, offsetBy: -4) // 4th character from the end

                        // Create the substring
                        let substring = content[startIndex..<endIndex]
                        
                        print(substring)
                        
                        if let jsonData = substring.data(using: .utf8) {
                            let receiptInfo = try decoder.decode(ReceiptInfo.self, from: jsonData)
                            
                            // Call the completion handler with parsed results
                            completion(receiptInfo.isReceipt, Double(receiptInfo.totalCharge))
                        }
                    }
                } catch {
                    print("Error decoding response: \(error)")
                }
            }
        }.resume()
    }

    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Determine what ratio to use to ensure the image is scaled properly
        let ratio = min(widthRatio, heightRatio)

        // Calculate the new size
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)

        // Resize the image
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
    static func createUser(display_name: String, email: String, completion: @escaping (User) -> Void) {
        guard let url = URL(string: "https://f781-129-115-2-245.ngrok-free.app/api/create_user") else {
            print("URL not found: https://f781-129-115-2-245.ngrok-free.app/api/create_user")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any] = ["display_name": display_name, "email": email]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error performing create_user: \(error)")
                    return
                }
                
                print(response ?? "no response")
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Server error performing create_user")
                    return
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let user = try decoder.decode(User.self, from: data)
                        completion(user)
                    } catch {
                        print("Something went wrong with JSON parsing create_user: \(error)")
                        return
                    }
                }
            }
            .resume()
        } catch {
            print("Error encoding JSON while doing create_user.")
            return
        }
    }
    
    static func authUser(email: String, completion: @escaping (User) -> Void) {
        guard let url = URL(string: "https://f781-129-115-2-245.ngrok-free.app/api/auth_user") else {
            print("URL not found: https://f781-129-115-2-245.ngrok-free.app/api/auth_user")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any] = ["email": email]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error performing auth_user: \(error)")
                    return
                }
                
                print(response ?? "no response")
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Server error performing auth_user")
                    return
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let user = try decoder.decode(User.self, from: data)
                        completion(user)
                    } catch {
                        print("Something went wrong with JSON parsing user: \(error)")
                        return
                    }
                }
            }
            .resume()
        } catch {
            print("Error encoding JSON while doing auth_user.")
            return
        }
    }
}
