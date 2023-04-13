//
//  deleteCheck.swift
//  SKHUAZ
//
//  Created by 박신영 on 2023/04/11.
//

import SwiftUI


struct deleteCheck: View {
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
                Text("회원탈퇴")
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
                        deleteUser()
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

