////
////  detail.swift
////  SKHUAZ
////
////  Created by 박신영 on 2023/04/12.
////
//
//import SwiftUI
//struct Lecture2: Codable {
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
//}
//struct detail: View {
//    @StateObject var api = PostAPI()
//    @EnvironmentObject var userData: UserData
//    @State var lectures2: [Lecture2] = []
//    @State var searchText: String = ""
//    @State var test: String = ""
//    @State var Evalution_write = false
//    var body: some View {
//        
//        
//        ScrollView (.vertical, showsIndicators: false, content:  {
//            VStack(alignment: .leading) {
//                ForEach(lectures2, id: \.id) { lecture in
//                    
//                    
//                    Group{
//                        VStack{
//                            Group{
//                                HStack{
//                                    Text("과목명 : \(lecture.lectureName) | 교수 : \(lecture.prfsName) | 수강년도 :")
//                                    Spacer()
//                                }
//                                .font(.system(size: 12))
//                                .padding()
//                            }
//                            .frame(width: 320, height: 40)
//                            .background(Color(uiColor: .secondarySystemBackground))
//                            Group{
//                                HStack{
//                                    VStack(alignment:.trailing, spacing: 8){
//                                        Text("팀플횟수")
//                                        Text("과제량")
//                                        Text("실습량")
//                                        Text("발표량")
//                                    }
//                                    .font(.system(size: 12))
//                                    VStack(alignment: .leading) {
//                                        chartView(num: lecture.teamPlay)
//                                        chartView(num: lecture.task)
//                                        chartView(num: lecture.practice)
//                                        chartView(num: lecture.presentation)
//                                    }
//                                    .frame(width: 260, height: 90)
//                                    .background(Color.white)
//                                    .alignmentGuide(.leading, computeValue: { d in d[HorizontalAlignment.leading] })
//                                    
//                                    
//                                }
//                            }
//                            .frame(width: 320, height: 100)
//                            HStack{
//                                Text("\(userData.nickname)")
//                                    .padding(.leading, 15)
//                                Spacer()
//                            }
//                            .font(.system(size: 12))
//                            
//                        }.padding()
//                    }
//                    .frame(width: 350)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 16)
//                            .stroke(Color(hex: 0x9AC1D1), lineWidth: 2))
//                    
//                }
//            }
//        }).onAppear {
//            fetchData1(id:1)
//        }
//            .padding(.bottom, 15)
//        //                        .border(Color(hex: 0x9AC1D1), width: 1)
//            .frame(maxWidth: .infinity)
//    }
//        
//    
//    
//    func fetchData1(id:Int) {
//        guard let url = URL(string: "http://skhuaz.duckdns.org/evaluations/{\(id)}") else {
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
//                    self.lectures2 = try decoder.decode([Lecture2].self, from: data)
//                } catch {
//                    print("Failed to decode data: \(error.localizedDescription)")
//                }
//            }
//        }
//        
//        dataTask.resume()
//    }
//    
//}
