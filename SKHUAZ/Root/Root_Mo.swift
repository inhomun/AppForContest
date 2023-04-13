
import SwiftUI


struct Root_Mo : View{
    
    let myStruct: MyStruct // 저장된 MyStruct 값
    @Binding var isShowingDetail: Bool
    @EnvironmentObject var userData: UserData
    @State var responseMessage: String = ""
    @State private var Showprint: Bool = false
    @State var shouldRefreshed = false
    
    @State private var title: String = ""
    @State private var department: String = ""
    @State private var recommendation: String = ""
    @State private var departmentMessage: String = "전공선택을 해주세요"
    
    
    @Environment(\.presentationMode) var presentationModeRoot

    
    
    //    request.addValue(sessionId, forHTTPHeaderField: "sessionId")
    func loadData() {
        // Load data from server and update view state
    }
    func saveChanges(id: Int, dismissModal: @escaping () -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: "http://skhuaz.duckdns.org/routes/\(id)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let sessionId = userData.sessionId
        request.setValue(sessionId, forHTTPHeaderField: "sessionId")
        
        let parameters: [String: Any] = [
            "title": title,
            "department": department,
            "recommendation": recommendation
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
        } catch {
            print("Error serializing JSON: \(error)")
            return
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: \(error!)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error: Invalid response")
                return
            }
            
            DispatchQueue.main.async {
                dismissModal()
            }
        }
        
        task.resume()
    }

    
    var body: some View{
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
                                        TextField("제목을 입력해 주세요", text: $title)
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
                                        Group{
                                            Menu("\(departmentMessage)"){
                                                Button("소프트웨어공학과", action: {
                                                    department = "소프트웨어공학"
                                                    departmentMessage = "소프트웨어공학"
                                                })
                                                Button("정보통신공학과", action: {
                                                    department = "정보통신공학"
                                                    departmentMessage = "정보통신공학"
                                                })
                                                Button("컴퓨터공학과", action: {
                                                    department = "컴퓨터공학"
                                                    departmentMessage = "컴퓨터공학"
                                                })
                                                Button("인공지능", action: {
                                                    department = "인공지능"
                                                    departmentMessage = "인공지능"
                                                })
                                            }
                                        }
                                        
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
                            
                            TextField("여기에 대충 안내문", text: $recommendation)
                                .alignmentGuide(.leading) { d in d[.leading] }
                                .font(.system(size: 15))
                                .padding(.bottom, 90)
                                .frame(width: 350, height: 160)
                                .background(Color(hex: 0xEFEFEF))
                                .cornerRadius(10)
                            
                            
                        })
                        
                    })
                Rectangle().fill(Color(hex: 0x9AC1D1))
                    .frame(width: 350, height: 40)
                    .cornerRadius(10)
                    .overlay(content: {
                        HStack {
                            Button(action: {
                                saveChanges(id: myStruct.id) {
                                    presentationModeRoot.wrappedValue.dismiss()

                                    }
                                
                            }) {
                                Text("저장")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 15))
                            }
                            
                        }
                    })
            }
        }
        .onAppear{
            title = myStruct.title
            department = myStruct.department
            recommendation = myStruct.recommendation
            departmentMessage = myStruct.department
        }
    }
}

