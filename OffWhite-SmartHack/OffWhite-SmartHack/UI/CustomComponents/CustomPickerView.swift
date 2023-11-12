//
//  CustomPickerView.swift
//  OffWhite-SmartHack
//
//  Created by Mihai Ocnaru on 12.11.2023.
//

import SwiftUI

struct CustomPickerView<ItemType: StringProtocol>: View {
    
    let image: String
    let itemsList:[ItemType]
    let width: CGFloat
    private let height: CGFloat = 250
    @Binding var selection: ItemType
    
    
    @State private var isShown = false
    
    var body: some View {
        VStack {
            
            Button {
                withAnimation(.default){
                    isShown.toggle()
                }
            } label: {
                HStack {
                    
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 24)
                        .foregroundColor(.black)
                        .padding(.trailing, 6)
                    
                    Text(selection)
                        .font(Poppins.Bold(size: 16))
                        .foregroundColor(CustomColors.myGray)
                        .padding(.bottom, 8)
                    
                    Spacer()
                    
                    Image("arrow_down")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 24)
                        .foregroundColor(.black)
                        .padding(.trailing, 6)
                        .rotationEffect(.degrees((isShown ? 0 : -1) * 180))
                }
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white)
                        .padding(-15)
                })
               .padding(16)
            }
            
            if isShown {
                ScrollView {
                    ForEach(itemsList, id: \.self) { item in
                        Text(item)
                            .font(Poppins.Regular(size: 16))
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .frame(width: width)
                            .onTapGesture {
                                withAnimation(.default) {
                                    selection = item
                                    isShown = false
                                }
                            }
                        if let last = itemsList.last, item != last {
                            Rectangle()
                                .fill(.white)
                                .frame(height: 1)
                                .padding(.horizontal, 32)
                        }
                    }
                    .transition(.identity)
                }
                
            }
            Spacer()
        }
        .frame(width: width)
        .background(isShown ? CustomColors.myBlack : .clear)
        .cornerRadius(8)
        .frame(height: height)
    }
}

struct CustomPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomPickerView<String>(
            image: "location",
            itemsList: ["§", "2", "432"],
            width: UIScreen.main.bounds.width - 40,
            selection: .constant("")
        )
    }
}
