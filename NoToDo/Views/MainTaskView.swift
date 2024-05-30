//
//  MainTaskView.swift
//  MyToDoList
//
//  Created by Kodgem Technology on 2.02.2022.
//

import SwiftUI
import Firebase
import FirebaseAuth
import AudioToolbox
import CoreHaptics



struct MainTaskView: View {
    var userName:String
    
    @EnvironmentObject var taskManager: TaskManager
    @EnvironmentObject var authManager : AuthManager
    
    var currentUserID:String
    @State var lastDragPosition: DragGesture.Value?
    @Environment(\.dismiss) var dismiss
    @State var isLoggedOut = false
    let generator = UINotificationFeedbackGenerator()
    
    var pageName :String
    
    @State var isHiddenScroll = false
    @State var isFilterTask = false
    @State var isMenuPage = false
    @State var isFullHeightRow = false
    @State var isFullHeightRow2 = false
    @State var isUndo = false
    @GestureState var ispressLong = false
    @State var isshowLongText = false
    @State var isclickAll = false
    @State var isLabelTaskView = true
    
    
    @State var longPressText = ""
    @State var selectedColor = ""
    @State var toplamKisi = 0
    @State var oylananKisi = 0
    
    
    
    
    
    
    
    
    
    
    
    
    
    var body: some View {
        
        if taskManager.isMainPage{
            
            ZStack {
                
                
                
                VStack(alignment: .leading, spacing: 30){
                    
                    HStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .center)
                            .padding()
                        
                        VStack {
                            Image(systemName: "circle")
                                .resizable()
                                .frame(width: 56, height: 56, alignment: .center)
                                .foregroundColor(Color(red: 0.233, green: 0.304, blue: 0.517))
                                .font(Font.system(size: 60, weight: .thin))
                                .overlay(
                                    Image("arrowBack").resizable()
                                        .frame(width: 25, height: 25, alignment: .center)
                                    
                                )
                                .onTapGesture {
                                    isMenuPage = false
                                }
                            
                            Spacer()
                        }
                        
                    }
                    .frame(maxWidth: 250, maxHeight: 150)
                    
                    Text(StaticClass.userName)
                        .frame(maxWidth: 150)
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .semibold))
                        .padding(.leading)
                        .contextMenu {
                            Button {
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    
                    
                    
                    
                    
                    
                }.frame(maxWidth : .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .background(isMenuPage ? Color(red: 0.03, green: 0.124, blue: 0.347) : Color(red: 0.976, green: 0.981, blue: 1.002))
                    .gesture(
                        DragGesture().onChanged{ value in
                            self.taskManager.viewState = value.translation
                            
                            self.lastDragPosition = value
                            
                            
                        }
                            .onEnded{ value in
                                
                                if taskManager.viewState.width < -100 {
                                    isMenuPage = false
                                    self.taskManager.viewState = .zero
                                    
                                }
                                
                                
                                self.taskManager.viewState = .zero
                            }
                    )
                    .blur(radius: isshowLongText ? 20 : 0 )
                
                
                
                
                
                ZStack {
                    
                    
                    
                    ZStack {
                        
                        
                        
                        
                        VStack(spacing: 0){
                            
                            
                            
                            
                            ZStack{
                                
                                
                                
                                HStack(spacing: 0){
                                    Image("menuIcon")
                                        .resizable()
                                        .frame(width: 27, height: 9, alignment: .center)
                                        .padding(.leading, 30)
                                        .onTapGesture {
                                            isMenuPage = true
                                        }
                                    
                                    Spacer()
                                    
                                    
                                    
                                    Text("Çıkış Yap!")
                                        .font(.system(size:12))
                                        .foregroundColor(.red)
                                        .padding(.trailing)
                                        .onTapGesture {
                                            authManager.logoutFB()
                                            exit(0);
                                        }
                                    
                                    //                        VStack{
                                    //                            Text("Sign Out")
                                    //                                .foregroundColor(.red)
                                    //                                .font(.system(size: 10))
                                    //
                                    //                        }.frame(width: 60, height: 40, alignment: .center)
                                    //                            .cornerRadius(15)
                                    //
                                    //                            .shadow(color: .red, radius: 5, x: 0.5, y: 0.5)
                                    //
                                    //                            .padding()
                                    //                            .overlay(
                                    //                                Capsule(style: .continuous)
                                    //                                    .stroke(.red, style: StrokeStyle(lineWidth: 0.5))
                                    //                                    .padding()
                                    //
                                    //                            )
                                    //                            .onTapGesture {
                                    //                                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(1011)) {   }
                                    //
                                    //                                authManager.logoutFB()
                                    //
                                    //                                taskManager.fetchTaskFB(currentUserID: currentUserID)
                                    //
                                    //                            }
                                    //                            .animation(.default)
                                    
                                }
                                
                                
                                
                                if taskManager.isAddedTask{
                                    Rectangle()
                                        .frame(width: 130, height: 50)
                                        .foregroundColor(Color(red: 0.968, green: 0.973, blue: 0.986))
                                        .cornerRadius(20)
                                        .shadow(color: .black.opacity(0.2), radius: 20, x: 2, y: 2)
                                        .overlay{
                                            
                                            HStack{
                                                Text("Succes")
                                                    .font(.title3)
                                                    .foregroundColor(.green)
                                                
                                                Image(systemName: "checkmark")
                                                    .font(.title3)
                                                
                                                
                                            }
                                            
                                            .onAppear {
                                                //                                    AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(4095)) {   }
                                                
                                                generator.notificationOccurred(.success) //I want vibration, not haptic feedback
                                                //                                    taskManager.simpleSuccess()
                                            }
                                            
                                        }
                                        .opacity(taskManager.isAddedTask ? 1 : 0)
                                        .animation(.easeInOut)
                                }
                                
                                if taskManager.isDeletedTask {
                                    Rectangle()
                                        .frame(width: 130, height: 50)
                                        .foregroundColor(Color(red: 0.968, green: 0.973, blue: 0.986))
                                        .cornerRadius(20)
                                        .shadow(color: .black.opacity(0.2), radius: 20, x: 2, y: 2)
                                        .overlay{
                                            
                                            HStack{
                                                Text("Deleted")
                                                    .font(.title3)
                                                    .foregroundColor(.red)
                                                
                                                Image(systemName: "xmark")
                                                    .font(.title3)
                                                
                                            }
                                            .onAppear {
                                                //                                    AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(4095)) {   }
                                                
                                                //                                    generator.notificationOccurred(.success) //I want vibration, not haptic feedback
                                                //                                    taskManager.simpleSuccess()
                                                //                                    taskManager.playSound()
                                                
                                                
                                            }
                                            
                                        }
                                        .opacity(taskManager.isDeletedTask ? 1 : 0)
                                        .animation(.easeInOut)
                                }
                                
                                
                            }.frame(maxWidth: .infinity, maxHeight: 50,alignment: .center)
                                .background(Color(red: 0.976, green: 0.981, blue: 1.002))
                                .gesture(
                                    DragGesture().onChanged{ value in
                                        self.taskManager.viewState = value.translation
                                        
                                        self.lastDragPosition = value
                                        
                                        
                                    }
                                        .onEnded{ value in
                                            
                                            //                                let timeDiff = value.time.timeIntervalSince(self.lastDragPosition!.time)
                                            //                                let speed:CGFloat = CGFloat(value.translation.height - self.lastDragPosition!.translation.height) / CGFloat(timeDiff)
                                            //                                if speed > 500 {}
                                            if taskManager.viewState.height < -100 {
                                                isHiddenScroll = true
                                                self.taskManager.viewState = .zero
                                                
                                            }
                                            if taskManager.viewState.height > 100 && taskManager.viewState.height < 200 {
                                                isHiddenScroll = false
                                                self.taskManager.viewState = .zero
                                                
                                            }
                                            
                                            if taskManager.viewState.height > 200 {
                                                taskManager.isMainPage = false
                                                self.taskManager.viewState = .zero
                                                
                                            }
                                            if taskManager.viewState.width > 100 {
                                                isMenuPage = true
                                                self.taskManager.viewState = .zero
                                                
                                            }
                                            if taskManager.viewState.width < -100 {
                                                isMenuPage = false
                                                self.taskManager.viewState = .zero
                                                
                                            }
                                            
                                            self.taskManager.viewState = .zero
                                        }
                                )
                            
                            
                            
                            HStack {
                                Text("What’s up, \(StaticClass.userName)!")
                                    .font(.system(size: 30, weight: .semibold))
                                    .padding(.leading, 30)
                                
                                
                                
                                Spacer()
                            }.gesture(
                                DragGesture().onChanged{ value in
                                    self.taskManager.viewState = value.translation
                                    
                                    self.lastDragPosition = value
                                    
                                    
                                }
                                    .onEnded{ value in
                                        
                                        if taskManager.viewState.height < -100 {
                                            isHiddenScroll = true
                                            self.taskManager.viewState = .zero
                                            
                                        }
                                        if taskManager.viewState.height > 100 && taskManager.viewState.height < 200 {
                                            isHiddenScroll = false
                                            self.taskManager.viewState = .zero
                                            
                                        }
                                        if taskManager.viewState.height > 200 {
                                            taskManager.isMainPage = false
                                            self.taskManager.viewState = .zero
                                            
                                        }
                                        if taskManager.viewState.width > 100 {
                                            isMenuPage = true
                                            self.taskManager.viewState = .zero
                                            
                                        }
                                        if taskManager.viewState.width < -100 {
                                            isMenuPage = false
                                            self.taskManager.viewState = .zero
                                            
                                        }
                                        
                                        self.taskManager.viewState = .zero
                                    }
                            )
                            .padding(.top, 30)
                            
                            
                            VStack(spacing: 0){
                                
                                if pageName == "todo" {
                                    
                                    VStack(spacing: 0){
                                        Spacer()
                                        HStack {
                                            Text("CATEGORIES")
                                                .font(.system(size: 15, weight: .regular))
                                                .foregroundColor(Color(red: 0.562, green: 0.617, blue: 0.791))
                                                .padding(.leading, 30)
                                            
                                            Spacer()
                                        }.gesture(
                                            DragGesture().onChanged{ value in
                                                self.taskManager.viewState = value.translation
                                                
                                                self.lastDragPosition = value
                                                
                                                
                                            }
                                                .onEnded{ value in
                                                    
                                                    if taskManager.viewState.height < -100 {
                                                        isHiddenScroll = true
                                                        self.taskManager.viewState = .zero
                                                        
                                                    }
                                                    if taskManager.viewState.height > 100 && taskManager.viewState.height < 200 {
                                                        isHiddenScroll = false
                                                        self.taskManager.viewState = .zero
                                                        
                                                    }
                                                    if taskManager.viewState.width > 100 {
                                                        isMenuPage = true
                                                        self.taskManager.viewState = .zero
                                                        
                                                    }
                                                    if taskManager.viewState.width < -100 {
                                                        isMenuPage = false
                                                        self.taskManager.viewState = .zero
                                                        
                                                    }
                                                    if taskManager.viewState.height > 200 {
                                                        taskManager.isMainPage = false
                                                        self.taskManager.viewState = .zero
                                                        
                                                    }
                                                    
                                                    self.taskManager.viewState = .zero
                                                }
                                        )
                                        
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(spacing: 12){
                                                
                                                Text("All")
                                                    .font(.title2)
                                                    .onTapGesture {
                                                        taskManager.fetchField.removeAll()
                                                        isclickAll = true
                                                        taskManager.fetchLabelAllFB(currentUserID: currentUserID, selectedColor: selectedColor, isFilterTask: false, isComplated: false)
                                                        selectedColor = ""
                                                        
                                                    }
                                                
                                                
                                                
                                                ForEach(taskManager.fetchFieldColor, id: \.id){ color in
                                                    ZStack{
                                                        if taskManager.isMainPage{
                                                            
                                                            LabelTaskView(isHiddenScroll: isHiddenScroll , colorLabel: color.colorLabel, colorName: color.colorName, currentUserID: currentUserID, isLabelTaskView: $isLabelTaskView, isAll: $isclickAll)
                                                                .onTapGesture {
                                                                    taskManager.fetchField.removeAll()
                                                                    isclickAll = false
                                                                    taskManager.fetchLabelFB(currentUserID: currentUserID, selectedColor: color.colorName, isFilterTask: true, isComplated: false)
                                                                    
                                                                    selectedColor = color.colorName
                                                                    
                                                                    
                                                                }
                                                        }
                                                    }
                                                    .frame(width: 190, height: isHiddenScroll ? 10 : 100, alignment: .topLeading)
                                                    .background(.white)
                                                    .cornerRadius(15)
                                                    .shadow(color: .black.opacity(0.3), radius: 3, x: 1, y: 1)
                                                }
                                                
                                                
                                                
                                                
                                                
                                            }
                                            .frame(height: isHiddenScroll ? 20 : .infinity)
                                            .padding()
                                            .padding(.leading,18)
                                            
                                        }.gesture(
                                            DragGesture().onChanged{ value in
                                                self.taskManager.viewState = value.translation
                                                
                                                self.lastDragPosition = value
                                                
                                                
                                            }
                                                .onEnded{ value in
                                                    
                                                    if taskManager.viewState.height < -100 {
                                                        isHiddenScroll = true
                                                        self.taskManager.viewState = .zero
                                                        
                                                    }
                                                    if taskManager.viewState.height > 100 && taskManager.viewState.height < 200 {
                                                        isHiddenScroll = false
                                                        self.taskManager.viewState = .zero
                                                        
                                                    }
                                                    if taskManager.viewState.height > 200 {
                                                        taskManager.isMainPage = false
                                                        self.taskManager.viewState = .zero
                                                        
                                                    }
                                                    
                                                    self.taskManager.viewState = .zero
                                                }
                                        )
                                        
                                        
                                        ZStack {
                                            VStack{
                                                Image("appIcon")
                                                    .resizable()
                                                    .frame(width: 100, height: 100, alignment: .center)
                                            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                                                .background(Color(red: 0.976, green: 0.981, blue: 1.002))
                                                .gesture(
                                                    DragGesture().onChanged{ value in
                                                        self.taskManager.viewState = value.translation
                                                        
                                                        self.lastDragPosition = value
                                                        
                                                        
                                                    }
                                                        .onEnded{ value in
                                                            
                                                            if taskManager.viewState.height < -100 {
                                                                isHiddenScroll = true
                                                                self.taskManager.viewState = .zero
                                                                
                                                            }
                                                            if taskManager.viewState.height > 100 && taskManager.viewState.height < 200 {
                                                                isHiddenScroll = false
                                                                self.taskManager.viewState = .zero
                                                                
                                                            }
                                                            if taskManager.viewState.width > 100 {
                                                                isMenuPage = true
                                                                self.taskManager.viewState = .zero
                                                                
                                                            }
                                                            if taskManager.viewState.width < -100 {
                                                                isMenuPage = false
                                                                self.taskManager.viewState = .zero
                                                                
                                                            }
                                                            if taskManager.viewState.height > 200 {
                                                                taskManager.isMainPage = false
                                                                self.taskManager.viewState = .zero
                                                                
                                                            }
                                                            
                                                            self.taskManager.viewState = .zero
                                                        }
                                                )
                                            
                                            
                                            
                                            ScrollView(.vertical, showsIndicators: false) {
                                                ForEach(taskManager.fetchField, id: \.id){ task in
                                                    
                                                    HStack(spacing: 0) {
                                                        VStack {
                                                            Image(systemName: "circle")
                                                                .resizable()
                                                                .frame(width: 23, height: 23, alignment: .center)
                                                                .background(task.isCompleted ? Color(task.selectedColor).opacity(0.3) : .clear)
                                                                .cornerRadius(20)
                                                                .foregroundColor(Color(task.selectedColor).opacity(task.isCompleted ? 0 : 1))
                                                                .overlay(
                                                                    Image(systemName: task.isCompleted ? "checkmark" : "")
                                                                        .resizable()
                                                                        .frame(width: 10, height: 10)
                                                                        .foregroundColor(.white)
                                                                        .padding()
                                                                )
                                                                .padding(.leading)
                                                                .onTapGesture {
                                                                    taskManager.fetchField.removeAll()
                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                                        
                                                                        taskManager.updateTaskFB(taskID: task.id, taskName: task.taskName, isCompleted: !task.isCompleted, currentUserID: currentUserID, isDeleted: task.isDeleted, isFullHeight: task.isFullHeight)
                                                                        if isclickAll{
                                                                            
                                                                            taskManager.fetchLabelAllFB(currentUserID: currentUserID, selectedColor: selectedColor, isFilterTask: false, isComplated: false)
                                                                        }
                                                                        else{
                                                                            taskManager.fetchLabelFB(currentUserID: currentUserID, selectedColor: selectedColor, isFilterTask: true, isComplated: false)
                                                                        }
                                                                        
                                                                        //
                                                                        //
                                                                        isLabelTaskView = false
                                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                                            isLabelTaskView = true
                                                                            
                                                                        }
                                                                        
                                                                    }
                                                                    
                                                                    
                                                                }
                                                                .padding(.top,25)
                                                            Spacer()
                                                        }
                                                        
                                                        HStack(spacing: 0){
                                                            
                                                            Text(task.taskName)
                                                                .strikethrough(task.isCompleted ? true : false)
                                                                .foregroundColor(.black)
                                                                .font(.system(size: 18).weight(.regular))
                                                                .frame(width: .infinity , height: .infinity, alignment: .center)
                                                                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0))
                                                                .lineLimit(5)
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
                                                        }.frame(maxWidth:.infinity,alignment: .leading)
                                                            .frame(height: .infinity)
                                                        
                                                            .cornerRadius(20)
                                                        
                                                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0))
                                                            .overlay(
                                                                Capsule(style: .continuous)
                                                                    .stroke(.white, style: StrokeStyle(lineWidth: 0.2))
                                                                    .padding()
                                                                
                                                            )
                                                            .onTapGesture {
                                                                taskManager.fetchField.removeAll()
                                                                
                                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                                    
                                                                    taskManager.updateTaskFB(taskID: task.id, taskName: task.taskName, isCompleted: task.isCompleted, currentUserID: currentUserID, isDeleted: task.isDeleted, isFullHeight: !task.isFullHeight)
                                                                    
                                                                    if isclickAll{
                                                                        
                                                                        taskManager.fetchLabelAllFB(currentUserID: currentUserID, selectedColor: selectedColor, isFilterTask: false, isComplated: false)
                                                                    }
                                                                    else{
                                                                        taskManager.fetchLabelFB(currentUserID: currentUserID, selectedColor: selectedColor, isFilterTask: true, isComplated: false)
                                                                    }
                                                                    
                                                                    
                                                                    
                                                                    isLabelTaskView = false
                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                                        isLabelTaskView = true
                                                                        
                                                                    }
                                                                    
                                                                }
                                                            }
                                                            .onLongPressGesture(minimumDuration: 2){
                                                                isshowLongText = true
                                                                longPressText = task.taskName
                                                                taskManager.simpleSuccess()
                                                            }
                                                            .overlay {
                                                                HStack{
                                                                    Spacer()
                                                                    
                                                                    VStack {
                                                                        Text(task.taskClock)
                                                                            .font(.system(size: 10, weight: .regular))
                                                                            .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 16))
                                                                            .opacity(0.4)
                                                                            .offset(x: 0, y: -7)
                                                                        
                                                                        Spacer()
                                                                    }
                                                                    .background(.clear)
                                                                }
                                                                
                                                            }
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                    }
                                                    .frame(height: task.isFullHeight ? .infinity : 73.8)//73.8
                                                    .frame(maxWidth: .infinity)
                                                    .background(.white)
                                                    .cornerRadius(15)
                                                    .listRowSeparator(.hidden)
                                                    .padding(.horizontal, 16)
                                                    .animation(Animation.spring(response: 0.3))
                                                    .swipeActions(edge: .leading) {
                                                        Button(action: {
                                                            // Sağa kaydırma işlemi için gerçekleştirilecek eylemi burada tanımlayabilirsiniz.
                                                            print("Sağa kaydırıldı: \(task)")
                                                        }) {
                                                            Text("Sağa Kaydır")
                                                                .foregroundColor(.white)
                                                                .padding(.vertical, 10)
                                                                .padding(.horizontal, 20)
                                                                .background(Color.blue)
                                                                .cornerRadius(5)
                                                        }
                                                    }
                                                    
                                                    //                                    Text("furkan")
                                                    //                                        .foregroundColor(.white)
                                                }
                                                
                                                
                                                
                                                
                                            }
                                            .refreshable {
                                                taskManager.isMainPage = false
                                                
                                            }
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                        }
                                        
                                        
                                        
                                        
                                        
                                    }
                                    
                                    .background(Color(red: 0.976, green: 0.981, blue: 1.002))
                                    
                                    
                                    
                                    
                                    
                                    
                                }
                                else if pageName == "anımsatıcı"{
                                    Text("anımsatıcı screen")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                            }
                            .background(Color(red: 0.976, green: 0.981, blue: 1.002))
                            
                            //                CustomTabView()
                            
                            
                        }
                        
                        VStack{}
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(.white.opacity(0.1))
                            .onTapGesture {
                                isMenuPage = false
                            }
                            .opacity(isMenuPage ? 1 : 0)
                            .gesture(
                                DragGesture().onChanged{ value in
                                    self.taskManager.viewState = value.translation
                                    
                                    self.lastDragPosition = value
                                    
                                    
                                }
                                    .onEnded{ value in
                                        
                                        if taskManager.viewState.height < -100 {
                                            isHiddenScroll = true
                                            self.taskManager.viewState = .zero
                                            
                                        }
                                        if taskManager.viewState.height > 100 && taskManager.viewState.height < 200 {
                                            isHiddenScroll = false
                                            self.taskManager.viewState = .zero
                                            
                                        }
                                        if taskManager.viewState.width > 100 {
                                            isMenuPage = true
                                            self.taskManager.viewState = .zero
                                            
                                        }
                                        if taskManager.viewState.width < -100 {
                                            isMenuPage = false
                                            self.taskManager.viewState = .zero
                                            
                                        }
                                        if taskManager.viewState.height > 200 {
                                            taskManager.isMainPage = false
                                            self.taskManager.viewState = .zero
                                            
                                        }
                                        
                                        self.taskManager.viewState = .zero
                                    }
                            )
                        
                        
                        
                        
                        
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
                        .background(Color(red: 0.976, green: 0.981, blue: 1.002))
                        .cornerRadius(isMenuPage ? 45 : 0)
                        .offset(x: isMenuPage ? 250 : 0, y: 0)
                        .scaleEffect(isMenuPage ? 0.8 : 1)
                        .blur(radius: isshowLongText ? 20 : 0 )
                    
                    
                    Text(longPressText)
                        .font(.title3)
                        .frame(width: .infinity, height: .infinity)
                        .padding(80)
                        .opacity(isshowLongText ? 1 : 0)
                        .onTapGesture {
                            isshowLongText = false
                        }
                        .animation(Animation.spring())
                    
                    
                    
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                
                
                
                
                
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        
                        Circle()
                            .foregroundColor(Color(red: -0.169, green: 0.392, blue: 0.931))
                            .frame(width: 55, height: 55, alignment: .center)
                            .overlay(
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .frame(width: 20, height: 20, alignment: .center)
                            )
                            .onTapGesture {
                                taskManager.isMainPage = false
                            }
                    }
                    .padding()
                    
                }
                .offset(x: isMenuPage ? 200 : 0, y: 0)
                .blur(radius: isshowLongText ? 20 : 0 )
                
                
                
            }
            .onTapGesture {
                isshowLongText = false
            }
            .onAppear {
                
                taskManager.addColorFB(isSelectedColor: true, colorLabel: "General", currentUserID: currentUserID, colorName: "Blue", id: "Blue")
                
            }
            
            
            
        }
    }
}

