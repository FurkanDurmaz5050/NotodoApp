//
//  TaskManager.swift
//  MyToDoList
//
//  Created by Kodgem Technology on 3.02.2022.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI
import FirebaseAuth
import CoreHaptics
import AVFoundation



class TaskManager: ObservableObject {
    let db: Firestore = Firestore.firestore()
    let auth = Auth.auth()

    @Published var fetchFieldUser: [fetchUser] = []

    @Published var fetchField: [fetchTask] = []
    @Published var fetchField2: [fetchTask3] = []

    @Published var fetchFieldColor: [fetchColor] = []
    @Published var fetchFieldFilter: [fetchFilterTask] = []

    @Published var isMainPage = true
    @Published var viewState = CGSize.zero
    @Published var signUpErrorText:String = ""
    @Published var logInErrorText:String = ""
    @Published var isSignedIn:Bool = false
    @Published var isLogIn:Bool = false
    @Published var userID:String = ""
    @Published var isCurrentUser:Bool = false
    @Published var isAddedTask:Bool = false
    @Published var isDeletedTask:Bool = false
    @Published var oylananKisi: Int = 2
    @Published var toplamKisi: Int = 0
    @Published var isClickedCircle:Bool = false

   



    var player: AVAudioPlayer?

    func playSound() {
        guard let url = Bundle.main.url(forResource: "mixkit-long-pop-2358", withExtension: "wav") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    

    
//    init() {
//        isUserSignIn()
//    }
    
    
    func addTaskFB(taskID: String, taskName: String, isCompleted:Bool, currentUserID:String, taskDate:Date, selectedColor: String, taskClock:String){
        
        db.collection("User").document("\(currentUserID)").collection("Task").document(taskID).setData([
            "id": taskID,
            "taskName": taskName,
            "isCompleted": isCompleted,
            "taskDate": taskDate,
            "taskClock": taskClock,
            "selectedColor": selectedColor,
            "staticValue": "staticValue",

            
            
        ]){ err in
            if let err = err {
                print("Error writing document: \(err)")
                
            } else {
                print("Document successfully written ID: \(taskID)")
                self.isAddedTask = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {  /// Anything over 0.5 seems to work
                    self.isAddedTask = false
                }
                
            }
        }
        db.collection("MainTask").document(taskID).setData([
            "id": taskID,
            "taskName": taskName,
            "isCompleted": isCompleted,
            "userID": currentUserID,
            "taskDate": taskDate,
            "taskClock": taskClock,
            "selectedColor": selectedColor,
            "staticValue": "staticValue",


            
        ]){ err in
            if let err = err {
                print("Error writing document: \(err)")
                
            } else {
                print("Document successfully written ID: \(taskID)")
                self.isAddedTask = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {  /// Anything over 0.5 seems to work
                    self.isAddedTask = false
                }
                
            }
        }
    }
    func addColorFB(isSelectedColor: Bool, colorLabel:String, currentUserID:String, colorName:String, id:String){
        
        db.collection("User").document("\(currentUserID)").collection("Colors").document(colorName).setData([
            
            "id": id,
            "colorName": colorName,
            "colorLabel": colorLabel,
            "isSelectedColor": isSelectedColor,
            
        ]){ err in
            if let err = err {
                print("Error writing document: \(err)")
                
            } else {
                print("Document successfully written ID: \("taskID")")
               
                
            }
        }
        
    }
    
    func updateTaskFB(taskID: String, taskName: String, isCompleted:Bool, currentUserID:String, isDeleted:Bool, isFullHeight:Bool){
        db.collection("User").document("\(currentUserID)").collection("Task").document(taskID).updateData([
            
            "taskName": taskName.self,
            "isCompleted": isCompleted.self,
            "isDeleted": isDeleted.self,
            "isFullHeight": isFullHeight.self,
            "userID": currentUserID.self,

        ]){ err in
            if let err = err {
                print("Error writing document: \(err)")
                
            } else {
                print("Document successfully Updated ID: \(taskID)")
                print(isDeleted)
                
            }
        }
        db.collection("MainTask").document(taskID).updateData([
            
            "taskName": taskName.self,
            "isCompleted": isCompleted.self,
            "isDeleted": isDeleted.self,
            "isFullHeight": isFullHeight.self,


        ]){ err in
            if let err = err {
                print("Error writing document: \(err)")
                
            } else {
                print("Document successfully Updated ID: \(taskID)")
                
            }
        }
    }
    
    func deleteTaskFB(taskID: String, currentUserID:String){
        
        db.collection("User").document("\(currentUserID)").collection("Task").document(taskID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
                self.isDeletedTask = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {  /// Anything over 0.5 seems to work
                    self.isDeletedTask = false
                }
            }
        }
        db.collection("MainTask").document(taskID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
                self.isDeletedTask = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {  /// Anything over 0.5 seems to work
                    self.isDeletedTask = false
                }
            }
        }
        
        
    }
    func signUp(textEmail:String, textPassword:String, textName:String) {
        auth.createUser(withEmail: textEmail, password: textPassword) { result, error in
            guard result != nil, error == nil else {
                
                self.signUpErrorText = error?.localizedDescription ?? ""
                
                return
            }
            
            guard let userUID = Auth.auth().currentUser?.uid else { return }

            self.userID = "\(userUID)"
            DispatchQueue.main.async {
                self.db.collection("User").document(userUID).setData([
                            "id": userUID,
                            "mail": textEmail,
                            "name": textName,
                            

                            
                            
                        ]){ err in
                            if let err = err {
                                print("Error writing document: \(err)")
                                
                            } else {
                                print("Document successfully written ID: \(userUID)")
                                
                            }
                        }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
                    self.isSignedIn = true

                }
                
                
                
            }
        }
    }
    
    func loginFB(textLogInEmail:String, textLogInPassword:String) {
        
        
        
        Auth.auth().signIn(withEmail: textLogInEmail, password: textLogInPassword) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                self.logInErrorText = error?.localizedDescription ?? ""
                
            } else {
                guard let userUID = Auth.auth().currentUser?.uid else { return }
                
                print("success: \(userUID)")
                
                self.userID = "\(userUID)"
                self.isLogIn = true
                
                
                
            }
        }
        
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        print("furkan")
    }
    
    func fetchTaskFB(currentUserID:String){
        
        
        db.collection("User").document("\(currentUserID)").collection("Task").order(by: "isCompleted",descending: false).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("nooooo")
                return
            }

            self.fetchField = documents.map { ( queryDocumentSnapshot ) -> fetchTask in
                let data = queryDocumentSnapshot.data()
                let id = data["id"] as? String ?? ""
                let taskName = data["taskName"] as? String ?? ""
                let isCompleted = data["isCompleted"] as? Bool ?? false
                let isDeleted = data["isDeleted"] as? Bool ?? false
                let isFullHeight = data["isFullHeight"] as? Bool ?? false
                let taskDate = data["taskDate"] as? Date ?? Date.now
                let taskClock = data["taskClock"] as? String ?? ""
                let selectedColor = data["selectedColor"] as? String ?? ""
                let staticValue = data["staticValue"] as? String ?? ""


 
                return fetchTask(id: id, taskName: taskName, isCompleted: isCompleted, isDeleted: isDeleted, isFullHeight: isFullHeight, taskDate: taskDate, taskClock: taskClock, selectedColor: selectedColor, staticValue: staticValue)
            }
            
        }
        
    }
    func fetchColorFB(currentUserID:String){
        
        
        db.collection("User").document("\(currentUserID)").collection("Colors").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("nooooo")
                return
            }

            self.fetchFieldColor = documents.map { ( queryDocumentSnapshot ) -> fetchColor in
                let data = queryDocumentSnapshot.data()
                let id = data["id"] as? String ?? ""
                let colorName = data["colorName"] as? String ?? ""
                let isSelectedColor = data["isSelectedColor"] as? Bool ?? false
                let colorLabel = data["colorLabel"] as? String ?? ""

                

 
                return fetchColor(id: id, colorName: colorName, isSelectedColor: isSelectedColor, colorLabel: colorLabel)
            }
            
        }
        
    }
    func fetchLabelFB(currentUserID:String, selectedColor: String, isFilterTask: Bool, isComplated: Bool){
        
        db.collection("User").document("\(currentUserID)").collection("Task").whereField(isFilterTask ? "selectedColor" : "staticValue", isEqualTo: isFilterTask ? selectedColor : "staticValue").order(by: "isCompleted", descending: false).addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else{
                    print("nooooo")
                    return
                }
                

                self.fetchField = documents.map { ( queryDocumentSnapshot ) -> fetchTask in
                    let data = queryDocumentSnapshot.data()
                    let id = data["id"] as? String ?? ""
                    let taskName = data["taskName"] as? String ?? ""
                    let isCompleted = data["isCompleted"] as? Bool ?? false
                    let isDeleted = data["isDeleted"] as? Bool ?? false
                    let isFullHeight = data["isFullHeight"] as? Bool ?? false
                    let taskDate = data["taskDate"] as? Date ?? Date.now
                    let taskClock = data["taskClock"] as? String ?? ""
                    let selectedColor = data["selectedColor"] as? String ?? ""
                    let staticValue = data["staticValue"] as? String ?? ""


     
                    return fetchTask(id: id, taskName: taskName, isCompleted: isCompleted, isDeleted: isDeleted, isFullHeight: isFullHeight, taskDate: taskDate, taskClock: taskClock, selectedColor: selectedColor, staticValue: staticValue)
                }
                
            }


        
        
        
    }
    func fetchLabelFB2(currentUserID:String, selectedColor: String, isFilterTask: Bool, isComplated: Bool){
        
        db.collection("User").document("\(currentUserID)").collection("Task").whereField("selectedColor", isEqualTo: selectedColor).addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else{
                    print("nooooo")
                    return
                }
                

                self.fetchField2 = documents.map { ( queryDocumentSnapshot ) -> fetchTask3 in
                    let data = queryDocumentSnapshot.data()
                    let id = data["id"] as? String ?? ""
                    let taskName = data["taskName"] as? String ?? ""
                    let isCompleted = data["isCompleted"] as? Bool ?? false
                    let isDeleted = data["isDeleted"] as? Bool ?? false
                    let isFullHeight = data["isFullHeight"] as? Bool ?? false
                    let taskDate = data["taskDate"] as? Date ?? Date.now
                    let taskClock = data["taskClock"] as? String ?? ""
                    let selectedColor = data["selectedColor"] as? String ?? ""
                    let staticValue = data["staticValue"] as? String ?? ""


     
                    return fetchTask3(id: id, taskName: taskName, isCompleted: isCompleted, isDeleted: isDeleted, isFullHeight: isFullHeight, taskDate: taskDate, taskClock: taskClock, selectedColor: selectedColor, staticValue: staticValue)
                }
                
            }


        
        
        
    }
    func fetchLabelAllFB(currentUserID:String, selectedColor: String, isFilterTask: Bool, isComplated: Bool){
        
        db.collection("User").document("\(currentUserID)").collection("Task").order(by: "isCompleted", descending: false).addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else{
                    print("nooooo")
                    return
                }
                

                self.fetchField = documents.map { ( queryDocumentSnapshot ) -> fetchTask in
                    let data = queryDocumentSnapshot.data()
                    let id = data["id"] as? String ?? ""
                    let taskName = data["taskName"] as? String ?? ""
                    let isCompleted = data["isCompleted"] as? Bool ?? false
                    let isDeleted = data["isDeleted"] as? Bool ?? false
                    let isFullHeight = data["isFullHeight"] as? Bool ?? false
                    let taskDate = data["taskDate"] as? Date ?? Date.now
                    let taskClock = data["taskClock"] as? String ?? ""
                    let selectedColor = data["selectedColor"] as? String ?? ""
                    let staticValue = data["staticValue"] as? String ?? ""


     
                    return fetchTask(id: id, taskName: taskName, isCompleted: isCompleted, isDeleted: isDeleted, isFullHeight: isFullHeight, taskDate: taskDate, taskClock: taskClock, selectedColor: selectedColor, staticValue: staticValue)
                }
                
            }


        
        
        
    }

    func fetchUserFB(userID:String){

        
        db.collection("User").whereField("id", isEqualTo: "\(userID)").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("nooooo")
                return
            }

            self.fetchFieldUser = documents.map { ( queryDocumentSnapshot ) -> fetchUser in
                let data = queryDocumentSnapshot.data()
                let id = data["id"] as? String ?? ""
                let email = data["mail"] as? String ?? ""
                let name = data["name"] as? String ?? ""

               
                
                StaticClass.userName = name.description ?? ""
                StaticClass.currentUserID = id.description ?? ""

                
 
                return fetchUser(id: id ,email: email, nameAndSurname: name)
            }
            
        }
        
    }

    func fetchLabelFBComplated(currentUserID:String, selectedColor: String){
        
//        if isFilterTask{
        db.collection("User").document("\(currentUserID)").collection("Task").whereField("selectedColor" , isEqualTo: selectedColor).whereField("isCompleted", isEqualTo: true).addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else{
                    print("nooooo")
                    return
                }
                

                self.fetchFieldFilter = documents.map { ( queryDocumentSnapshot ) -> fetchFilterTask in
                    let data = queryDocumentSnapshot.data()
                    let id = data["id"] as? String ?? ""
                    let taskName = data["taskName"] as? String ?? ""
                    let isCompleted = data["isCompleted"] as? Bool ?? false
                    let isDeleted = data["isDeleted"] as? Bool ?? false
                    let isFullHeight = data["isFullHeight"] as? Bool ?? false
                    let taskDate = data["taskDate"] as? Date ?? Date.now
                    let taskClock = data["taskClock"] as? String ?? ""
                    let selectedColor = data["selectedColor"] as? String ?? ""
                    let staticValue = data["staticValue"] as? String ?? ""



     
                    return fetchFilterTask(id: id, taskName: taskName, isCompleted: isCompleted, isDeleted: isDeleted, isFullHeight: isFullHeight, taskDate: taskDate, taskClock: taskClock, selectedColor: selectedColor,staticValue: staticValue)
                }
                
            }
