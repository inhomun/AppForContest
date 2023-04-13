//
//  CurriculumDCView.swift
//  SKHUAZ
//
//  Created by 문인호 on 2023/04/13.
//

import SwiftUI

struct CurriculumDCView: View {
    @State var showModal: Bool = false
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
                                    Spacer().frame(width: 43, height: 10)
                                    Button {
                                        print("java")
                                    } label: {
                                        Text("소프트웨어공학전공")
                                    }
                                    .buttonStyle(highlightButton())
                                }
                                HStack{
                                    Spacer().frame(width: 40, height: 10)
                                    Text("데이터 통신 > ")
                                        .font(.system(size: 10))
                                        .padding()
                                }
                            }
                        }
                        HStack(spacing: 20){
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    self.showModal.toggle()
                                }
                            }, label:
                                    {
                                Text(computerNetwork.name)
                            })
                            .buttonStyle(redSubjecButton())
                            Spacer()
                        }
                        
                    }
                }
                if showModal {
                    Rectangle() // the semi-transparent overlay
                        .foregroundColor(Color.black.opacity(0.5))
                        .edgesIgnoringSafeArea(.all)

                    ZStack { // the modal container
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width/5*4, height: UIScreen.main.bounds.height/3, alignment: .center)
                            .overlay(dataSaveCN(showModal: self.$showModal))
                            .shadow(color: Color.gray.opacity(0.4), radius: 4)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.move(edge: .bottom))
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
    }
}
struct CurriculumDCView_Previews: PreviewProvider {
    static var previews: some View {
        CurriculumDCView()
    }
}


struct dataSaveCN: View {
    @Binding var showModal: Bool
    @StateObject var api = RestAPI.shared

    var body: some View {
        VStack {
            Text(computerNetwork.name)
                .font(.system(size: 20,weight: .semibold,design: .default))
                .foregroundColor(.pointColorR)
            Text(" ")
            Text("해당 과목은 커리큘럼의 마지막 과목입니다.")
            Text("해당 과목을 선택하면 자동으로 루트가 저장됩니다.")
            Text("해당 과목을 추가하시겠습니까?")
            HStack(spacing: 30){
                Button(action: {
                withAnimation {
                    self.showModal.toggle()
                }
                }, label: {
                    Text("취소")
                })
                .buttonStyle(modalCancelButton())
                Button(action: {
                    self.showModal.toggle()
                    print("Save button tapped")
                    api.saveRouteInfo(info: "데이터통신 > 컴퓨터네트워크") { success in
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
