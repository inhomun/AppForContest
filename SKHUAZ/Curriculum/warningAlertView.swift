//
//  warningAlertView.swift
//  SKHUAZ
//
//  Created by 문인호 on 2023/04/13.
//

import SwiftUI

struct warningAlertView: View {
    @Binding var showModal: Bool
    @StateObject var api = RestAPI.shared

    var body: some View {
        VStack {
            Text("프론트엔드개발")
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
                    self.showModal.toggle()
                }
                }, label: {
                    Text("취소")
                })
                .buttonStyle(modalCancelButton())
                    NavigationLink {
                        CurriculumFrontend()
                    } label: {
                        Text("선택")
                    }
                    .buttonStyle(modalConfirmButton())
                }
            }
        }
    }
struct warningAlertView_Previews: PreviewProvider {
    static var previews: some View {
        warningAlertView(showModal: .constant(false))
    }
}
