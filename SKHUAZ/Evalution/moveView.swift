import SwiftUI

struct moveView: View {
    @Binding var selectedLectureID: Int
    
    var body: some View {
        Text("선택한 강의 ID: \(selectedLectureID)")
    }
}
