//
//  sample.swift
//  SKHUAZ
//
//  Created by 박신영 on 2023/04/09.
//

import SwiftUI

struct sample: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack {
            TextField("이메일", text: $email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("비밀번호", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("로그인", action: login)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
        }
        .padding()
    }
    
    func login() {
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
                    print("응답 데이터: \(String(data: data, encoding: .utf8) ?? "")")
                } else if let error = error {
                    // 에러 처리 로직 추가
                    print("에러: \(error.localizedDescription)")
                }
            }.resume()
        }
    }
}
