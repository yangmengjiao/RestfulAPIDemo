//
//  ViewController.swift
//  RestfulAPIDemo
//
//  Created by mengjiao on 5/11/18.
//  Copyright © 2018 mengjiao. All rights reserved.
//
//Fake Online REST API:https://jsonplaceholder.typicode.com/
//reference: https://mrgott.com/swift-programing/33-rest-api-in-swift-4-using-urlsession-and-jsondecode
import UIKit

struct User: Codable {
    let userId: Int
    let id: Int
    let title: String
}

struct UserPost: Codable {
    let UserName: String
    let Password: String
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getAllEmployee()
        login(with: UserPost(UserName: "peshal", Password: "abcdef")) { (error) in
            print("error login")
        }
    }
    
    //get all employee demo
    func getAllEmployee (){
        let urlString = "https://jsonplaceholder.typicode.com/albums"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            //Implement JSON decoding and parsing
            do {
                //Decode retrived data with JSONDecoder and assing type of Article object
                let userData = try JSONDecoder().decode([User].self, from: data)
                print(userData[0].title)
                //Get back to the main queue
                DispatchQueue.main.async {
                    //update your ui
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            
            }.resume()
    }
    
    
    //post with parameter demo: login
    func login(with userpost: UserPost, completion:((Error?) -> Void)?) {
        
        guard let url = URLHelper.sharedInstance.getLoginURL() else { fatalError("Could not create URL from components") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // will be JSON encoded
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        //let's encode out Post struct into JSON data...
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(userpost)
            request.httpBody = jsonData
            print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        } catch {
            completion?(error)
        }
        
        // Create and run a URLSession data task with our JSON encoded POST request
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                completion?(responseError!)
                return
            }
            if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                print("response: ", utf8Representation)
            } else {
                print("no readable data received in response")
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

