//
//  E_modify.swift
//  SKHUAZ
//
//  Created by 박신영 on 2023/04/12.
//

import SwiftUI

struct thirdLecture: Codable, Equatable {
    let id: Int
    let lectureName: String
    let prfsName: String
    let classYear: Int
    let semester: Int
    let department: String
    let teamPlay: Int
    let task: Int
    let practice: Int
    let presentation: Int
    let review: String?
    let userNickname: String
}
struct E_modify: View {
    @Binding var selectedLectureID: Int
        @State private var equal = false
    @State private var lectureName: String = "" // 과목명
    @State private var prfsName: String = ""    // 교수님 성함
    @State private var classYear: String = "수강년도"   // 수강년도
    @State private var semester: String = ""   // 1 or 2 학기
    @State private var department: String = "학과를 선택해주세요"  // 전공구분
    @State private var is_major_required: Bool = false  // 전공필수 여부
    @State private var teamPlay: String = "1 upto 5" // 팀플비중
    @State private var task: String = "1 upto 5" // 과제량
    @State private var practice: String = "1 upto 5" // 연습
    @State private var presentation: String = "1 upto 5" // 발표
    @State private var review: String = "  총평 : " // 강의총평
    var body: some View {
        Text("Hello, World! \(selectedLectureID)")

    }
}
