//
//  editProfileView.swift
//  pbch
//
//  Created by 문인호 on 2023/03/13.
//

import SwiftUI
import Combine
struct editProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userData: UserData
    @State private var Nickname = ""
    @State private var Semester = ""
    @State private var Graduate = false
    @State private var Department = false
    @State private var Major_minor = false
    @State private var Double_major = false
    @State private var Major1 = ""
    @State private var Major2 = ""
    @State private var SemesterMessage: String = "재학중인 학기를 선택하시오"
    @State private var retouchSuccess: Bool = false
    
    // MARK: - 닉네임
    @State private var isDuplicate: Bool?
    @State var nicknameSuccess: Bool = false
    @State private var showDuplicateAlert: Bool = false

    let SelectedMajor1 = [
        "소프트웨어공학",
        "정보통신공학",
        "컴퓨터공학",
        "인공지능"
    ]
    let SelectedMajor2 = [
        "소프트웨어공학",
        "정보통신공학",
        "컴퓨터공학",
        "인공지능"
    ]
    @State var MarjorError: String = "선택한 두 전공이 같습니다"
    
    func sendToServer() {
        guard let url = URL(string: "http://skhuaz.duckdns.org/retouch-users") else {
            print("Invalid URL")
            return
        }
        
        let json: [String: Any] = [
            "nickname" : Nickname,
            "semester" : Semester,
            "graduate" : Graduate,
            "department" : Department,
            "major_minor" : Major_minor,
            "double_major" : Double_major,
            "major1" : Major1,
            "major2" : Major2
        ]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) else {
            print("Failed to serialize JSON")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                // 서버로부터 받은 데이터 처리
                print("Data received: \(String(data: data, encoding: .utf8) ?? "")")
                // 통신이 성공하면 retouchSuccess 변수를 true로 설정
                retouchSuccess = true
                self.presentationMode.wrappedValue.dismiss()
            }
        }.resume()
    }
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .fill(Color(hex: 0xEFEFEF))
                    .frame(width: 150, height: 150)
                Text("프로필 사진")
                    .foregroundColor(Color(hex: 0x7D7D7D))
            }
            .padding(.bottom, 15)
            
            VStack{
                HStack{
                    TextField("닉네임을 입력해주세요* ", text: $Nickname)
                        .padding()
                        .frame(width: 250, height: 50)
                        .background(Color(uiColor: .secondarySystemBackground))
                        .cornerRadius(10)
                    Button{
                        // 5. API 요청
                        let urlString = "http://skhuaz.duckdns.org/checkDuplicate/\(Nickname)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                        guard let url = URL(string: urlString) else { return }
                        
                        URLSession.shared.dataTask(with: url) { data, response, error in
                            guard let data = data, error == nil else {
                                // 6. 에러 발생시 처리
                                print(error?.localizedDescription ?? "Unknown error")
                                return
                            }
                            // 7. API 응답 결과 파싱
                            let responseString = String(data: data, encoding: .utf8)
                            isDuplicate = responseString?.lowercased() == "true"
                            if isDuplicate == true {
                                // 8. 중복 닉네임일 경우 팝업 표시
                                showDuplicateAlert = true
                                nicknameSuccess = false

                            }
                            else {
                                nicknameSuccess = true
                            }
                        }.resume()
                    } label: {
                        Text("중복확인")
                            .foregroundColor(Color(red: 0.76, green: 0.552, blue: 0.552))
                            .frame(width: 90, height:50)
                            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color(red: 0.76, green: 0.552, blue: 0.552)))
                    }
                    .alert(isPresented: $showDuplicateAlert, content: {
                        // 10. 중복 닉네임 알림 팝업
                        Alert(title: Text("닉네임 중복"), message: Text("입력한 '\(Nickname)'은 이미 사용중입니다."), dismissButton: .default(Text("확인")))
                    })
                }
                HStack{
                    if nicknameSuccess {
                        Text("닉네임 중복 확인 완료")
                            .font(.system(size: 14))
                            .foregroundColor(Color(red: 0.603, green: 0.756, blue: 0.819))
                            .lineLimit(2)
                            .padding(.leading, 30)
                        Spacer()
                    }
                    else{
                        Text(" ")
                    }
                }
            }
            .padding(.bottom, 5)
        }
        HStack(spacing: 30){
            Text("학기 입력 * ")
                .font(.system(size: 14))
            Group{
                Menu {
                    Section(header: Text("재학중인 학기를 선택하시오")) {
                        Button(action: {
                            Semester = "8"
                            SemesterMessage = "4학년 2학기"
                        }) {
                            Label("4학년 2학기", systemImage: "")
                        }
                        Button(action: {
                            Semester = "7"
                            SemesterMessage = "4학년 1학기"
                        }) {
                            Label("4학년 1학기", systemImage: "")
                        }
                        Button(action: {
                            Semester = "6"
                            SemesterMessage = "3학년 2학기"
                        }) {
                            Label("3학년 2학기", systemImage: "")
                        }
                        Button(action: {
                            Semester = "5"
                            SemesterMessage = "3학년 1학기"
                        }) {
                            Label("3학년 1학기", systemImage: "")
                        }
                        Button(action: {
                            Semester = "4"
                            SemesterMessage = "2학년 2학기"
                        }) {
                            Label("2학년 2학기", systemImage: "")
                        }
                        Button(action: {
                            Semester = "3"
                            SemesterMessage = "2학년 1학기"
                        }) {
                            Label("2학년 1학기", systemImage: "")
                        }
                        Button(action: {
                            Semester = "2"
                            SemesterMessage = "1학년 2학기"
                        }) {
                            Label("1학년 2학기", systemImage: "")
                        }
                        Button(action: {
                            Semester = "1"
                            SemesterMessage = "1학년 1학기"
                        }) {
                            Label("1학년 1학기", systemImage: "")
                        }
                    }
                }
            label: {
                Label("\(SemesterMessage)", systemImage: "")
                    .foregroundColor(Color(.gray))
                    .accentColor(.gray)
                    .padding()
                    .frame(width: 250, height: 50)
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(10)
            }
            }
        }
        .padding(.bottom, 30)
        
        VStack(spacing: 1){ // 졸업유무 전공유형 스텍
            HStack(spacing: 30){
                Text("졸업유무 *")
                    .font(.system(size: 14))
                HStack(spacing: 30){
                    Button(action: {
                        Graduate.toggle()
                    }) {
                        if Graduate {
                            ZStack{
                                Circle()
                                    .fill(Color(red: 0.603, green: 0.756, blue: 0.819))
                                    .frame(width: 15, height: 15)
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 6, height: 6)
                            }
                            Text("미졸업")
                        }
                        else {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 15, height: 15)
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            Text("미졸업")
                        }
                    }
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                    
                    Button(action: {
                        Graduate.toggle()
                    }) {
                        if !Graduate {
                            ZStack{
                                Circle()
                                    .fill(Color(red: 0.603, green: 0.756, blue: 0.819))
                                    .frame(width: 15, height: 15)
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 6, height: 6)
                            }
                            Text("졸업")
                        }
                        else {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 15, height: 15)
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            Text("졸업")
                        }
                    }
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                    Spacer()
                }
                .frame(width: 250, height: 50)
            }
            .padding(.bottom, 30)
            
            HStack(spacing: 30){
                Text("전공유형*")
                    .font(.system(size: 14))
                HStack(spacing: 20){
                    Button(action: {
                        Department = true
                        Major_minor = false
                        Double_major = false
                        Major1 = "IT융합자율학부"
                        Major2 = ""
                    }) {
                        if Department {
                            ZStack{
                                Circle()
                                    .fill(Color(red: 0.603, green: 0.756, blue: 0.819))
                                    .frame(width: 15, height: 15)
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 6, height: 6)
                            }
                            Text("전공 미선택")
                                .foregroundColor(.black)
                            
                        }
                        else {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 15, height: 15)
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            Text("전공 미선택")
                                .foregroundColor(.black)
                        }
                    }
                    .aspectRatio(contentMode: .fill)
                    Button(action: {
                        Department = false
                        Major_minor = true
                        Double_major = false
                        Major1 = "주전공"
                        Major2 = "부전공"
                    }) {
                        if Major_minor {
                            ZStack{
                                Circle()
                                    .fill(Color(red: 0.603, green: 0.756, blue: 0.819))
                                    .frame(width: 15, height: 15)
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 6, height: 6)
                            }
                            Text("주/부전공")
                                .foregroundColor(.black)
                            
                        }
                        else {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 15, height: 15)
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            Text("주/부전공")
                                .foregroundColor(.black)
                        }
                    }
                    .aspectRatio(contentMode: .fill)
                    Button(action: {
                        Department = false
                        Major_minor = false
                        Double_major = true
                        Major1 = "전공1"
                        Major2 = "전공2"
                    }) {
                        if Double_major {
                            ZStack{
                                Circle()
                                    .fill(Color(red: 0.603, green: 0.756, blue: 0.819))
                                    .frame(width: 15, height: 15)
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 6, height: 6)
                            }
                            Text("복수전공")
                                .foregroundColor(.black)
                            
                        }
                        else {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 15, height: 15)
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            Text("복수전공")
                                .foregroundColor(.black)
                        }
                    }
                    .aspectRatio(contentMode: .fill)
                }
                .font(.system(size: 12))
                .foregroundColor(.black)
                .frame(width: 250, height: 50)
            } // 졸업유무 전공유형 스택
            VStack(spacing: 1){
                HStack(spacing: 10){
                    if Department {
                        Text("\(Major1)")
                            .foregroundColor(.gray)
                            .padding()
                            .frame(width: 350, height: 50)
                            .background(Color(uiColor: .secondarySystemBackground))
                            .cornerRadius(10)
                    }
                    else if Major_minor {
                        HStack{
                            Menu("\(Major1)") {
                                Button("소프트웨어공학",
                                       action: { Major1 = "소프트웨어공학"}
                                )
                                Button("정보통신공학",
                                       action: { Major1 = "정보통신공학"})
                                Button("컴퓨터공학",
                                       action: { Major1 = "컴퓨터공학"})
                                Button("인공지능",
                                       action: { Major1 = "인공지능"})
                            }
                            .foregroundColor(.gray)
                            .padding()
                            .frame(width: 170, height: 50)
                            .background(Color(uiColor: .secondarySystemBackground))
                            .cornerRadius(10)
                            
                            Menu("\(Major2)") {
                                Button("소프트웨어공학",
                                       action: { Major2 = "소프트웨어공학"})
                                Button("정보통신공학",
                                       action: { Major2 = "정보통신공학"})
                                Button("컴퓨터공학",
                                       action: { Major2 = "컴퓨터공학"})
                                Button("인공지능",
                                       action: { Major2 = "인공지능"})
                            }
                            .foregroundColor(.gray)
                            .padding()
                            .frame(width: 170, height: 50)
                            .background(Color(uiColor: .secondarySystemBackground))
                            .cornerRadius(10)
                        }
                    }
                    else if Double_major{
                        HStack{
                            Menu("\(Major1)") {
                                Button("소프트웨어공학",
                                       action: { Major1 = "소프트웨어공학"})
                                Button("정보통신공학",
                                       action: { Major1 = "정보통신공학"})
                                Button("컴퓨터공학",
                                       action: { Major1 = "컴퓨터공학"})
                                Button("인공지능",
                                       action: { Major1 = "인공지능"})
                            }
                            .foregroundColor(.gray)
                            .padding()
                            .frame(width: 170, height: 50)
                            .background(Color(uiColor: .secondarySystemBackground))
                            .cornerRadius(10)
                            
                            Menu("\(Major2)") {
                                Button("소프트웨어공학",
                                       action: { Major2 = "소프트웨어공학"})
                                Button("정보통신공학",
                                       action: { Major2 = "정보통신공학"})
                                Button("컴퓨터공학",
                                       action: { Major2 = "컴퓨터공학"})
                                Button("인공지능",
                                       action: { Major2 = "인공지능"})
                            }
                            .foregroundColor(.gray)
                            .padding()
                            .frame(width: 170, height: 50)
                            .background(Color(uiColor: .secondarySystemBackground))
                            .cornerRadius(10)
                        }
                    }
                }
                .frame(width: 350, height: 50)
                HStack{ // 비밀번호 안내문구 출력
                    if Major1 == Major2{
                        Text(MarjorError)
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .padding(.bottom, 30)
        Button(action: {
            sendToServer()
        }) {
            Text("저장")
                .frame(width: 330, height: 10)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color(red: 0.603, green: 0.756, blue: 0.819))
                .cornerRadius(10)
        }
        Text("")
            .onAppear {
                Nickname = userData.nickname
                Semester = userData.semester
                Graduate = userData.graduate
                Department = userData.department
                Major_minor = userData.major_minor
                Double_major = userData.double_major
                Major1 = userData.major1 ?? ""
                Major2 = userData.major2 ?? ""
                SemesterMessage = "\(Semester)학기"
            }
    }
}
