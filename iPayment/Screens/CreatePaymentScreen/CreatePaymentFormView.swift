//
//  CreatePaymentFormView.swift
//  iPayment
//
//  Created by Alaa Khoury on 16/10/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI

struct CreatePaymentFormView: BaseView {
    var group: GroupModel
    var expenseType: ExpenseType = .defaultType

    @State private var price = ""
    @State private var liters = ""
    @State private var priceLiter = ""
    @State private var odometer = ""
    @State private var note = ""
    @State private var service = ""
    @State private var expense = ""

    @State private var attachmentsMenuIsPresented: Bool = false
    @State private var showingImagePicker: Bool = false
    @State private var showingCameraPicker: Bool = false
    @State private var inputImage: UIImage?

    @ObservedObject var viewModel = CreatePaymentFormViewModel()

    var body: some View {
        FullScreenFormView(actionButton: actionButton) {
            mainSection(type: expenseType)
            additionlInfoSection(type: expenseType)
            attachmentsSection(type: expenseType)
        }
    }

    private var actionButton: Button<Text> {
        return Button(action: { }, label: { Text("Add") })
    }

    private func mainSection(type: ExpenseType) -> some View {
        return Section(header: Text(type.rawValue)) {
            TextField("Price", text: $price)
                .keyboardType(.decimalPad)

            switch type {
            case ExpenseType.refueling:
                HStack {
                    TextField("Liters", text: $liters)
                        .keyboardType(.decimalPad)

                    Divider()

                    TextField("Price/Liter", text: $priceLiter)
                        .keyboardType(.decimalPad)
                }

                TextField("Odometer", text: $odometer)
                    .keyboardType(.decimalPad)

            case ExpenseType.service:
                TextField("Service", text: $service)
                    .keyboardType(.decimalPad)

                TextField("Odometer", text: $odometer)
                    .keyboardType(.decimalPad)

            case ExpenseType.expense:
                TextField("Expense", text: $expense)
                    .keyboardType(.decimalPad)

                TextField("Odometer", text: $odometer)
                    .keyboardType(.decimalPad)

            default:
                Group {}
            }
        }
    }

    private func additionlInfoSection(type: ExpenseType) -> some View {
        return Section(header: Text("Additional Info")) {
                TextField("Note", text: $note)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)
        }
    }

    private func attachmentsSection(type: ExpenseType) -> some View {
        return Section(content: {
//                ScrollView(.horizontal) {
//                    HStack {
//                        ForEach(self.viewModel.images, id: \.self) { image in
//                            AttachmentView(image: image)
//                        }
//                        .padding(.vertical, 8)
//                    }
//                }

            ScrollView(.horizontal) {
                HStack {
                    ForEach(self.viewModel.imagesInProgress, id:\.self) { image in
                        AttachmentView(image: image)
                    }
                }
            }


            }, header: {
                HStack {
                    Text("Attachments")
                    Spacer()
                    Button(action: {
                        self.attachmentsMenuIsPresented = true
                    }, label: {
                        Image(systemName: "photo.fill.on.rectangle.fill")
                            .foregroundColor(Colors.darkBlue)
                        Text("Add")
                    })
                }
            }, footer: {
                HStack {
                    Text("No attachments")
                }
            })
            .actionSheet(isPresented: $attachmentsMenuIsPresented, content: {
                ActionSheet(
                    title: Text("Attachments"),
                    buttons: getAttachmentsMenuButtons()
                )
            })
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage, sourceType: .photoLibrary)
            }
            .sheet(isPresented: $showingCameraPicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage, sourceType: .camera)
            }
    }

    private func getAttachmentsMenuButtons() -> [ActionSheet.Button] {
        var buttons = Array<ActionSheet.Button>()
        buttons.append(ActionSheet.Button.default(Text("Choose a Photo")) {
            self.showingImagePicker = true
        })
        
        buttons.append(ActionSheet.Button.default(Text("Take a Photo")) {
            self.showingCameraPicker = true
        })

        buttons.append(ActionSheet.Button.cancel())

        return buttons
    }

    private func loadImage() {
        self.attachmentsMenuIsPresented = false

        guard let inputImage = inputImage else { return }
        self.viewModel.onImageAdded(inputImage)
        self.inputImage = nil
    }
}

struct AttachmentView: View {
    var image: NewImageModel

    var body: some View {
        if image.progress == 100 {
            Image(uiImage: image.image)
                .resizable()
                .scaledToFill()
                .overlay(Rectangle().stroke(Color.black, lineWidth: 1))
                .frame(width: 80, height: 80)
                .cornerRadius(8, antialiased: true)
        } else {
            ZStack(alignment: .center) {
                Image(uiImage: image.image)
                    .resizable()
                    .scaledToFill()
                    .overlay(Rectangle().stroke(Color.black, lineWidth: 1))
                    .frame(width: 80, height: 80)
                    .cornerRadius(8, antialiased: true)
                    .blur(radius: 3)

                Text(String(image.progress))
            }
        }

    }
}

struct AttachmentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            let imageModel1 = NewImageModel(UIImage(systemName: "pencil.and.outline")!, 88)
            AttachmentView(image: imageModel1)

            let imageModel2 = NewImageModel(UIImage(systemName: "pencil.and.outline")!, 100)
            AttachmentView(image: imageModel2)
        }
        .previewLayout(.sizeThatFits)
    }
}

//struct CreatePaymentFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreatePaymentFormView(group: GroupModel.create(name: "Test", isFavorite: false))
//    }
//}
