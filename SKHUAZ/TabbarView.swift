import SwiftUI

struct TabbarView: View {
    @State private var index = 3
    @State var button1: Bool = false
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        TabView(selection: $index) {
            EvaluationView(selectedLectureID: 0)
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                .tabItem {
                    Image(systemName: "list.bullet.clipboard")
                    Text("강의평")
                }
                .tag(1)
              CurriculumView()
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                .tabItem {
                    Image(systemName: "lightbulb")
                    Text("커리큘럼")
                }
                .tag(2)
            MainView(index: $index)
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                .tabItem {
                    Image(systemName: "house")
                    Text("SKHUAZ")
                        .font(.system(size: 20))
                }
                .tag(3)
            RootView()
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
              .tabItem {
                  Image(systemName: "graduationcap.fill")
                  Text("루트추천")
              }
              .tag(4)
            SettingView()
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
              .tabItem {
                  Image(systemName: "map")
                  Text("설정")
              }
              .tag(5)
            
            }
            .accentColor(Color(hex: 0x9AC1D1))
            .navigationBarHidden(true)
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
