//
//  DataModel.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import Foundation

class DataModel {
    //MARK: HELLO WORLD
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
    
    // MARK: GET GROUP
    static func getGroup(id: Int, completion: @escaping (Group) -> Void) {
        guard let url = URL(string: "https://e48f-129-115-2-245.ngrok-free.app/api/get_group") else {
            print("URL not found: https://e48f-129-115-2-245.ngrok-free.app/api/get_group")
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
                
                print(response ?? "no response")
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
                        print("Something went wrong with JSON parsing: \(error)")
                    }
                }
            }
            .resume()
        } catch {
            print("Error encoding JSON while doing get_group.")
        }
    }
    
    //MARK: GET USER
    static func getUser(id: Int, completion: @escaping (User) -> Void) {
        guard let url = URL(string: "https://e48f-129-115-2-245.ngrok-free.app/api/get_user") else {
            print("URL not found: https://e48f-129-115-2-245.ngrok-free.app/api/get_user")
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
                    return
                }
                
                print(response ?? "no response")
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Server error performing get_user")
                    return
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let user = try decoder.decode(User.self, from: data)
                        completion(user)
                    } catch {
                        print("Something went wrong with JSON parsing: \(error)")
                    }
                }
            }
            .resume()
        } catch {
            print("Error encoding JSON while doing get_user.")
        }
    }

    //MARK: GET PAYMENT
    static func getPayment(id: Int, completion: @escaping (Payment) -> Void) {
        guard let url = URL(string: "https://e48f-129-115-2-245.ngrok-free.app/api/get_payment") else {
            print("URL not found: https://e48f-129-115-2-245.ngrok-free.app/api/get_payment")
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
                        print("Something went wrong with JSON parsing: \(error)")
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
        guard let url = URL(string: "https://e48f-129-115-2-245.ngrok-free.app/api/get_payments") else {
            print("URL not found: https://e48f-129-115-2-245.ngrok-free.app/api/get_payments")
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
                        print("Something went wrong with JSON parsing: \(error)")
                    }
                }
            }
            .resume()
        } catch {
            print("Error encoding JSON while getting payments from user id.")
        }
    }
    
    //MARK: GET GROUPS FROM USER
    static func getPaymentsFromUser(id: Int, completion: @escaping ([Group]) -> Void) {
        guard let url = URL(string: "https://e48f-129-115-2-245.ngrok-free.app/api/get_groups") else {
            print("URL not found: https://e48f-129-115-2-245.ngrok-free.app/api/get_groups")
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
                    print("Error performing get_groups: \(error)")
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Server error performing get_groups")
                    return
                }

                if let data = data {
                    do {
                        // Try to convert to an array of dictionaries
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dict = json as? [[String: Any]] {
                            var groups: [Group] = []
                            
                            for g in dict {
                                do {
                                    // Convert dictionary to JSON data
                                    let groupData = try JSONSerialization.data(withJSONObject: g, options: [])
                                    
                                    // Decode the JSON data into a Payment object
                                    let group = try JSONDecoder().decode(Group.self, from: groupData)
                                    groups.append(group)
                                } catch {
                                    print("Error decoding group: \(error)")
                                }
                            }

                            // Call the completion handler with the payments array
                            completion(groups)
                        } else {
                            print("Failed parsing JSON as array of dictionaries")
                        }
                    } catch {
                        print("Something went wrong with JSON parsing: \(error)")
                    }
                }
            }
            .resume()
        } catch {
            print("Error encoding JSON while getting payments from user id.")
        }
    }
}
