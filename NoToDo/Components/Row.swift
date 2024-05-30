//
//  TaskRow.swift
//  MyToDoList
//
//  Created by Kodgem Technology on 2.02.2022.
//

import SwiftUI

struct Row: View {
    var taskName:String
    var isComleted:Bool
    var body: some View {
        HStack(spacing: 0) {
            Text("Furkan")
        }
        .background(Color(red: 0.129, green: 0.129, blue: 0.151))
    .animation(.default)

    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        Row(taskName: "Alışverişsfcvfsffffcfsvsvfavgwffdffd",isComleted: true)
    }
}
