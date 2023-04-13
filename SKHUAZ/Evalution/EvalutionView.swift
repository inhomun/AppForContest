import SwiftUI

struct Lecture: Codable {
    let id: Int
    let lectureName: String
    let prfsName: String
    let classYear: Int
    let semester: Int
    let department: String
    let teamPlay: Int
    let task: Int
    let practice: Int
    let presentation: Int
    let nickname: String
    let review: String?
    let user: String?
}

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
//    let userNickname: String
//}


struct EvaluationView: View {
    @StateObject var api = PostAPI()
    @EnvironmentObject var userData: UserData
    @State var lectures: [Lecture] = []
    @State private var searchText: String = ""
    @State var test: String = ""
    //    @State var Evalution_write = false
    
    //    @Environment(\.presentationMode)
    var filteredLectures: [Lecture] {
        if searchText.isEmpty {
            return lectures
        } else {
            return lectures.filter { $0.department.contains(searchText) || $0.lectureName.contains(searchText) || $0.nickname.contains(searchText) }
        }
    }
    @State private var isDataFetched = false
    @Environment(\.presentationMode) var presentationMode
    @State private var detail = false
    @State var secoundlectures: [secondLecture] = []
    
    
    @State var selectedLectureID: Int
    @State private var isMoveViewPresented: Bool = false

    
    
    var body: some View {
        GeometryReader { geometry in
            let maxWidth = geometry.size.width
            let maxHeight = geometry.size.height
            NavigationView{
                
                
                VStack {
                    /**검색창**/
                    HStack{
                        TextField("과목명/교수명/유저이름을 검색해주세요", text: $searchText)
                            .padding(.leading)
                            .frame(width: 300, height: 50)
                            .background(Color(.white))
                            .border(Color(hex: 0x9AC1D1),width: 5)
                            .cornerRadius(10)
                            .autocapitalization(.none) // 자동으로 대문자 설정 안하기
                            .disableAutocorrection(true) // 자동완성 끄기
                        
                        Image("검색버튼")
                            .padding()
                            .frame(width: 50, height: 30)
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    HStack{
                        Text("")
                            .frame(width:10)
                        ScrollView (.horizontal, showsIndicators: false, content:  {
                            HStack {
                                Button {
                                    searchText = "소프트웨어공학"
                                } label: {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(hex: 0x9AC1D1), lineWidth: 2)
                                        .frame(width:145,height:35)
                                    
                                        .overlay(
                                            Text("소프트웨어공학과")
                                        )
                                }
                                Button {
                                    searchText = "정보통신공학"
                                } label: {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(hex: 0x9AC1D1), lineWidth: 2)
                                        .frame(width:145,height:35)
                                    
                                        .overlay(
                                            Text("정보통신공학과")
                                        )
                                }
                                Button {
                                    searchText = "컴퓨터공학"
                                } label: {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(hex: 0x9AC1D1), lineWidth: 2)
                                        .frame(width:145,height:35)
                                    
                                        .overlay(
                                            Text("컴퓨터공학과")
                                        )
                                }
                                Button {
                                    searchText = "인공지능공학"
                                } label: {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(hex: 0x9AC1D1), lineWidth: 2)
                                        .frame(width:145,height:35)
                                    
                                        .overlay(
                                            Text("인공지능공학과")
                                        )
                                }
                            }.padding()
                        })
                        
                        write_button()
                        
                    }
                    
                    
                    //MARK: -
                    
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading) {
                            ForEach(filteredLectures, id: \.id) { lecture in
                                Group {
                                    VStack {
                                        lectureNameView(for: lecture)
                                            .frame(width: 320, height: 40)
                                            .background(Color(uiColor: .secondarySystemBackground))

                                        chartView(for: lecture)
                                            .frame(width: 320, height: 90)
                                            .background(Color.white)
                                            .alignmentGuide(.leading, computeValue: { d in d[HorizontalAlignment.leading] })

                                        HStack {
                                            Text("\(lecture.nickname), \(lecture.id)")
                                                .padding(.leading, 15)
                                            Spacer()
                                            Button {
                                                selectedLectureID = lecture.id
                                                isMoveViewPresented = true // present될 view가 있음을 알리는 변수 값 변경
                                            } label: {
                                                Text("자세히")
                                                    .font(.system(size: 15))
                                            }
                                            .onTapGesture {
                                                selectedLectureID = lecture.id
                                                isMoveViewPresented = true // present될 view가 있음을 알리는 변수 값 변경
                                            }

                                            // ...

                                            .sheet(isPresented: $isMoveViewPresented, content: {
                                                deep_go(selectedLectureID: $selectedLectureID)
                                            })
                                            Text("")
                                                .frame(width:10)
                                        }
                                    }
                                    .padding()
                                    .frame(width: 350)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color(hex: 0x9AC1D1), lineWidth: 2))
                                }
                            }
                        }
                        .padding()
                    }
                    
                   
                    .padding(.bottom, 15)
                }
                .onAppear(perform: {
                    isDataFetched = true
                    fetchData()
                })
                .onChange(of: isDataFetched, perform: { value in
                    // Do something when isDataFetched changes, e.g. re-fetch data
                    fetchData()
                })
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func lectureNameView(for lecture: Lecture) -> some View {
        HStack{
            Text("\(lecture.lectureName) | \(lecture.prfsName) | \(Classyear_recover(num:lecture.classYear))년")
            Spacer()
        }
        .font(.system(size: 12))
        .padding()
    }
    
    func chartView(for lecture: Lecture) -> some View {
        HStack{
            VStack(alignment:.trailing, spacing: 8){
                Text("팀플횟수")
                Text("과제량")
                Text("실습량")
                Text("발표량")
            }
            .font(.system(size: 12))
            VStack {
                HStack(alignment: .center, spacing: 0) {
                    Chart(num: lecture.teamPlay)
                    Spacer()
                }
                HStack(alignment: .center, spacing: 0) {
                    Chart(num: lecture.task)
                    Spacer()
                }
                HStack(alignment: .center, spacing: 0) {
                    Chart(num: lecture.practice)
                    Spacer()
                }
                HStack(alignment: .center, spacing: 0) {
                    Chart(num: lecture.presentation)
                    Spacer()
                }
            }
        }
    }
    
