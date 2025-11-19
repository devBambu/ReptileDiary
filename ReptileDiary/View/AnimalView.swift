//
//  AnimalView.swift
//  ReptileDiary
//
//  Created by 변예린 on 11/18/25.
//

import SwiftUI

struct AnimalView: View {
    @State var isShowing: Bool = false
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    HStack{
                        Image(systemName: "lizard.fill")
                        Text("이름")
                    }
                }
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("Hi")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            NavigationLink(destination: AddView()) {
                                Image(systemName: "plus")
                            }
                        }
                        
                    }
            }
            
            
        }
    }
}

#Preview {
    AnimalView()
}

struct AddView: View {
   
    @State private var name = ""
    @State private var sex = ""
    
    var body: some View {
        Form {
            Section("기본 정보") {
                VStack {
                    HStack {
                        Text("이름: ")
                        TextField("이름", text: $name)
                    }
                    HStack {
                        Text("성별: ")
                        TextField("성별", text: $sex)
                    }
                    HStack {
                        Text("무게: ")
                        TextField("무게", text: $sex)
                    }
                    

                }

            }
            
            HStack {
                Spacer()
                Button("확인") {
                    print("확인")
                }
                Spacer()
            }
        }
        .navigationTitle("추가하기")
        .navigationBarTitleDisplayMode(.inline)

    }
}
