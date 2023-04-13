
import SwiftUI
import Foundation

struct Post: Codable {
    let id: Int
    let title: String?
    let department: String
    let createdAt: String?
    let userNickname: String
    let user: String?
    let routeInfo: String?
    let recommendation: String?
}
struct MyStruct: Codable {
    let id: Int
    let title: String
    let department: String
    let createdAt: String
    let userNickname: String
    let user: String?
    let routeInfo: String
    let recommendation: String
}



struct RootView: View {
    @State private var myStruct: MyStruct? = nil
    @State private var isShowingDetail = false // MyStructDetail View를 표시할지 여부를 관리하는 상태 변수
    @StateObject private var viewModel = ContentViewModel()
    @State private var titles = [String]()
    @State private var routeInfos = [String]()
    @State var searchinput: String = ""// @State 속성을 이용하여 데이터를 저장
    @EnvironmentObject var userData: UserData
    @State var shouldRefresh = false


    private func DetailData(id: Int) {
        let apiURL = "http://skhuaz.duckdns.org/detail/route/\(id)" // API 주소 내부 선언
        guard let url = URL(string: apiURL) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(MyStruct.self, from: data)
                    DispatchQueue.main.async {
                        self.myStruct = result
                    }
                } catch {
                    print("Error decoding data: \(error.localizedDescription)")
                }
            }
        }.resume()
    }




    var body: some View {
        /**검색창**/
        VStack{
            HStack{
                TextField("강의를 검색해주세요", text: $searchinput)
                    .padding(.leading)
                    .frame(width: 300, height: 40)
                    .background(Color(.white))
                    .border(Color(hex: 0x9AC1D1),width: 5)
                    .padding(.bottom, 5)

                Button(action: {
                    guard let url = URL(string: "http://skhuaz.duckdns.org/route/\(searchinput)") else {
                        print("Invalid URL")
                        return
                    }

                    URLSession.shared.dataTask(with: url) { data, response, error in
                        guard let data = data else {
                            print("Error: \(error?.localizedDescription ?? "Unknown error")")
                            return
                        }

                        // handle data response here
                    }.resume()

                }) {
                    Image("검색버튼")
                        .padding()
                        .frame(width: 50, height: 30)
                        .aspectRatio(contentMode: .fit)
                }
            }
            /**전공 선택 파트**/
            HStack {
                Major_Box()
                    .frame(width: 312, height: 29)
                    .padding(.leading, -6)
                    .padding(.bottom, 10)
                Spacer()
                NavigationLink(destination: Root_Write_noG()) {
                    Image("글쓰기 버튼")
                        .frame(width: 36, height: 29)
                        .padding(.trailing, 23)
                }
            }

            NavigationView {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(viewModel.posts.filter {
                            searchinput.isEmpty ? true : ($0.title?.contains(searchinput) ?? false)
                        }, id: \.id) { post in
                            Button(action: {
                                DetailData(id: post.id)
                                isShowingDetail = true
                            }, label: {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 2)
                                    .frame(width: 370, height: 60)
                                    .padding(5)
                                    .overlay(
                                        HStack(alignment: .center){
                                            if let title = post.title {
                                                Text(title)
                                                    .foregroundColor(Color(hex: 0x4F4F4F))
                                                    .font(.system(size: 15).bold())
                                                    .frame(maxWidth: .infinity)
                                            } else {
                                                Text("제목이 없습니다.")
                                                    .font(.title)
                                                    .foregroundColor(Color(hex: 0x4F4F4F))
                                                    .font(.system(size: 15))
                                                    .frame(maxWidth: .infinity)
                                            }
                                            if let routeInfo = post.routeInfo {
                                                Text(routeInfo)
                                                    .font(.system(size: 10))
                                                    .foregroundColor(.gray)
                                                    .frame(maxWidth: .infinity)
                                            } else {
                                                Text("루트가 없습니다.")
                                                    .font(.subheadline)
                                                    .foregroundColor(.gray)
                                                    .frame(maxWidth: .infinity)
                                            }
                                        }
                                    )
                            })
                        }
                    }
                    .padding(.horizontal)
                }
                .sheet(isPresented: $isShowingDetail, onDismiss: {
                    shouldRefresh = true // 모달이 닫힐 때 shouldRefresh 변수를 true로 업데이트
                }, content: {
                    if let myStruct = myStruct {
                        MyStructDetail(myStruct: myStruct, isShowingDetail: $isShowingDetail)
                            .onDisappear {
                                if !isShowingDetail {
                                    // isShowingDetail이 false가 되면 뷰를 다시 로드합니다.
                                    viewModel.fetchData()
                                }
                            }
                    }
                })
                .onAppear {
                    viewModel.fetchData()
                }
                .onChange(of: shouldRefresh) { _ in // shouldRefresh 변수가 업데이트 될 때마다 수행되는 새로고침 함수
                    viewModel.fetchData()
                }
            }

        }
    }

    class ContentViewModel: ObservableObject {
        @Published var posts: [Post] = []

        func fetchData() {
            guard let url = URL(string: "http://skhuaz.duckdns.org/all-routes") else {
                print("Invalid URL")
                return
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    print("Error: No data received")
                    return
                }

                if data.isEmpty {
                    print("Error: Empty data received")
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601 // 날짜 형식 설정
                    let decodedPosts = try decoder.decode([Post].self, from: data)
                    DispatchQueue.main.async {
                        self.posts = decodedPosts
                    }
                } catch let error {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }.resume()
        }

    }

    struct MyStructDetail: View {
        let myStruct: MyStruct // 저장된 MyStruct 값
        @Binding var isShowingDetail: Bool
        @State var isShowingDetail1 = false
        @EnvironmentObject var userData: UserData
        @State var responseMessage: String = ""
        @State private var Showprintalert: Bool = false
        @State var nickname: String = UserDefaults.standard.string(forKey: "nickname") ?? ""


        func deleteData(id: Int) {
            guard let url = URL(string: "http://skhuaz.duckdns.org/routes/\(id)") else {
                print("Invalid URL")
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            let sessionId = userData.sessionId
            request.addValue(sessionId, forHTTPHeaderField: "sessionId")

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    isShowingDetail = false // MyStructDetail View를 표시할지 여부를 관리하는 상태 변수
                } else if let data = data {
                    if let responseMessage = String(data: data, encoding: .utf8) {
                        if responseMessage == "Route deleted successfully." {
                            print("삭제되었습니다.")
                            isShowingDetail = false
                        } else {
                            print("삭제에 실패했습니다.")
                            Showprintalert = true
                        }
                    } else {
                        print("삭제에 실패했습니다.")
                        Showprintalert = true
                    }
                } else {
                    print("삭제에 실패했습니다.")
                    Showprintalert = true
                }
            }
            .resume()
        }



        var body: some View {
            NavigationView{
                VStack {
                    Text("\(myStruct.userNickname)이 작성한 글입니다.")
                        .font(.system(size: 17))
                        .padding(.top, 20)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                        .frame(width: 370, height: 400)
                        .padding(5)
                        .overlay(content: {
                            VStack(content: {
                                Rectangle().fill(Color(hex: 0xEFEFEF))
                                    .frame(width: 350, height: 40)
                                    .cornerRadius(10)
                                    .overlay(content: {
                                        HStack {
                                            Text(myStruct.title)
                                                .foregroundColor(Color.black)
                                                .font(.system(size: 15))
                                                .padding(.leading, 17)
                                            Spacer()
                                        }
                                    })
                                
                                Rectangle().fill(Color(hex: 0xEFEFEF))
                                    .frame(width: 350, height: 40)
                                    .cornerRadius(10)
                                    .overlay(content: {
                                        HStack {
                                            Text(myStruct.department)
                                                .foregroundColor(Color.black)
                                                .font(.system(size: 15))
                                                .padding(.leading, 17)
                                            Spacer()
                                        }
                                    })
                                
                                Rectangle().fill(Color(hex: 0xEFEFEF))
                                    .frame(width: 350, height: 60)
                                    .cornerRadius(10)
                                    .overlay(content: {
                                        HStack {
                                            Text(myStruct.routeInfo).font(.system(size: 15))
                                        }
                                    })
                                
                                Text(myStruct.recommendation)
                                //                                .alignmentGuide(.leading) { d in d[.leading] }
                                    .font(.system(size: 15))
                                    .padding(.bottom, 90)
                                    .frame(width: 350, height: 160)
                                    .background(Color(hex: 0xEFEFEF))
                                    .cornerRadius(10)
                            })
                        })
                    Rectangle().fill(Color(hex: 0xEFEFEF))
                        .frame(width: 350, height: 40)
                        .cornerRadius(10)
                        .overlay(content: {
                            HStack {
                                Button(action: {
                                    isShowingDetail = false // MyStructDetail View를 표시할지 여부를 관리하는 상태 변수
                                    
                                }, label: {
                                    Text("목록으로")
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 15))
                                    
                                })
                            }
                        })
                    HStack(alignment: .top){
                        Rectangle().fill(Color(hex: 0xEFEFEF))
                            .frame(width: 150, height: 40)
                            .cornerRadius(10)
                            .overlay(content: {
                                HStack {
                                    NavigationLink(
                                        destination: Root_Mo(myStruct: myStruct, isShowingDetail: $isShowingDetail),
                                        isActive: $isShowingDetail1, // <-- add this
                                        label: {
                                            Button(action: {
                                                if myStruct.userNickname == userData.nickname {
                                                    isShowingDetail1 = true
                                                } else {
                                                    Showprintalert = true
                                                }
                                            }) {
                                                Text("수정")
                                                    .foregroundColor(Color.black)
                                                    .font(.system(size: 15))
                                            }
                                            .alert(isPresented: $Showprintalert) {
                                                Alert(title: Text("접근 권한 없음"), message: Text("해당 사용자의 정보를 수정할 수 있는 권한이 없습니다."), dismissButton: .default(Text("확인")))
                                            }
                                        }
                                    )
                                }

                            })
                        Spacer()
                        Rectangle().fill(Color(hex: 0xEFEFEF))
                            .frame(width: 150, height: 40)
                            .cornerRadius(10)
                            .overlay(content: {
                                HStack {
                                    Button(action: { // MyStructDetail View를 표시할지 여부를 관리하는 상태 변수
                                        deleteData(id: myStruct.id)
                                        
                                    }){
                                        Text("삭제")
                                            .foregroundColor(Color.black)
                                            .font(.system(size: 15))
                                            .frame(maxWidth: .infinity)
                                            .frame(maxHeight: .infinity)
                                            .background(Color(hex: 0x9AC1D1))
                                            .cornerRadius(10)
                                        
                                    }
                                    .alert(isPresented: $Showprintalert, content: {
                                        Alert(title: Text("알림"), message: Text("현재 사용자는 작성자가 아닙니다."), dismissButton: .default(Text("확인")))
                                    })
                                }
                            })
                    }
                    .padding()
                    .padding([.leading, .trailing], 5)
                    Spacer()
                }
                Spacer()
            }
            
        }
    }
}