//    func buttonsView(for lecture: Lecture) -> some View {
//
//        .font(.system(size: 12))
//    }
    
    
    
    
    func fetchData() {
        guard let url = URL(string: "http://skhuaz.duckdns.org/AllEvaluation") else {
            print("Invalid URL")
            return
        }
        
        let session = URLSession(configuration: .default)
        
        let request = URLRequest(url: url)
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    self.lectures = try decoder.decode([Lecture].self, from: data)
                } catch {
                    print("Failed to decode data: \(error.localizedDescription)")
                }
            }
            print(lectures)
        }
        isDataFetched = true
        dataTask.resume()
    }
    
    
    
    
    
    
    
    
    
    
    //func classyear , 제거
    func Classyear_recover(num:Int) -> String {
        var n = num.description.split(separator: ",")
        var s = ""
        for i in n {
            s+=i.description
        }
        return s
        
    }
    
    
    func Chart(num:Int) -> some View {
        var n = num
        if n == 1 {
            return AnyView(Rectangle()
                .frame(width: 52, height: 15)
                .foregroundColor(Color(hex: 0x9AC1D1)))
        }
        else if n == 2 {
            return AnyView(Rectangle()
                .frame(width: 104, height: 15)
                .foregroundColor(Color(hex: 0x9AC1D1)))
        }
        else if n == 3 {
            return AnyView(Rectangle()
                .frame(width: 156, height: 15)
                .foregroundColor(Color(hex: 0x9AC1D1)))
        }
        else if n == 4 {
            return AnyView(Rectangle()
                .frame(width: 208, height: 15)
                .foregroundColor(Color(hex: 0x9AC1D1)))
        }
        else if n == 5 {
            return AnyView(Rectangle()
                .frame(width: 250, height: 15)
                .foregroundColor(Color(hex: 0x9AC1D1)))
        }
        
        // 기본값 반환
        return AnyView(Rectangle()
                       //            .frame(width: 52, height: 15)
                       //            .foregroundColor(Color(hex: 0x9AC1D1)))
        )
    }
    
}



