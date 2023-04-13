//
//  deleteUser.swift
//  SKHUAZ
//
//  Created by 박신영 on 2023/04/11.
//

import SwiftUI

struct deleteUser: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentationMode

    func deleteAccount() {
        guard let url = URL(string: "http://skhuaz.duckdns.org/delete") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        // 유저의 세션 아이디를 헤더에 추가
        let sessionId = userData.sessionId
        request.addValue(sessionId, forHTTPHeaderField: "sessionId")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("에러: \(error.localizedDescription)")
            } else if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    print("회원탈퇴 성공")
                    exit(0)
                } else {
                    print("회원탈퇴 실패")
                }
            }
        }.resume()
    }
    
    var body: some View {
        Text("회원 탈퇴")
        Button {
            deleteAccount()
            
        } label: {
            
            Text("회원탈퇴")
                .frame(width: 330, height: 10)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color(red: 0.603, green: 0.756, blue: 0.819))
                .cornerRadius(10)
        }
        
    }
}
