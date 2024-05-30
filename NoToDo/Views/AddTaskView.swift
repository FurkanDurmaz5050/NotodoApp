//
//  AddTaskView.swift
//  MyToDoList
//
//  Created by Kodgem Technology on 3.02.2022.
//
import Introspect
import SwiftUI

struct AddTaskView: View {
    @State var title = ""
    @State var colorLabel = ""
    
    @State var selectedColorName = "Blue"
    
    @State var selectedDate = Date()
    @State var isDatePicker = false
    @State var isSelectedColor = false
    @State var isAddColor = false
    
    @State var colors: [String] = ["Red", "Green", "Blue", "Pink", "Orange"]
    
    @ObservedObject var notificationManager = NotificationManager()
    
    static let locale = Locale(identifier: "en_US_POSIX")
    
    
    
    
    
    
    @Binding var viewState: CGSize
    enum FocusField: Hashable {
        case field
    }
    
    
    
    @FocusState private var focusedField: FocusField?
    @EnvironmentObject var taskManager: TaskManager
    @Environment(\.dismiss) var dismiss
    @State var viewStateCancel = CGSize.zero
    var currentUserID:String
    
    var randomID: String = String.random()
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 0.0){
                HStack{
                    
                    Spacer()
                    
                    VStack{
                        
                        Image(systemName: "circle")
                            .resizable()
                            .frame(width: 56, height: 56, alignment: .center)
                            .foregroundColor(Color(red: 0.865, green: 0.875, blue: 0.965))
                            .font(Font.system(size: 60, weight: .light))
                            .overlay(
                                Image(systemName: "xmark")
                                    .foregroundColor(.black)
                                
                            )
                        
                        
                    }
                    .onTapGesture {
                        
                        if !isSelectedColor{
                            viewState = .zero
                            taskManager.isMainPage = true
                            title = ""
                        }
                        
                    }
                    .padding()
                    .opacity(isSelectedColor ? 0 : 1)
                    
                    
                    
                    
                }
                
                
                
                if taskManager.isMainPage != true {
                    ZStack {
                        
                        TextEditor(text: $title)
                            .frame(width: 250, height: 170)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 35, weight: .regular))
                            .background(.white)
                            .disableAutocorrection(true)
                            .introspectTextField { textfield in
                                textfield.returnKeyType = .done
                            }
                            .onSubmit {
                                if title != "" {
                                    taskManager.addTaskFB(taskID: randomID.self, taskName: title, isCompleted: false, currentUserID: currentUserID, taskDate: selectedDate, selectedColor: selectedColorName, taskClock: selectedDate.formatted(.dateTime.hour().minute()))
                                    notificationManager.sendNotification(
                                        title: "To-Do App",
                                        subtitle: title,
                                        minute: Int(selectedDate.formatted(.dateTime.minute()).description) ?? 0,
                                        hour: Int(selectedDate.formatDate()) ?? 0,
                                        day: Int(selectedDate.formatted(.dateTime.day()).description) ?? 0,
                                        month: Int(selectedDate.formatted(.dateTime.month(.defaultDigits))) ?? 0,
                                        year: Int(selectedDate.formatted(.dateTime.year()).description) ?? 0)
                                    print("notff\(Int(selectedDate.formatted(.dateTime.minute()).description) ?? 0)")
                                    viewState = .zero
                                    taskManager.isMainPage = true
                                    title = ""
                                } else{
                                    print("Boş Bıraktınız")
                                }
                                
                                StaticClass.isMainPage = true
                            }
                            .focused($focusedField, equals: .field)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {  /// Anything over 0.5 seems to work
                                    self.focusedField = .field
                                }
                            }
                            .overlay{if title == "" {
                                Text("Enter new task!")
                                    .font(.system(size: 35, weight: .regular))
                                    .foregroundColor(Color(red: 0.503, green: 0.559, blue: 0.744))
                            }
                                else{
                                    VStack {
                                        Spacer()
                                        HStack{
                                            HStack {
                                                Image("calendarIcon")
                                                    .resizable()
                                                    .frame(width: 30, height: 30, alignment: .center)
                                                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0))
                                                
                                                Text(selectedDate.formatted(.dateTime.day().month(.defaultDigits).year()))
                                                    .font(.system(size: 16, weight: .regular))
                                                    .foregroundColor(Color(red: 0.503, green: 0.559, blue: 0.744))
                                                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 16))
                                                
                                                
                                                
                                            }
                                            .frame(width: 170)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 100)
                                                    .stroke(Color(red: 0.906, green: 0.926, blue: 0.999), lineWidth: 1)
                                            )
                                            .padding()
                                            .onTapGesture {
                                                isDatePicker = true
                                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                            }
                                            
                                            
                                            
                                            ZStack {
                                                ZStack {
                                                    ZStack {
                                                        
                                                    }
                                                    .frame(width: 20, height: 20, alignment: .center)
                                                    .background(Color(selectedColorName))
                                                    .cornerRadius(10)
                                                    
                                                    
                                                }
                                                .frame(width: 30, height: 30, alignment: .center)
                                                .cornerRadius(15)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .stroke(Color(selectedColorName), lineWidth: 1)
                                                )
                                            }
                                            .frame(width: 70, height: 70, alignment: .center)
                                            .cornerRadius(35)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 35)
                                                    .stroke(Color(red: 0.906, green: 0.926, blue: 0.999), lineWidth: 1)
                                            )
                                            .onTapGesture {
                                                self.isSelectedColor = true
                                                focusedField = nil
                                                
                                            }
                                            
                                        }
                                        .frame(maxWidth: .infinity)
                                        .offset(x: -22, y: 75)
                                    }
                                }
                                
                            }
                            .opacity(isDatePicker || isSelectedColor ? 0 : 1)
                        
                        
                        if isDatePicker{
                            
                            VStack {
                                DatePicker("Select a date", selection: $selectedDate)
                                    .datePickerStyle(GraphicalDatePickerStyle())
                                    .background(Color(red: 0.976, green: 0.981, blue: 1.002))
                                    .cornerRadius(15)
                                
                                Text("Done")
                                    .foregroundColor(.blue)
                                    .onTapGesture {
                                        isDatePicker.toggle()
                                    }
                            }
                            
                        }
                        
                        if isSelectedColor{
                            ZStack {
                                VStack{
                                    if isAddColor && !colors.isEmpty{
                                        VStack{
                                            TextField("Lütfen Etiketi Yazın ve Bir Renk Seçin!!", text: $colorLabel)
                                                .font(.system(size: 10, weight: .regular))
                                                .frame(maxWidth: .infinity)
                                                .multilineTextAlignment(.center)
                                                .opacity(isAddColor ? 1 : 0)
                                                .padding()
                                                .focused($focusedField, equals: .field)
                                                .onAppear {
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {  /// Anything over 0.5 seems to work
                                                        self.focusedField = .field
                                                    }
                                                }
                                            
                                            
                                            VStack {
                                                
                                                
                                                
                                                
                                                HStack {
                                                    ForEach(colors, id: \.self){ color in
                                                        
                                                        HStack {
                                                            ColorView(colorName: color.description.capitalized)
                                                                .opacity(isAddColor ? 1 : 0)

                                                        }.onTapGesture {
                                                            
                                                            if colorLabel != "" && ![colors].isEmpty{
                                                                isAddColor.toggle()
                                                                taskManager.addColorFB(isSelectedColor: true, colorLabel: colorLabel, currentUserID: currentUserID, colorName: color.description.capitalized, id: color.description.capitalized)
                                                                
                                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                                    colorLabel = ""
                                                                }
                                                                
                                                            }
                                                            
                                                            
                                                        }
                                                        
                                                    }
                                                }
                                                
                                                
                                            }
                                        }
                                        .padding()
                                        .background(.black.opacity(0.05))
                                        .cornerRadius(15)
                                        .opacity(isAddColor ? 1 : 0)
                                    }
                                    
                                    
                                    
                                    
                                    
                                    
                                    HStack(spacing: 25) {
                                        
                                        
                                        ColorView(colorName: "AddColor")
                                            .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0))
                                            .onTapGesture {
                                                
                                                if !colors.isEmpty{
                                                    isAddColor.toggle()

                                                }
                                                
                                                
                                            }
                                            .blur(radius: !colors.isEmpty ? 0 : 10)
                                            .offset(x: -8, y: -8)
                                        
                                        
                                        
                                        
                                        ForEach(taskManager.fetchFieldColor, id: \.id){ color in
                                            
                                            VStack {
                                                ColorView(colorName: color.id)
                                                    .onTapGesture {
                                                        if !isAddColor{
                                                            
                                                            isSelectedColor.toggle()
                                                            selectedColorName = color.colorName
                                                            
                                                        }
                                                        
                                                    }
                                                    .onAppear(){
                                                        if colors.contains(color.colorName) {
                                                            colors = colors.filter(){$0 != color.colorName}
                                                            print(colors)
                                                            
                                                        } else {
                                                            print("No apples here – sorry!")
                                                        }
                                                    }
                                                
                                                Text(color.colorLabel)
                                                    .font(.system(size: 6, weight: .bold))
                                            }
                                            .padding(4)
                                            .blur(radius: isAddColor ? 10 : 0)
                                            
                                            
                                            
                                            
                                        }
                                        .frame(maxHeight: 30)
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                    }
                                    .cornerRadius(15)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color(selectedColorName), lineWidth: 1)
                                    )
                                    
                                    
                                }.offset(x: 0, y: 70)
                            }
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
                            .background(.white)
                            .onTapGesture {
                                    
                                    
                                    if isSelectedColor && !isAddColor{
                                        isSelectedColor = false
                                    }
                                    if isSelectedColor && isAddColor{
                                        isAddColor = false
                                    }
                                    
                                }
                            
                            
                        }
                    }
                }
                
                Spacer()
                
                HStack{
                    Spacer()
                    
                    Text("Cancel")
                        .font(.title3)
                        .foregroundColor(.blue)
                        .padding()
                        .onTapGesture {
                            
                            if !isSelectedColor{
                                viewState = .zero
                                taskManager.isMainPage = true
                                title = ""
                            }
                            
                            
                        }
                        .opacity(isSelectedColor ? 0 : 1)
                }
                
                
                
            }
            .padding(.horizontal)
            
            
            
        }
        .padding(.top, 40)
        .background(.white)
        .gesture(
            DragGesture().onChanged{ value in
                self.viewStateCancel = value.translation
                
                if !isDatePicker && !isSelectedColor{
                    
                    if viewStateCancel.height < 200 {
                        if title != "" {
                            taskManager.addTaskFB(taskID: randomID.self, taskName: title, isCompleted: false, currentUserID: currentUserID, taskDate: selectedDate, selectedColor: selectedColorName, taskClock: selectedDate.formatted(.dateTime.hour().minute()))
                            //                        notificationManager.sendNotification(title: "To-Do App",
                            //                                                             subtitle: "Notun Süresi Doldu",
                            //                                                             minute: Int(selectedDate.formatted(.dateTime.minute()).description) ?? 0,
                            //                                                             hour: Int(selectedDate.formatted(.dateTime.hour(.defaultDigitsNoAMPM)).description) ?? 0,
                            //                                                             day: Int(selectedDate.formatted(.dateTime.day()).description) ?? 0,
                            //                                                             month: Int(selectedDate.formatted(.dateTime.month()).description) ?? 0,
                            //                                                             year: Int(selectedDate.formatted(.dateTime.year()).description) ?? 0)
                            notificationManager.sendNotification(
                                title: "To-Do App",
                                subtitle: "Notun süresi doldu: \(title)",
                                minute: Int(selectedDate.formatted(.dateTime.minute()).description) ?? 0,
                                hour: Int(selectedDate.formatDate()) ?? 0,
                                day: Int(selectedDate.formatted(.dateTime.day()).description) ?? 0,
                                month: Int(selectedDate.formatted(.dateTime.month(.defaultDigits))) ?? 0,
                                year: Int(selectedDate.formatted(.dateTime.year()).description) ?? 0)
                            
                            print("notff\(Int(selectedDate.formatted(.dateTime.minute()).description) ?? 0)")

                            print("\(Int(selectedDate.formatted(.dateTime.month(.defaultDigits)))) Furkannn16")
                            
                            selectedDate = Date.now
                            isDatePicker = false
                            viewState = .zero
                            taskManager.isMainPage = true
                            title = ""
                            
                        } else {
                            viewState = .zero
                            taskManager.isMainPage = true
                            title = ""
                        }
                    }
                    
                }
                
                
            }
                .onEnded{ value in
                    
                    self.viewStateCancel = .zero
                    
                }
            
        )
        
        
    }
}



struct ColorView: View {
    
    var colorName: String
    
    var body: some View {
        ZStack {
            ZStack {
                
                if colorName == "AddColor"{
                    Image(systemName: "plus")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 10, height: 10, alignment: .center)
                }
                
            }
            .frame(width: 20, height: 20, alignment: .center)
            .background(Color(colorName))
            .cornerRadius(10)
            
            
        }
        .frame(width: 30, height: 30, alignment: .center)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(colorName), lineWidth: 1)
        )
    }
}
