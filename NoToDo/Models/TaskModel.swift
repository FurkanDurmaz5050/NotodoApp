//
//  TaskModel.swift
//  MyToDoList
//
//  Created by Kodgem Technology on 3.02.2022.
//

import Foundation
import Firebase


struct fetchTask: Identifiable {
    
    var id: String
    var taskName: String
    var isCompleted: Bool
    var isDeleted: Bool
    var isFullHeight: Bool
    var taskDate: Date
    var taskClock: String
    var selectedColor: String
    var staticValue:String


}

struct fetchTask3: Identifiable {
    
    var id: String
    var taskName: String
    var isCompleted: Bool
    var isDeleted: Bool
    var isFullHeight: Bool
    var taskDate: Date
    var taskClock: String
    var selectedColor: String
    var staticValue:String


}

struct fetchFilterTask: Identifiable {
    
    var id: String
    var taskName: String
    var isCompleted: Bool
    var isDeleted: Bool
    var isFullHeight: Bool
    var taskDate: Date
    var taskClock: String
    var selectedColor: String
    var staticValue:String


}

struct fetchColor: Identifiable {
    
    var id: String
    var colorName: String
    var isSelectedColor: Bool
    var colorLabel: String

}

struct fetchTask2: Identifiable {
    
    var id = UUID().uuidString
    var taskName: String
    var isCompleted: Bool
    var error:String = ""

}
struct fetchUser: Identifiable {
    
    var id :String
    var email: String
    
    var nameAndSurname: String

}
