//
//  CurriculumJavaView.swift
//  pbch
//
//  Created by 문인호 on 2023/03/13.
//
import SwiftUI

struct CurriculumJavaView: View {
    @State var showModal: Bool = false
    @State var isNP: Bool = false
    @State var isWP: Bool = false
    @State var isJP: Bool = false
    @State var isAdvancedJP: Bool = false
    @State var isMP: Bool = false
    @StateObject var api = RestAPI.shared
    var body: some View {
            ZStack{
                ScrollView{
                    VStack(alignment: .leading, spacing: 50){
                        Image("skhuazbanner")
                            .resizable()
                            .frame(width: 400, height: 200)
                            .padding(.bottom, 5)

                        VStack(alignment: .leading, spacing: 1){
                            VStack(alignment: .leading, spacing: 1){
                                HStack{
                                    Spacer().frame(width: 40, height: 10)
                                    Button {
                                        print("java")
                                    } label: {
                                        Text("소프트웨어공학전공")
                                    }
                                    .buttonStyle(highlightButton())
                                }
                                
                                HStack{
                                    Spacer().frame(width: 40, height: 10)
                                    Text("자바프로그래밍 > ")
                                        .font(.system(size: 10))
                                        .padding()

                                }
                            }
                        }
                        HStack(spacing: 20){
                            Spacer()
                            NavigationLink {
                                CurriculumDataStructureView()
                            } label: {
                                Text("자료구조")
                            }
                            .buttonStyle(redSubjecButton())
                            Button(action: {
                                withAnimation {
                                    self.isNP.toggle()
                                }
                            }, label:
                                    {
                                Text("네트워크 프로그래밍")
                            })
                                .buttonStyle(redSubjecButton())
                                Spacer()
                            }
                            HStack(spacing: 20){
                                Spacer()
                                Button(action: {
                                    withAnimation {
                                        self.showModal.toggle()
                                    }
                                }, label:
                                        {
                                    Text("프론트엔드개발")
                                })
                                .buttonStyle(redSubjecButton())
                                Button(action: {
                                    withAnimation {
                                        self.isWP.toggle()
                                    }
                                }, label:
                                        {
                                    Text("웹프로그래밍")
                                })                                .buttonStyle(redSubjecButton())
                                Spacer()
                            }
                            HStack(spacing: 20){
                                Spacer()
                                Button(action: {
                                    withAnimation {
                                        self.isMP.toggle()
                                    }
                                }, label:
                                        {
                                    Text(mobileProgramming.name)
                                })
                                .buttonStyle(redSubjecButton())
                                Button(action: {
                                    withAnimation {
                                        self.isJP.toggle()
                                    }
                                }, label:
                                        {
                                    Text("자바 프로젝트")
                                })
                                .buttonStyle(redSubjecButton())
                                Spacer()
                            }
                            HStack{
                                Spacer().frame(width: 40, height: 10)
                                Button(action: {
                                    withAnimation {
                                        self.isAdvancedJP.toggle()
                                    }
                                }, label:
                                        {
                                    Text("고급 자바 프로그래밍")
                                })
                                .buttonStyle(redSubjecButton())
                            }
                        }
                    
                    }
                if isNP {
                    Rectangle() // the semi-transparent overlay
                        .foregroundColor(Color.black.opacity(0.5))
                        .edgesIgnoringSafeArea(.all)

                    ZStack { // the modal container
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width/5*4, height: UIScreen.main.bounds.height/3, alignment: .center)
                            .overlay(dataSaveNP(isNP: self.$isNP))
                            .shadow(color: Color.gray.opacity(0.4), radius: 4)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.move(edge: .bottom))
                }
                else if isJP {
                    Rectangle() // the semi-transparent overlay
                        .foregroundColor(Color.black.opacity(0.5))
                        .edgesIgnoringSafeArea(.all)

                    ZStack { // the modal container
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width/5*4, height: UIScreen.main.bounds.height/3, alignment: .center)
                            .overlay(dataSaveJP(isJP: self.$isJP))
                            .shadow(color: Color.gray.opacity(0.4), radius: 4)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.move(edge: .bottom))
                }
                else if isWP {
                    Rectangle() // the semi-transparent overlay
                        .foregroundColor(Color.black.opacity(0.5))
                        .edgesIgnoringSafeArea(.all)

                    ZStack { // the modal container
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width/5*4, height: UIScreen.main.bounds.height/3, alignment: .center)
                            .overlay(warningWP(isWP: self.$isWP))
                            .shadow(color: Color.gray.opacity(0.4), radius: 4)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.move(edge: .bottom))
                }
                else if isMP {
                    Rectangle() // the semi-transparent overlay
                        .foregroundColor(Color.black.opacity(0.5))
                        .edgesIgnoringSafeArea(.all)

                    ZStack { // the modal container
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width/5*4, height: UIScreen.main.bounds.height/3, alignment: .center)
                            .overlay(dataSaveMP(isMP: self.$isMP))
                            .shadow(color: Color.gray.opacity(0.4), radius: 4)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.move(edge: .bottom))
                }
                else if isAdvancedJP {
                    Rectangle() // the semi-transparent overlay
                        .foregroundColor(Color.black.opacity(0.5))
                        .edgesIgnoringSafeArea(.all)

                    ZStack { // the modal container
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width/5*4, height: UIScreen.main.bounds.height/3, alignment: .center)
                            .overlay(dataSaveAJP(isAdvancedJP: self.$isAdvancedJP))
                            .shadow(color: Color.gray.opacity(0.4), radius: 4)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.move(edge: .bottom))
                }
                else if showModal {
                    Rectangle() // the semi-transparent overlay
                        .foregroundColor(Color.black.opacity(0.5))
                        .edgesIgnoringSafeArea(.all)

                    ZStack { // the modal container
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width/5*4, height: UIScreen.main.bounds.height/3, alignment: .center)
                            .overlay(warningAlertView(showModal: self.$showModal))
                            .shadow(color: Color.gray.opacity(0.4), radius: 4)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.move(edge: .bottom))
                }
                
            }
        .navigationViewStyle(StackNavigationViewStyle())
        }
    }
