//
//  ContentView.swift
//  MyToDoList
//
//  Created by Kodgem Technology on 2.02.2022.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    
    @StateObject var taskManager = TaskManager()
    @StateObject var authManager = AuthManager()

    @State var isLooked:Bool = false
    
    
    var body: some View {
        NavigationView {
            ZStack{
                
                    if authManager.isUserSignIn().0 == true{
                    ZStack{
                        MainTaskView(userName: "Fatih", currentUserID: authManager.isUserSignIn().1, pageName: "todo")
                            .environmentObject(taskManager)
                            .environmentObject(authManager)
                            .offset(x: 0, y: taskManager.isMainPage ? 0 : 1000)
                            .animation(.easeInOut)
                            .opacity(taskManager.isMainPage ? 1 : 0)
                            .onAppear {
                                taskManager.fetchColorFB(currentUserID: authManager.isUserSignIn().1)
                                taskManager.fetchUserFB(userID: authManager.isUserSignIn().1)

                            }
                            .preferredColorScheme(.light)
                        
    //                    CustomTabView()
    //                        .environmentObject(taskManager)
    //                        .environmentObject(authManager)
    //                        .offset(x: 0, y: taskManager.isMainPage ? 0 : 1000)
    //                        .animation(.easeInOut)
    //                        .opacity(taskManager.isMainPage ? 1 : 0)
    //                        .onAppear {
    //                            taskManager.fetchTaskFB(currentUserID: authManager.isUserSignIn().1)
    //
    //                        }
    //                        .preferredColorScheme(.light)
                        
                        
                        AddTaskView(viewState: $taskManager.viewState, currentUserID: authManager.isUserSignIn().1)
                            .environmentObject(taskManager)
                            .offset(x: 0, y: taskManager.isMainPage ? -1000 : 0)
                            .opacity(taskManager.isMainPage ? 0 : 1)
                            .animation(.easeInOut)
                        
                        
                        
                        
                        
                    }
                    .opacity(isLooked ? 1 : 0)
                    .animation(.easeInOut)

                } else {
                    LogInView()
                        .environmentObject(taskManager)
                        .opacity(isLooked ? 1 : 0)
                        .animation(.easeInOut)


                }
                

                VStack{

                    Text("To-Do App")
                        .font(.title2)
                    
                    Image("appIcon")
                        .resizable()
                        .frame(width: 100, height: 100)
                        
                    
                }
                .opacity(isLooked ? 0 : 1)
                .animation(.easeInOut)


                
                
              
            
            
            }
            .background(Color(red: 0.976, green: 0.981, blue: 1.002))
            .preferredColorScheme(.light)
                .onAppear {
                    UIApplication.shared.applicationIconBadgeNumber = 0

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {  /// Anything over 0.5 seems to work
                        isLooked = true
                    }
                    
                    
                }
                .navigationBarBackButtonHidden(true)
            .onAppear {
                print((authManager.isUserSignIn().0))
                       
                    

        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