struct MainTaskView_Previews: PreviewProvider {
    static var previews: some View {
        MainTaskView(userName: "Furkan Durmaz", currentUserID: "", pageName: "todo")
        //        CustomTabView()
    }
}

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
                                                amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
                                              y: 0))
    }
}

var tabs = ["todo","anımsatıcı"]

struct CustomTabView: View{
    
    @EnvironmentObject var taskManager: TaskManager
    @EnvironmentObject var authManager : AuthManager
    
    @State var selectedTab = "todo"
    
    var body: some View{
        
        VStack{
            
            MainTaskView(userName: "Hello!", currentUserID: authManager.isUserSignIn().1, pageName: selectedTab)
            
            
            HStack(spacing: 0){
                ForEach(tabs, id:\.self){image in
                    
                    TabView(image: image, selectedTab: $selectedTab)
                    
                    if image != tabs.last{
                        Spacer(minLength: 0)
                        
                    }
                    
                }
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 5)
            .background(.black)
            .clipShape(Capsule())
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color(red: 0.976, green: 0.981, blue: 1.002))
    }
}

struct TabView: View{
    var image: String
    @Binding var selectedTab: String
    
    var body: some View{
        HStack{
            Spacer()
            Button {
                selectedTab = image
            } label: {
                
                HStack{
                    Image(image)
                        .resizable()
                        .frame(width: 18, height: 18, alignment: .center)
                        .padding(8)
                }
                .frame(maxWidth: .infinity - 20)
                .background(selectedTab == image ? Color.blue : Color.black.opacity(1))
                .clipShape(Capsule())
                .padding(.horizontal)
                
                
                
                
                
                
            }
            Spacer()
            
        }
        
        
        
        
        
        
    }
}

