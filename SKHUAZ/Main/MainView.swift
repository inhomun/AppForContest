import SwiftUI



struct MainView: View {
    func Semester_Change(semester: String) -> String{
        if semester == "8" {
            return "4학년 2학기"
        }
        else if semester == "7" {
            return "4학년 1학기"
        }
        else if semester == "6" {
            return "3학년 2학기"
        }
        else if semester == "5" {
            return "3학년 1학기"
        }
        else if semester == "4" {
            return "2학년 2학기"
        }
        else if semester == "3" {
            return "2학년 1학기"
        }
        else if semester == "2" {
            return "1학년 2학기"
        }
        else {
            return "1학년 1학기"
        }
    }
    @EnvironmentObject var userData: UserData
    
        @Binding var index: Int
        @StateObject var Login = RestAPI()
        var body: some View {
            NavigationView{
                VStack(spacing: 10){
                    Image("Logo")
                        .resizable()
                        .frame(width: 400, height: 200)
                        .padding(.bottom, 20)
                    Image("CircleLogo")
                        .resizable()
                        .frame(width: 200, height: 200)
                            .scaledToFit()
                        .clipShape(Circle())
                            .overlay(Circle().stroke(Color.black, lineWidth: 1))
                        .padding(.bottom, 20)
                    
                    HStack {
                        Text("닉네임 :")
                        Text(userData.nickname)
                    }
                    .padding(.bottom, 10)
                    HStack {
                        Text("학기 :")
                        Text(Semester_Change(semester:userData.semester))
                    }
                    .padding(.bottom, 10)
                    
                    if userData.department {
                        HStack {
                            Text("학부 :")
                            Text(userData.major1!)
                        }
                        .padding(.bottom, 10)
                    }
                    else if userData.major_minor {
                        VStack {
                            HStack {
                                Text("주전공 :")
                                Text(userData.major1!)
                            }
                            .padding(.bottom, 10)
                            HStack {
                                Text("부전공 :")
                                Text(userData.major2!)
                            }
                            .padding(.bottom, 10)
                        }
                        
                    }
                    else if userData.double_major {
                        VStack {
                            HStack {
                                Text("복수전공 1 :")
                                Text(userData.major1!)
                            }
                            .padding(.bottom, 10)
                            HStack {
                                Text("복수전공 2 :")
                                Text(userData.major2!)
                            }
                            .padding(.bottom, 10)
                        }
                        
                    }

                
                Spacer()
            }
        }    }
}

struct user_thumbs: View{
    var body: some View{
        VStack{
            HStack{
                Text("최근 진행한 선수과목제도")
                Spacer()
                
            }
            .font(.system(size: 10))
            .foregroundColor(Color(hex: 0x7D7D7D))
            Divider()
                .background(Color(hex: 0x4F4F4F))
            Group{
                Group{
                    VStack{
                        HStack{
                            Text("소프트웨어공학전공")
                            Spacer()
                        }
                        HStack{
                            Text("자바프로그래밍, 웹개발 입문 > 자료구조, 알고리즘 > 자바프로젝트")
                            Spacer()
                        }
                    }
                    .padding()
                }
                .frame(width: 350, height: 50)
                .background(Color(uiColor: .secondarySystemBackground))
                Group{
                    VStack{
                        HStack{
                            Text("소프트웨어공학전공")
                            Spacer()
                        }
                        HStack{
                            Text("자바프로그래밍, 웹개발 입문 > 자료구조, 알고리즘 > 자바프로젝트")
                            Spacer()
                        }
                    }
                    .padding()
                }
                .frame(width: 350, height: 50)
                .background(Color(uiColor: .secondarySystemBackground))
            }
            .font(.system(size: 10))
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
}


struct user_post: View{
    @Binding var index: Int
    var body: some View{
        VStack{
            HStack{
                Text("내가 최근 쓴 강의평")
                Spacer()
                Button {
                    index = 1
                } label: {
                    Text("더 보기")
                }
            }
            .font(.system(size: 10))
            .foregroundColor(Color(hex: 0x7D7D7D))
            Divider()
                .background(Color(hex: 0x4F4F4F))
            Group{
                Group{
                    HStack{
                        Text("강의명 | 교수님명")
                        Spacer()
                        Text("☆★★★★")
                    }
                    .padding()
                }
                .frame(width: 350, height: 50)
                .background(Color(uiColor: .secondarySystemBackground))
                Group{
                    HStack{
                        Text("강의명 | 교수님명")
                        Spacer()
                        Text("☆★★★★")
                    }
                    .padding()
                }
                .frame(width: 350, height: 50)
                .background(Color(uiColor: .secondarySystemBackground))
            }
            .font(.system(size: 12))
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}