struct CurriculumJavaView_Previews: PreviewProvider {
    static var previews: some View {
        CurriculumJavaView()
    }
}

struct dataSaveNP: View {
    @Binding var isNP: Bool
    @StateObject var api = RestAPI.shared
    var body: some View {
        VStack {
            Text(networkProgramming.name)
                .font(.system(size: 20,weight: .semibold,design: .default))
                .foregroundColor(.pointColorR)
            Text(" ")
            Text("해당 과목은 커리큘럼의 마지막 과목입니다.")
            Text("해당 과목을 선택하면 자동으로 루트가 저장됩니다.")
            Text("해당 과목을 추가하시겠습니까?")
            HStack(spacing: 30){
                Button(action: {
                withAnimation {
                    self.isNP.toggle()
                }
                }, label: {
                    Text("취소")
                })
                .buttonStyle(modalCancelButton())
                Button(action: {
                    self.isNP.toggle()
                    print("Save button tapped")
                    api.saveRouteInfo(info: "자바프로그래밍 > 네트워크 프로그래밍") { success in
                        if success {
                            print("Saved successfully")
                            // 저장 성공 처리
                        } else {
                            print("Error occurred")
                            // 저장 실패 처리
                        }
                    }
                }) {
                    Text("선택")
                }
                    .buttonStyle(modalConfirmButton())
                }
            }
        }
    }

struct dataSaveMP: View {
    @Binding var isMP: Bool
    @StateObject var api = RestAPI.shared

