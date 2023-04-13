//import SwiftUI
//
//struct Lecture: Codable {
//    let id: Int
//    let lectureName: String
//    let prfsName: String
//    let classYear: Int
//    let semester: Int
//    let department: String
//    let teamPlay: Int
//    let task: Int
//    let practice: Int
//    let presentation: Int
//    let nickname: String
//    let review: String?
//    let user: String?
//}
//
//struct secondLecture: Codable {
//    let id: Int
//    let lectureName: String
//    let prfsName: String
//    let classYear: Int
//    let semester: Int
//    let department: String
//    let teamPlay: Int
//    let task: Int
//    let practice: Int
//    let presentation: Int
//    let review: String?
//    let userNickname: String?
//}
//
//struct test: View {
//    @StateObject var api = PostAPI()
//    @EnvironmentObject var userData: UserData
//    @State private var lectures: [Lecture] = []
//    @State private var searchText: String = ""
//    @State var test: String = ""
//    @State var Evalution_write = false
//    @State private var deep_go = false
//    var filteredLectures: [Lecture] {
//        if searchText.isEmpty {
//            return lectures
//        } else {
//            return lectures.filter { $0.department.contains(searchText) || $0.lectureName.contains(searchText) || $0.nickname.contains(searchText) }
//        }
//    }
//    @State private var isDataFetched = false
//    
//    
//    var body: some View {
//        GeometryReader { geometry in
//            let maxWidth = geometry.size.width
//            let maxHeight = geometry.size.height
//            NavigationView{
//                
//                
//                VStack {
//                    /**검색창**/
//                    HStack{
//                        TextField("강의를 검색해주세요", text: $searchText)
//                            .padding(.leading)
//                            .frame(width: 300, height: 50)
//                            .background(Color(.white))
//                            .border(Color(hex: 0x9AC1D1),width: 5)
//                            .cornerRadius(10)
//                            .autocapitalization(.none) // 자동으로 대문자 설정 안하기
//                            .disableAutocorrection(true) // 자동완성 끄기
//                        
//                        Image("검색버튼")
//                            .padding()
//                            .frame(width: 50, height: 30)
//                            .aspectRatio(contentMode: .fit)
//                    }
//                    
//                    HStack{
//                        Text("")
//                            .frame(width:10)
//                        ScrollView (.horizontal, showsIndicators: false, content:  {
//                            HStack {
//                                Button {
//                                    searchText = "소프트웨어공학"
//                                } label: {
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .stroke(Color(hex: 0x9AC1D1), lineWidth: 2)
//                                        .frame(width:145,height:35)
//                                    
//                                        .overlay(
//                                            Text("소프트웨어공학과")
//                                        )
//                                }
//                                Button {
//                                    searchText = "정보통신공학"
//                                } label: {
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .stroke(Color(hex: 0x9AC1D1), lineWidth: 2)
//                                        .frame(width:145,height:35)
//                                    
//                                        .overlay(
//                                            Text("정보통신공학과")
//                                        )
//                                }
//                                Button {
//                                    searchText = "컴퓨터공학"
//                                } label: {
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .stroke(Color(hex: 0x9AC1D1), lineWidth: 2)
//                                        .frame(width:145,height:35)
//                                    
//                                        .overlay(
//                                            Text("컴퓨터공학과")
//                                        )
//                                }
//                                Button {
//                                    searchText = "인공지능공학"
//                                } label: {
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .stroke(Color(hex: 0x9AC1D1), lineWidth: 2)
//                                        .frame(width:145,height:35)
//                                    
//                                        .overlay(
//                                            Text("인공지능공학과")
//                                        )
//                                }
//                            }
//                        })
//                        Text("")
//                            .frame(width:20)
//                        VStack(alignment: .center) {
//                            Text("")
//                                .frame(height: 15)
//                            Button(action: {
//                                
//                                Evalution_write = true
//                                
//                            }) {
//                                Image(systemName: "square.and.pencil")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .padding(.bottom, 5)
//                                    .foregroundColor(Color(hex: 0x9AC1D1))
//                                    .padding(.trailing, 15)
//                                    .frame(width: 50, height: 35)
//                            }
//                            .padding(.bottom, 10)
//                            NavigationLink(destination: EvaluationDetail().navigationBarBackButtonHidden(true)
//                                .navigationBarHidden(true), isActive: $Evalution_write) {
//                                    
//                                    EmptyView()
//                                }
//                        }.padding(.bottom, 10)
//                        
//                    }
//                    
//                    ScrollView (.vertical, showsIndicators: false, content:  {
//                        VStack(alignment: .leading) {
//                            ForEach(filteredLectures, id: \.id) { lecture in
//                                
//                                
//                                Group{
//                                    VStack{
//                                        Group{
//                                            HStack{
//                                                Text("\(lecture.lectureName) | \(lecture.prfsName) | \(Classyear_recover(num:lecture.classYear))년")
//                                                Spacer()
//                                            }
//                                            .font(.system(size: 12))
//                                            .padding()
//                                        }
//                                        .frame(width: 320, height: 40)
//                                        .background(Color(uiColor: .secondarySystemBackground))
//                                        Group{
//                                            HStack{
//                                                VStack(alignment:.trailing, spacing: 8){
//                                                    Text("팀플횟수")
//                                                    Text("과제량")
//                                                    Text("실습량")
//                                                    Text("발표량")
//                                                }
//                                                .font(.system(size: 12))
//                                                VStack {
//                                                    HStack(alignment: .center, spacing: 0) {
//                                                        Chart(num: lecture.teamPlay)
//                                                        Spacer()
//                                                    }
//                                                    HStack(alignment: .center, spacing: 0) {
//                                                        Chart(num: lecture.task)
//                                                        Spacer()
//                                                    }
//                                                    HStack(alignment: .center, spacing: 0) {
//                                                        Chart(num: lecture.practice)
//                                                        Spacer()
//                                                    }
//                                                    HStack(alignment: .center, spacing: 0) {
//                                                        Chart(num: lecture.presentation)
//                                                        Spacer()
//                                                    }
//                                                    //                                                    Chart(num: lecture.teamPlay)
//                                                    //                                                    Chart(num: lecture.task)
//                                                    //                                                    Chart(num: lecture.practice)
//                                                    //                                                    Chart(num: lecture.presentation)
//                                                }
//                                                .frame(width: 260, height: 90)
//                                                .background(Color.white)
//                                                .alignmentGuide(.leading, computeValue: { d in d[HorizontalAlignment.leading] })
//
//
//                                            }
//                                        }
//                                        .frame(width: 320, height: 100)
//                                        HStack{
//                                            Text("\(userData.nickname)")
//                                                .padding(.leading, 15)
//                                            Spacer()
////                                            NavigationLink(destination: deepView()) {
////                                                Text("자세히 보기")
////                                            }
//                                            .font(.system(size: 12))
//                                            .padding(.trailing, 15)
//                                            .frame(height: 25)
//                                            .background(Color.blue)
//                                            .foregroundColor(Color.white)
//                                            .cornerRadius(12)
//                                        }
//                                    }.padding()
//                                }
//                                .frame(width: 350)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 16)
//                                        .stroke(Color(hex: 0x9AC1D1), lineWidth: 2)
//                                        .sheet(isPresented: self.$deep_go) {
//                                                                            deep_go()
//                                                                        }
//                                )
//                                .onTapGesture {
//                                    self.deep_go = true
//                                }
//
//                                
//                            }
//                        }
//                    }).padding()
//                        .padding(.bottom, 15)
//                    //                        .border(Color(hex: 0x9AC1D1), width: 1)
//                        .frame(maxWidth: .infinity)
//                }
//                .onAppear(perform: {
//                    fetchData()
//                })
//                .onChange(of: isDataFetched, perform: { value in
//                    // Do something when isDataFetched changes, e.g. re-fetch data
//                    fetchData()
//                })
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//    
//    func fetchData() {
//        guard let url = URL(string: "http://skhuaz.duckdns.org/AllEvaluation") else {
//            print("Invalid URL")
//            return
//        }
//        
//        let session = URLSession(configuration: .default)
//        
//        let request = URLRequest(url: url)
//        
//        let dataTask = session.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//            
//            if let data = data {
//                do {
//                    let decoder = JSONDecoder()
//                    self.lectures = try decoder.decode([Lecture].self, from: data)
//                } catch {
//                    print("Failed to decode data: \(error.localizedDescription)")
//                }
//            }
//        }
//        isDataFetched = true
//        dataTask.resume()
//    }
//    
//    
//    
//    func getLecture(id: Int) {
//        guard let url = URL(string: "http://skhuaz.duckdns.org/evaluations/\(id)") else {
//            print("Invalid URL")
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let data = data else {
//                print("No data received")
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                let lecture = try decoder.decode(secondLecture.self, from: data)
//                print("Received Lecture Data: \(lecture)")
//            } catch let error {
//                print("Decoding error: \(error.localizedDescription)")
//            }
//        }.resume()
//    }
//    
//    
//    func deleteLecture(id: Int) {
//        guard let url = URL(string: "http://skhuaz.duckdns.org/evaluation/\(id)") else {
//            print("Invalid URL")
//            return
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "DELETE"
//        let sessionId = userData.sessionId
//        request.addValue(sessionId, forHTTPHeaderField: "sessionId")
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//            if let response = response as? HTTPURLResponse {
//                if response.statusCode == 200 {
//                    DispatchQueue.main.async {
//                        // Remove the deleted lecture from the lectures array
//                        if let index = self.lectures.firstIndex(where: { $0.id == id }) {
//                            self.lectures.remove(at: index)
//                        }
//                        print("삭제했습니다.")
//                    }
//                } else {
//                    print("서버와의 통신이 실패했습니다. \(response.statusCode) 에러")
//                }
//            }
//        }
//        task.resume()
//    }
//    
//    
//    
//    //func classyear , 제거
//    func Classyear_recover(num:Int) -> String {
//        var n = num.description.split(separator: ",")
//        var s = ""
//        for i in n {
//            s+=i.description
//        }
//        return s
//        
//    }
//    
//    
//    func Chart(num:Int) -> some View {
//        var n = num
//        if n == 1 {
//            return AnyView(Rectangle()
//                .frame(width: 52, height: 15)
//                .foregroundColor(Color(hex: 0x9AC1D1)))
//        }
//        else if n == 2 {
//            return AnyView(Rectangle()
//                .frame(width: 104, height: 15)
//                .foregroundColor(Color(hex: 0x9AC1D1)))
//        }
//        else if n == 3 {
//            return AnyView(Rectangle()
//                .frame(width: 156, height: 15)
//                .foregroundColor(Color(hex: 0x9AC1D1)))
//        }
//        else if n == 4 {
//            return AnyView(Rectangle()
//                .frame(width: 208, height: 15)
//                .foregroundColor(Color(hex: 0x9AC1D1)))
//        }
//        else if n == 5 {
//            return AnyView(Rectangle()
//                .frame(width: 250, height: 15)
//                .foregroundColor(Color(hex: 0x9AC1D1)))
//        }
//        
//        // 기본값 반환
//        return AnyView(Rectangle()
//                       //            .frame(width: 52, height: 15)
//                       //            .foregroundColor(Color(hex: 0x9AC1D1)))
//        )
//    }
//    
//}
//
//
//
