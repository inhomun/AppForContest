//
//  subjectModel.swift
//  SKHUAZ
//
//  Created by 문인호 on 2023/04/13.
//

import Foundation
import Combine
var selectedSubjects = [subject]()
class subject: ObservableObject{
    var name : String
    var depth : Int
    var isClicked : Bool = false
    var prerequisite : subject?
//    init(name: String, depth : Int) {
//           self.name = name
//        self.depth = depth
//        }
//
    init(name: String, depth : Int, prerequisite : subject? = nil) {
           self.name = name
        self.depth = depth
        self.prerequisite = prerequisite
        }
}

var javaProgramming = subject(name: "자바 프로그래밍", depth: 1)
var networkProgramming = subject(name: "네트워크 프로그래밍", depth: 1)
var dataStructure = subject(name: "자료구조", depth: 2)
var algorithm = subject(name: "알고리즘", depth: 3)
var mobileProgramming = subject(name: "모바일프로그래밍", depth: 3, prerequisite: webIntroduction)
var frontendDevelop = subject(name: "프론트엔드개발", depth: 2, prerequisite: dataStructure)
var frontendFramework = subject(name: "프론트엔드프레임워크", depth: 3)
var webProgramming = subject(name: "웹프로그래밍", depth: 2, prerequisite: webIntroduction)
var javaProject = subject(name: "자바프로젝트", depth: 2)
var advancedJavaProgramming = subject(name: "고급자바프로그래밍", depth: 2)
var webIntroduction = subject(name: "웹개발입문", depth: 1)
var backendFramework = subject(name: "백엔드프레임워크", depth: 4)
var hybridProgramming = subject(name: "하이브리드 앱 프로그래밍", depth: 3)
var pythonProgramming = subject(name: "파이썬 프로그래밍", depth: 1)
var pythonProject = subject(name: "파이썬 프로젝트", depth: 2)
var dataBase = subject(name: "데이터베이스", depth: 2)
var dataCommunication = subject(name: "데이터 통신", depth: 1)
var computerNetwork = subject(name: "컴퓨터 네트워크", depth: 2)
var operationSystem = subject(name: "운영체제", depth: 1)
var serverBuild = subject(name: "서버구축 및 형상관리", depth: 2)
var iotBase = subject(name: "사물인터넷 기초", depth: 1)
var iot = subject(name: "사물인터넷", depth: 2)

func showSortedClasses(_ arr: [subject]) -> String {
    let sortedArr = arr.sorted { $0.depth < $1.depth }
    var depthGroups = [Int: [subject]]()
    
    for obj in sortedArr {
        if let group = depthGroups[obj.depth] {
            depthGroups[obj.depth] = group + [obj]
        } else {
            depthGroups[obj.depth] = [obj]
        }
    }
    
    var result = ""
    for depth in depthGroups.keys.sorted() {
        let objects = depthGroups[depth]!
        if objects.count == 1 {
            result += objects[0].name
        } else {
            let sortedObjects = objects.sorted { $0.name < $1.name }
            var objStrings = sortedObjects.map { $0.name }
            if sortedObjects[0].depth > sortedObjects[1].depth {
                objStrings[objStrings.count-1] += ">"
            }
            result += objStrings.joined(separator: ",")
        }
    }
    return result
}
