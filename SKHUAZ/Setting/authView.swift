////
////  authView.swift
////  pbch
////
////  Created by 문인호 on 2023/03/13.
////
//
//import Foundation
//import SwiftUI
//
//struct authView: View {
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var showAlert: Bool = false
//    @State private var alertMessage: String = ""
//    @State private var isLoggedIn: Bool = false
//    @EnvironmentObject var userData: UserData
//    @State private var isactive:Bool = false
//    var body: some View {
//
//        VStack{
//            Image("skhuazbanner")
//                .resizable()
//                .frame(width: 400, height: 200)
//                .padding(.bottom, 5)
//            Spacer()
//            HStack{
//                Text("본인인증")
//                    .padding(.leading, 30)
//                    .font(.system(size: 14))
//                    .foregroundColor(.black)
//                    .lineLimit(2)
//                Spacer()
//            }
//            TextField("이메일을 입력해주세요", text: $email)
//                .padding()
//                .frame(width: 350, height: 50)
//                .background(Color(uiColor: .secondarySystemBackground))
//                .cornerRadius(10)
//                .autocapitalization(.none) // 자동으로 대문자 설정 안하기
//                .keyboardType(.emailAddress)
//            SecureField("비밀번호를 입력해주세요", text: $password)
//                .padding()
//                .frame(width: 350, height: 50)
//                .background(Color(uiColor: .secondarySystemBackground))
//                .cornerRadius(10)
//                .autocapitalization(.none) // 자동으로 대문자 설정 안하기
//            Button(action: {
//                isactive = true
//                if userData.email == email {
//                    // Set isLoggedIn to true
//                    isLoggedIn = true
//                    // Show success alert
//                    showAlert = true
//                    alertMessage = "옳은 이메일과 비밀번호입니다."
//                } else {
//                    // Set isLoggedIn to false
//                    isLoggedIn = false
//                    // Show failure alert
//                    showAlert = true
//                    alertMessage = "이메일 혹은 비밀번호가 일치하지 않습니다."
//                }
////                self.presentationMode.wrappedValue.dismiss()
//            }) {
//                Text("본인인증")
//                    .frame(width: 330, height: 10)
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color(red: 0.603, green: 0.756, blue: 0.819))
//                    .cornerRadius(10)
//            }
//            .padding(.top)
////            .alert(isPresented: $showAlert) {
////                Alert(title: Text("알림"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
////            }
//            NavigationLink(destination: sample(), isActive: $isactive) {
//
//                EmptyView()
//            }
//            Spacer()
//            Spacer()
//        }
//    }
//}
//
//struct LoginResult: Codable {
//    let success: Bool
//    let message: String
//}
//
//func fetchLoginStatus(email: String, password: String, completionHandler: @escaping (Bool, String?) -> Void) {
//    // API endpoint
//    let urlString = "http://skhuaz.duckdns.org/check-login"
//
//    // 요청 생성
//    var request = URLRequest(url: URL(string: urlString)!)
//    request.httpMethod = "GET"
//
//    // 요청 파라미터 설정
//    let params: [String: Any] = [
//        "email": email,
//        "password": password
//    ]
//    request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
//    // 세션 생성
//    let session = URLSession.shared
//    // 데이터 태스크 실행
//    let task = session.dataTask(with: request) { data, response, error in
//        if let error = error {
//            print("Error: \(error.localizedDescription)")
//            completionHandler(false, "네트워크 오류가 발생했습니다.")
//            return
//        }
//        if let data = data {
//            do {
//                let decoder = JSONDecoder()
//                let result = try decoder.decode(LoginResult.self, from: data)
//                print(result)
//                if result.success {
//                    completionHandler(true, "옳은 이메일과 비밀번호입니다.")
//                } else {
//                    completionHandler(false, "이메일 혹은 비밀번호가 일치하지 않습니다.")
//                        print(result)
//                }
//            } catch {
//                completionHandler(false, "응답을 처리하는데 실패했습니다.")
//            }
//        } else {
//            completionHandler(false, "응답이 없습니다.")
//        }
//    }
//    task.resume()
//}
//

import SwiftUI

//struct authView: View {import SwiftUI

struct authView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var userData: UserData
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var fetchLoginStatus = false // New state variable for login status
    
    var body: some View {
        VStack{
            Image("skhuazbanner")
                .resizable()
                .frame(width: 400, height: 200)
                .padding(.bottom, 5)
            Spacer()
            HStack{
                Text("본인인증")
                    .padding(.leading, 30)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                    .lineLimit(2)
                Spacer()
            }
            TextField("이메일을 입력해주세요", text: $email)
                .padding()
                .frame(width: 350, height: 50)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(10)
                .keyboardType(.emailAddress)
            SecureField("비밀번호를 입력해주세요", text: $password)
                .padding()
                .frame(width: 350, height: 50)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(10)
            Button(action: {
                if userData.email == email{
                    LoginStatus()
                }
                else{
                    alertMessage = "이메일 혹은 비밀번호가 올바르지 않습니다"
                    self.showAlert = true
                }
            }) {
                Text("본인인증")
                    .frame(width: 330, height: 10)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(red: 0.603, green: 0.756, blue: 0.819))
                    .cornerRadius(10)
                    .fullScreenCover(isPresented: $fetchLoginStatus, content: {
                        // editProfileView()로 화면 전환
                        editProfileView()
//                        sample()
                    })
            }
            .padding(.top)
            Spacer()
            Spacer()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("오류"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
        }
    }
    
    func LoginStatus() {
        // 입력한 이메일과 비밀번호를 쿼리 매개 변수로 사용하여 URL 생성
        let urlString = "http://skhuaz.duckdns.org/check-login?email=\(email)&password=\(password)"
        
        // URL 객체 생성
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            // 세션 ID를 헤더에 추가
            let sessionId = userData.sessionId
            request.addValue(sessionId, forHTTPHeaderField: "sessionId")
            
            // URLSession을 사용하여 HTTP 요청 보내기
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    print("HTTP 상태 코드: \(statusCode)")
                }
                
                if let data = data {
                    // 서버로부터 응답 데이터를 처리하는 로직 추가
                    let responseString = String(data: data, encoding: .utf8) ?? ""
                    if responseString == "true" {
                        // 서버 응답이 true인 경우, fetchLoginStatus를 true로 변경하여 화면 전환
                        DispatchQueue.main.async {
                            fetchLoginStatus = true
                        }
                    } else {
                        // 서버 응답이 false인 경우, alert를 표시하는 로직 추가
                        DispatchQueue.main.async {
                            self.alertMessage = "이메일 혹은 비밀번호가 일치하지 않습니다."
                            self.showAlert = true
                        }
                    }
                } else if let error = error {
                    // 에러 처리 로직 추가
                    print("에러: \(error.localizedDescription)")
                }
            }.resume()
        }
    }
}
