//
//  TaskRow.swift
//  MyToDoList
//
//  Created by Kodgem Technology on 2.02.2022.
//

import SwiftUI

struct TaskRow: View {
    var taskName:String
    var isComleted:Bool
    var body: some View {
                    
            Image(systemName: "circle")
                .resizable()
                .frame(width: 23, height: 23, alignment: .center)
                .background(isComleted ? Color(red: 0.982, green: -0.19, blue: 1.011).opacity(0.3) : .clear)
                .cornerRadius(20)
                .foregroundColor(Color(red: 0.982, green: -0.19, blue: 1.011).opacity(isComleted ? 0 : 1))
                .overlay(
                    Image(systemName: isComleted ? "checkmark" : "")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.white)
                        .padding()
                )
                .padding(.leading)
                
            
//            HStack{
//
//                Text(taskName)
//                    .strikethrough(isComleted ? true : false)
//                    .foregroundColor(.black)
//                    .font(.system(size: 18).weight(.regular))
//                    .frame(width: .infinity, height: .infinity, alignment: .center)
//                    .padding()
//                    .lineLimit(5)
//
//
//
//
//
//
//
//            }.frame(maxWidth:.infinity,alignment: .leading)
//                .frame(height: .infinity)
//
//                .animation(.default)
//                .cornerRadius(20)
//
//                .padding(10)
//                .overlay(
//                    Capsule(style: .continuous)
//                        .stroke(.white, style: StrokeStyle(lineWidth: 0.2))
//                        .padding()
//
//                )
            
            
        
        
        //            .background(.blue)
        //            .background(Color(hue: 0.469, saturation: 0.842, brightness: 0.459))
        
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(taskName: "Alışverişsfcvfsffffcfsvsvfavgwffdffd",isComleted: true)
    }
}
