//
//  GroupView.swift
//  iPayment
//
//  Created by Alaa Khoury on 28/09/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI

struct GroupView: BaseView {
    var group: GroupModel

    var viewModel = GroupViewModel()

    @State var usersIsPresented: Bool = false
    @State var infoIsPresented: Bool = false

    var body: some View {
        FullScreenView {
            VStack {
                GroupIconView(name: group.name)
                Text(group.name)

                HStack {
                    if group.usersId?.count ?? 0 > 1 {
                        Spacer()
                        ItemView(text: "Users", imageSystemName: "person.3.sequence.fill") {
                            self.usersIsPresented = true
                        }
                    }

                    Spacer()
                    ItemView(text: "Info", imageSystemName: "chart.bar.fill") {
                        self.infoIsPresented = true
                    }
                    Spacer()
                }
                .padding(.top)

                Divider()
                    .padding()
                Spacer()

            }
        }
        .sheet(isPresented: self.$usersIsPresented, onDismiss: { self.usersIsPresented = false }) {
            GroupUsersView(group: self.group)
        }
        .sheet(isPresented: self.$infoIsPresented, onDismiss: { self.infoIsPresented = false }) {
            GroupInfoView(group: self.group)
        }
    }
}

struct GroupIconView: View {
    let name: String

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Colors.darkBlue)
                .frame(width: 70, height: 70, alignment: .center)

            Circle()
                .foregroundColor(Colors.white)
                .frame(width: 64, height: 64, alignment: .center)

            Text(getInitial())
                .foregroundColor(Colors.darkBlue)
                .font(.title)
                .fontWeight(.bold)
        }
    }

    private func getInitial() -> String {
        let firstLetter = self.name.first?.uppercased() ?? ""

        return "\(firstLetter)"
    }
}

struct ItemView: View {
    let text: String
    let imageSystemName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: imageSystemName)
                Text(text)
                    .padding(.top, 2)
            }
        }
        .foregroundColor(Colors.black)
    }
}
