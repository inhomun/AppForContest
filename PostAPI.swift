//
//  PostAPI.swift
//  SKHUAZ
//
//  Created by 박신영 on 2023/04/09.
//

import Foundation
import Combine
import Alamofire
import SwiftyJSON

class PostAPI: ObservableObject {
    
    static let shared = PostAPI()
//    @Published var result: [Results] = []
    //    private init() { }
    //    @Published var posts = [Article]()
    
    
    
    func postMethod(parameters: [String: Any]) {
        guard let url = URL(string: "http://skhuaz.duckdns.org/save/evaluation") else {
            print("Error: cannot create URL")
            return
        }
        
        
        // Add data to the model
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let posts = try String(data: data, encoding: .utf8)!
                DispatchQueue.main.async {
                    print(posts)
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
}


class PostData: ObservableObject {
    @Published var lectureName: String = ""
    @Published var prfsName: String = ""
    @Published var classYear: Int = 0
    @Published var semester: Int = 0
    @Published var is_major_required: Bool = false
    @Published var department: String = ""
    @Published var teamPlay: String = ""
    @Published var task: String = ""
    @Published var practice: String = ""
    @Published var presentation: String = ""
    @Published var review: String = ""
    
    func setData(from response: PostData) {
        lectureName = response.lectureName
        prfsName = response.prfsName
        classYear = response.classYear
        semester = response.semester
        is_major_required = response.is_major_required
        department = response.department
        teamPlay = response.teamPlay
        task = response.task
        practice = response.practice
        presentation = response.presentation
        review = response.review
    }
}