//        }
//        else{
//            db.collection("User").document("\(currentUserID)").collection("Task").order(by: "isCompleted",descending: false).addSnapshotListener { (querySnapshot, error) in
//                guard let documents = querySnapshot?.documents else{
//                    print("nooooo")
//                    return
//                }
//
//                self.fetchField = documents.map { ( queryDocumentSnapshot ) -> fetchTask in
//                    let data = queryDocumentSnapshot.data()
//                    let id = data["id"] as? String ?? ""
//                    let taskName = data["taskName"] as? String ?? ""
//                    let isCompleted = data["isCompleted"] as? Bool ?? false
//                    let isDeleted = data["isDeleted"] as? Bool ?? false
//                    let isFullHeight = data["isFullHeight"] as? Bool ?? false
//                    let taskDate = data["taskDate"] as? Date ?? Date.now
//                    let taskClock = data["taskClock"] as? String ?? ""
//                    let selectedColor = data["selectedColor"] as? String ?? ""
//                    let staticValue = data["staticValue"] as? String ?? ""
//
//
//
//                    return fetchTask(id: id, taskName: taskName, isCompleted: isCompleted, isDeleted: isDeleted, isFullHeight: isFullHeight, taskDate: taskDate, taskClock: taskClock, selectedColor: selectedColor, staticValue: staticValue)
//                }
//
//            }
//
//        }
        
        
        
    }
    
    func isUserSignIn()
    {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {  /// Anything over 0.5 seems to work
            if self.userID != "" {
                // Kullanıcı bilgileri alınacak ve ana sayfaya gidilecek
                self.isCurrentUser = true
                
            } else {
                // Login sayfasına gidilecek
                self.isCurrentUser = false
            }

        }
        
            }
    
    func move(from source: IndexSet, to destination: Int) {
        fetchField.move(fromOffsets: source, toOffset: destination)
        }
    

    
}

