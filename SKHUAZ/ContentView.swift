//
//  ContentView.swift
//  SKHUAZ
//
//  Created by 천성우 on 2023/03/12.


import SwiftUI

struct ContentView: View {
    @State var isActive: Bool = true
    @State var loginSuccess = RestAPI.LogineSuccess
    
    var body: some View {
        ZStack {
//            Image("CircleLogo")
//                .resizable()
//                .frame(width: 300, height: 400)
//                .scaledToFit()
//                .clipShape(Circle())
//                .overlay(Circle().stroke(Color(hex: 0x9AC1D1), lineWidth: 1))
//                .ignoresSafeArea()
            
            if isActive {
                if loginSuccess {
                    TabbarView()
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                } else {
                    LoginView(login_onoff: false)
                }
            } else {
                
            }
        }
//        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
//                withAnimation {
//                    self.isActive = true
//                }
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
