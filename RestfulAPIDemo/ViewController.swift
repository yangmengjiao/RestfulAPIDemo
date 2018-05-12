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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