struct RedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.foregroundColor(Color.red)
    }
}

struct LabelTaskView: View {
    
    @StateObject var taskManager = TaskManager()
    
    var isHiddenScroll:Bool
    var colorLabel:String
    var colorName:String
    @State var oylananKisi: Int = 2
    @State var toplamKisi: Int = 0
    var currentUserID: String
    @Binding var isLabelTaskView:Bool
    @Binding var isAll:Bool
    
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6){
            if isHiddenScroll{
                
                ZStack {
                    
                    HStack(spacing: 0){
                        Color(red: 0.901, green: 0.926, blue: 1.007, opacity: 1)//red: 0.901, green: 0.926, blue: 1.007
                            .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .frame(maxWidth: 168 , maxHeight: 5)
                    }
                    .frame(maxWidth: 168 , maxHeight: 5)
                    
                    
                    
                    HStack(spacing: 0) {
                        
                        Color(colorName)
                            .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .frame(maxWidth:  (168 - ((168 * CGFloat(toplamKisi - oylananKisi )) / CGFloat(toplamKisi) )) , maxHeight: 5, alignment: .leading)
                        
                        Spacer(minLength: 0)
                        
                    }
                    .frame(maxWidth: 168 , maxHeight: 5)
                    
                    
                    
                }
                .offset(x: 10, y: 2)
                
                
            } else {
                Text("\(toplamKisi) tasks")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color(red: 0.562, green: 0.617, blue: 0.791))
                    .padding(.leading,10)
                    .padding(.top,10)
                
                
                Text(colorLabel)
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.black)
                    .padding(.leading,10)
                
                
                ZStack {
                    
                    HStack(spacing: 0){
                        Color(red: 0.901, green: 0.926, blue: 1.007, opacity: 1)//red: 0.901, green: 0.926, blue: 1.007
                            .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .frame(maxWidth: 168 , maxHeight: 5)
                    }
                    .frame(maxWidth: 168 , maxHeight: 5)
                    
                    if oylananKisi != 0{
                        
                        HStack(spacing: 0) {
                            
                            Color(colorName)
                                .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                .frame(maxWidth: (168 - ((168 * CGFloat(toplamKisi - oylananKisi )) / CGFloat(toplamKisi) )) , maxHeight: 5, alignment: .leading)
                            
                            Spacer(minLength: 0)
                            
                        }
                        .frame(maxWidth: 168 , maxHeight: 5)
                        
                    }
                    
                }
                .offset(x: 10, y: 0)
                
                
                //                Image("taskBar")
                //                    .resizable()
                //                    .scaledToFit()
                //                    .frame(width: .infinity)
                //                    .padding(.horizontal,10)
            }
            
        }
        .frame(width: 190, height: isHiddenScroll ? 10 : 100, alignment: .topLeading)
        .background(.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.3), radius: 3, x: 1, y: 1)
        .onChange(of: isLabelTaskView, perform: { V in
            taskManager.fetchLabelFB2(currentUserID: currentUserID, selectedColor: colorName, isFilterTask: true, isComplated: false)
            taskManager.fetchLabelFBComplated(currentUserID: currentUserID, selectedColor: colorName)
            
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {  /// Anything over 0.5 seems to work
                ///
                print(taskManager.fetchFieldFilter)
                
                for (index, element) in taskManager.fetchField2.enumerated() {
                    
                    if index == taskManager.fetchField2.endIndex-1 {
                        
                        print("Item \(index): \(element)")
                        toplamKisi = Int(index + 1)
                        
                    }
                    
                }
                
                if taskManager.fetchFieldFilter.isEmpty {
                    oylananKisi = 0
                }
                else{
                    for (index, element) in taskManager.fetchFieldFilter.enumerated() {
                        
                        if index == taskManager.fetchFieldFilter.endIndex-1 {
                            
                            print("Item2 \(index): \(element)")
                            
                            oylananKisi = Int(index + 1)
                            
                            
                            
                        }
                        
                    }
                }
                
                
                
                
            }
            
        })
        .onAppear {
            
            taskManager.fetchLabelFB2(currentUserID: currentUserID, selectedColor: colorName, isFilterTask: true, isComplated: false)
            taskManager.fetchLabelFBComplated(currentUserID: currentUserID, selectedColor: colorName)
            
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {  /// Anything over 0.5 seems to work
                ///
                print(taskManager.fetchFieldFilter)
                
                for (index, element) in taskManager.fetchField2.enumerated() {
                    
                    if index == taskManager.fetchField2.endIndex-1 {
                        
                        print("Item \(index): \(element)")
                        toplamKisi = Int(index + 1)
                        
                    }
                    
                }
                
                if taskManager.fetchFieldFilter.isEmpty {
                    oylananKisi = 0
                }
                else{
                    for (index, element) in taskManager.fetchFieldFilter.enumerated() {
                        
                        if index == taskManager.fetchFieldFilter.endIndex-1 {
                            
                            print("Item2 \(index): \(element)")
                            
                            oylananKisi = Int(index + 1)
                            
                            
                            
                        }
                        
                    }
                }
                
                
                
                
            }
            
            
            
            
            
            
        }
        
    }
}