    var body: some View {
        VStack {
            Text(mobileProgramming.name)
                .font(.system(size: 20,weight: .semibold,design: .default))
                .foregroundColor(.pointColorR)
            Text(" ")
            Text("해당 과목은 커리큘럼의 마지막 과목이며")
            Text("선수 과목이 두개입니다.")
            Text("해당 과목을 선택하면 자동으로 루트가 저장됩니다.")
            Text("해당 과목을 추가하시겠습니까?")
            HStack(spacing: 30){
                Button(action: {
                withAnimation {
                    self.isMP.toggle()
                }
                }, label: {
                    Text("취소")
                })
                .buttonStyle(modalCancelButton())
                Button(action: {
                    self.isMP.toggle()
                    print("Save button tapped")
                    api.saveRouteInfo(info: "자바프로그래밍 > 자료구조 > 모바일 프로그래밍") { success in
                        if success {
                            print("Saved successfully")
                            // 저장 성공 처리
                        } else {
                            print("Error occurred")
                            // 저장 실패 처리
                        }
                    }
                }) {
                    Text("선택")
                }
                    .buttonStyle(modalConfirmButton())
                }
            }
        }
    }

struct dataSaveJP: View {
    @Binding var isJP: Bool
    @StateObject var api = RestAPI.shared

    var body: some View {
        VStack {
            Text(javaProject.name)
                .font(.system(size: 20,weight: .semibold,design: .default))
                .foregroundColor(.pointColorR)
            Text(" ")
            Text("해당 과목은 커리큘럼의 마지막 과목입니다.")
            Text("해당 과목을 선택하면 자동으로 루트가 저장됩니다.")
            Text("해당 과목을 추가하시겠습니까?")
            HStack(spacing: 30){
                Button(action: {
                withAnimation {
                    self.isJP.toggle()
                }
                }, label: {
                    Text("취소")
                })
                .buttonStyle(modalCancelButton())
                Button(action: {
                    self.isJP.toggle()
                    print("Save button tapped")
                    api.saveRouteInfo(info: "자바프로그래밍 > 자바 프로젝트") { success in
                        if success {
                            print("Saved successfully")
                            // 저장 성공 처리
                        } else {
                            print("Error occurred")
                            // 저장 실패 처리
                        }
                    }
                }) {
                    Text("선택")
                }
                    .buttonStyle(modalConfirmButton())
                }
            }
        }
    }

struct dataSaveAJP: View {
    @Binding var isAdvancedJP: Bool
    @StateObject var api = RestAPI.shared

    var body: some View {
        VStack {
            Text(advancedJavaProgramming.name)
                .font(.system(size: 20,weight: .semibold,design: .default))
                .foregroundColor(.pointColorR)
            Text(" ")
            Text("해당 과목은 커리큘럼의 마지막 과목입니다.")
            Text("해당 과목을 선택하면 자동으로 루트가 저장됩니다.")
            Text("해당 과목을 추가하시겠습니까?")
            HStack(spacing: 30){
                Button(action: {
                withAnimation {
                    self.isAdvancedJP.toggle()
                }
                }, label: {
                    Text("취소")
                })
                .buttonStyle(modalCancelButton())
                Button(action: {
                    self.isAdvancedJP.toggle()
                    print("Save button tapped")
                    api.saveRouteInfo(info: "자바프로그래밍 > 고급 자바 프로그래밍") { success in
                        if success {
                            print("Saved successfully")
                            // 저장 성공 처리
                        } else {
                            print("Error occurred")
                            // 저장 실패 처리
                        }
                    }
                }) {
                    Text("선택")
                }
                    .buttonStyle(modalConfirmButton())
                }
            }
        }
    }

struct warningWP: View {
    @Binding var isWP: Bool
    @StateObject var api = RestAPI.shared

    var body: some View {
        VStack {
            Text("웹프로그래밍")
                .font(.system(size: 20,weight: .semibold,design: .default))
                .foregroundColor(.pointColorR)
            Text(" ")
            Text("해당 과목은 선수과목이 두개입니다.")
            Text("해당 과목을 선택하면 자동으로 선수과목이")
            Text("리스트에 추가됩니다.")
            Text("해당 과목을 추가하시겠습니까?")
            HStack(spacing: 30){
                Button(action: {
                withAnimation {
                    self.isWP.toggle()
                }
                }, label: {
                    Text("취소")
                })
                .buttonStyle(modalCancelButton())
                    NavigationLink {
                        CurriculumWebDevLastView()
                    } label: {
                        Text("선택")
                    }
                    .buttonStyle(modalConfirmButton())
                }
            }
        }
    }
