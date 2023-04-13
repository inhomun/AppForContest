//
//  EvaluationDetailView.swift
//  skhuaz
//
//  Created by 봉주헌 on 2023/03/11.
//

import SwiftUI

struct EvaluationDetail: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var lectureName: String = "" // 과목명
    @State private var prfsName: String = ""    // 교수님 성함
    @State private var classYear: String = "수강년도"   // 수강년도
    @State private var semester: String = ""   // 1 or 2 학기
    @State private var department: String = "학과를 선택해주세요"  // 전공구분
    @State private var is_major_required: Bool = false  // 전공필수 여부
    @State private var teamPlay: String = "1 upto 5" // 팀플비중
    @State private var task: String = "1 upto 5" // 과제량
    @State private var practice: String = "1 upto 5" // 연습
    @State private var presentation: String = "1 upto 5" // 발표
    @State private var review: String = "  총평 : " // 강의총평
    
    @State private var scorenotice = "※ 숫자가 높을 수록 횟수/양 이 많습니다."
    @State private var name_notice = "※ 과목명과 교수님 성함은 강의계획서를 준합니다."
    @State private var skip: Bool = false
    @State var showAlert: Bool = false
    
    
    @EnvironmentObject var userData: UserData
    @StateObject var api = PostAPI()
    
    var body: some View {
        
        GeometryReader { geometry in
            let maxWidth = geometry.size.width
            let maxHeight = geometry.size.height
            
            NavigationView{
                ScrollView {
                    VStack {
                        HStack {
                            Text("\(userData.nickname)")
                                .foregroundColor(Color(hex: 0x9AC1D1)) //글씨색
                                .fontWeight(.semibold)
                                .font(.system(size: 17))
                            Text(" 님은 지금 2023-1 학기 입니다.")
                                .font(.system(size: 17))
                            
                        }.padding(.top, 20)
                        
                        VStack{
                            
                            HStack {
                                Text(name_notice)
                                    .foregroundColor(Color.red)
                                    .font(.system(size: 15))
                            }
                            
                            Rectangle().fill(Color(uiColor: .secondarySystemBackground))
                                .frame(width: 350, height: 50)
                                .cornerRadius(10)
                                .overlay(content: {
                                    TextField("과목명을 입력해주세요", text: $lectureName)
                                        .padding()
                                        .autocapitalization(.none) // 자동으로 대문자 설정 안하기
                                        .disableAutocorrection(true) // 자동완성 끄기
                                        .foregroundColor(Color(hex: 0x4F4F4F))
                                })
                            
                            Rectangle().fill(Color(uiColor: .secondarySystemBackground))
                                .frame(width: 350, height: 50)
                                .cornerRadius(10)
                                .overlay(content: {
                                    TextField("교수님 성함을 입력해주세요", text: $prfsName)
                                        .padding()
                                        .autocapitalization(.none) // 자동으로 대문자 설정 안하기
                                        .disableAutocorrection(true) // 자동완성 끄기
                                        .foregroundColor(Color(hex: 0x4F4F4F))
                                })
                                .padding(.bottom, 20)
                            
                            
                            HStack{
                                Rectangle().fill(Color(uiColor: .secondarySystemBackground))
                                    .frame(width: 200, height: 40)
                                    .cornerRadius(10)
                                    .overlay(content: {
                                        HStack {
                                            Menu("\(classYear) (년)") {
                                                Button("2018년",
                                                       action: { classYear = "2018"})
                                                Button("2019년",
                                                       action: { classYear = "2019"})
                                                Button("2020년",
                                                       action: { classYear = "2020"})
                                                Button("2021년",
                                                       action: { classYear = "2021"})
                                                Button("2021년",
                                                       action: { classYear = "2022"})
                                                Button("2021년",
                                                       action: { classYear = "2023"})
                                            }
                                            .foregroundColor(Color(hex: 0x9AC1D1)) //글씨색
                                            .font(.system(size: 13))
                                            .fontWeight(.semibold)
                                            .cornerRadius(10)
                                            //                                                .padding()
                                            //                                                .frame(width: 10, height: 50)
                                            
                                        }
                                    })
                                Rectangle().fill(Color(uiColor: .secondarySystemBackground))
                                    .frame(width: 140, height: 40)
                                    .cornerRadius(10)
                                    .overlay(content: {
                                        HStack {
                                            Menu("\(semester)학기") {
                                                Button("1학기",
                                                       action: { semester = "1"})
                                                Button("2학기",
                                                       action: { semester = "2"})
                                                
                                                
                                            }
                                            .foregroundColor(Color(hex: 0x9AC1D1)) //글씨색
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .cornerRadius(10)
                                        }
                                    })
                            }
                            //학과
                            Rectangle().fill(Color(uiColor: .secondarySystemBackground))
                                .frame(width: 350, height: 40)
                                .cornerRadius(10)
                                .overlay(content: {
                                    HStack {
                                        Menu("\(department)") {
                                            Button("소프트웨어공학",
                                                   action: { department = "소프트웨어공학"})
                                            Button("정보통신공학",
                                                   action: { department = "정보통신공학"})
                                            Button("컴퓨터공학",
                                                   action: { department = "컴퓨터공학"})
                                            Button("인공지능공학",
                                                   action: { department = "인공지능공학"})
                                            
                                        }
                                        .foregroundColor(Color(hex: 0x9AC1D1)) //글씨색
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                        .cornerRadius(10)
                                    }
                                })
                                .padding(.bottom, 20)
                            
                            VStack {
                                Text(scorenotice)
                                    .foregroundColor(Color.red)
                                    .font(.system(size: 15))
                                
                                
                                
                                HStack{
                                    Text("팀플비중")
                                        .padding(.leading, 25)
                                        .padding([.leading, .trailing])
                                    Rectangle().fill(Color(uiColor: .secondarySystemBackground))
                                        .frame(width: 170, height: 40)
                                        .cornerRadius(10)
                                        .overlay(content: {
                                            HStack {
                                                Menu("\(teamPlay)") {
                                                    Button("1점",
                                                           action: { teamPlay = "1"})
                                                    Button("2점",
                                                           action: { teamPlay = "2"})
                                                    Button("3점",
                                                           action: { teamPlay = "3"})
                                                    Button("4점",
                                                           action: { teamPlay = "4"})
                                                    Button("5점",
                                                           action: { teamPlay = "5"})
                                                    
                                                }
                                                .foregroundColor(Color(hex: 0x9AC1D1)) //글씨색
                                                .font(.system(size: 15))
                                                .fontWeight(.light)
                                                .cornerRadius(10)
                                            }
                                        })
                                }
                                HStack{
                                    Text("과제량")
                                        .padding(.leading, 40)
                                        .padding([.leading, .trailing])
                                    Rectangle().fill(Color(uiColor: .secondarySystemBackground))
                                        .frame(width: 170, height: 40)
                                        .cornerRadius(10)
                                        .overlay(content: {
                                            HStack {
                                                Menu("\(task)") {
                                                    Button("1점",
                                                           action: { task = "1"})
                                                    Button("2점",
                                                           action: { task = "2"})
                                                    Button("3점",
                                                           action: { task = "3"})
                                                    Button("4점",
                                                           action: { task = "4"})
                                                    Button("5점",
                                                           action: { task = "5"})
                                                    
                                                }
                                                .foregroundColor(Color(hex: 0x9AC1D1)) //글씨색
                                                .font(.system(size: 15))
                                                .fontWeight(.light)
                                                .cornerRadius(10)
                                            }
                                        })
                                }
                                
                                HStack{
                                    Text("실습량")
                                        .padding(.leading, 40)
                                        .padding([.leading, .trailing])
                                    Rectangle().fill(Color(uiColor: .secondarySystemBackground))
                                        .frame(width: 170, height: 40)
                                        .cornerRadius(10)
                                        .overlay(content: {
                                            HStack {
                                                Menu("\(practice)") {
                                                    Button("1점",
                                                           action: { practice = "1"})
                                                    Button("2점",
                                                           action: { practice = "2"})
                                                    Button("3점",
                                                           action: { practice = "3"})
                                                    Button("4점",
                                                           action: { practice = "4"})
                                                    Button("5점",
                                                           action: { practice = "5"})
                                                    
                                                }
                                                .foregroundColor(Color(hex: 0x9AC1D1)) //글씨색
                                                .font(.system(size: 15))
                                                .fontWeight(.light)
                                                .cornerRadius(10)
                                            }
                                        })
                                }
                                HStack{
                                    Text("발표량")
                                        .padding(.leading, 40)
                                        .padding([.leading, .trailing])
                                    Rectangle().fill(Color(uiColor: .secondarySystemBackground))
                                        .frame(width: 170, height: 40)
                                        .cornerRadius(10)
                                        .overlay(content: {
                                            HStack {
                                                Menu("\(presentation)") {
                                                    Button("1점",
                                                           action: { presentation = "1"})
                                                    Button("2점",
                                                           action: { presentation = "2"})
                                                    Button("3점",
                                                           action: { presentation = "3"})
                                                    Button("4점",
                                                           action: { presentation = "4"})
                                                    Button("5점",
                                                           action: { presentation = "5"})
                                                    
                                                }
                                                .foregroundColor(Color(hex: 0x9AC1D1)) //글씨색
                                                .font(.system(size: 15))
                                                .fontWeight(.light)
                                                .cornerRadius(10)
                                            }
                                        })
                                }
                            }.padding(.bottom,20)
                            
                            HStack {
                                TextEditor(text: $review)
                                    .padding(.bottom, 50)
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 15))
                                    .lineSpacing(5) //줄 간격
                                    .frame(width: maxWidth*0.9, height: 200)
                                    .border(Color(hex: 0x9AC1D1), width: 1)
                                    .cornerRadius(0)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        //전체 큰 네모박스
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(hex: 0x9AC1D1), lineWidth: 1)
                                .frame(width: maxWidth*0.95)
                        )
                        .padding(.bottom,20)
                        
                        HStack {
                            //취소 버튼
                            Button(action: {
                                 print("취소버튼 클릭")
                                skip = true
                                })
                            {
                                Text("취소")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 15))
                                    .frame(width: maxWidth*0.4, height: 40)
                                    .cornerRadius(10)
                                    .background(Color(hex: 0xC28D8D))
                                    .cornerRadius(10)
                            }
                            .background(
                                NavigationLink(destination: EvaluationView(selectedLectureID: 0), isActive: $skip) {
                                    
                                    EmptyView()
                                }
                            )
                            
                            //저장 버튼
                            Button(action: {
                                if lectureName != "" && prfsName != "" && classYear != "" && semester != "" && department != "" && teamPlay != "" && task != "" && practice != "" && presentation != "" && presentation != "" && review != ""{
                                    
                                    let parameters: [String: Any] = ["lectureName": lectureName, "prfsName": prfsName, "classYear": Int(classYear)!, "semester": Int(semester)!, "department": department, "is_major_required": is_major_required, "teamPlay": teamPlay, "task": task, "practice": practice, "presentation": presentation, "review": review]
                                    print("강의평 Create parameters : \(parameters)")
                                    api.postMethod(parameters: parameters)
                                    
                                    
                                    // 회원가입 api 보냈으니까 값 다 비워주기
                                    lectureName = "" // 과목명
                                    prfsName = ""    // 교수님 성함
                                    classYear = "수강년도"   // 수강년도
                                    semester = ""   // 1 or 2 학기
                                    department = "학과를 선택해주세요"  // 전공구분
                                    is_major_required = false  // 전공필수 여부
                                    teamPlay = "1 upto 5" // 팀플비중
                                    task = "1 upto 5" // 과제량
                                    practice = "1 upto 5" // 연습
                                    presentation = "1 upto 5" // 발표
                                    review = "  총평 : " // 강의총평
                                    
                                } else {
                                    showAlert = true
                                    print("조건을 모두 입력하여주세요.")
                                }
                            })
                            {
                                Text("저장")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 15))
                                    .frame(width: maxWidth*0.4, height: 40)
                                    .cornerRadius(10)
                                    .background(Color(hex: 0x9AC1D1))
                                    .cornerRadius(10)
                            }
                            .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("조건을 모두 입력하여주세요."),
                                    message: nil,
                                    dismissButton: .default(Text("확인"))
                                )
                            }
                            .foregroundColor(.white)
                            .frame(width: 170, height: 40)
                            .background(Color(red: 0.603, green: 0.756, blue: 0.819))
                            .cornerRadius(10)
                        }
                        .padding(.bottom, 20)
                    }
                    
                    
                    
                }//네비게이션뷰
            }
        }
    }
}
