//
//  SideMenuView.swift
//  ReptileDiary
//
//  Created by 변예린 on 11/15/25.
//
import SwiftUI

// 사이드 메뉴 전체 화면(회색 부분 포함)
struct SideMenuView: View {
    @Binding var isShowing: Bool

    var content: AnyView
    var edgeTransition: AnyTransition = .move(edge: .trailing)
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                Color.black
                    .opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture { isShowing.toggle() }
                content
                    .transition(edgeTransition)
                    .background(Color.clear)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
    
}

// 사이드 메뉴 부분 화면(흰색 부분)
struct SideMenu: View {
    var body: some View {
        HStack {
            Spacer()
            ZStack {
                VStack(alignment: .trailing, spacing: 0) {
                    ForEach(SideMenuRowType.allCases, id: \.self) { row in
                        rowView(isSelected: true, imageName: row.iconName, title: row.title) {
                            print(row.title)
                        }
                    }
                    Spacer()
                }
                .padding(.top, 100)
                .frame(width: 270)
                .background(Color.white)
            }
        }
        .background(.clear)
    }
    
    func rowView(isSelected: Bool, imageName: String, title: String, hideDivider: Bool = false, action: @escaping (() -> ())) -> some View {
        Button {
            action()
        } label: {
            VStack(alignment: .trailing) {
                HStack(spacing: 20) {
                    Rectangle()
                        .fill(isSelected ? .purple : .white)
                        .frame(width: 5)
                    
                    ZStack {
                        Image(systemName: imageName)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundStyle(isSelected ? .black : .gray)
                            .frame(width: 26, height: 26)
                    }
                    .frame(width: 30, height: 30)
                    Text(title)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(isSelected ? .black : .gray)
                    Spacer()
                }
            }
        }
        .frame(height: 50)
        .background(LinearGradient(colors: [isSelected ? .purple.opacity(0.5) : .white, .white], startPoint: .leading, endPoint: .trailing))

    }
}
