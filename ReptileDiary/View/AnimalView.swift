//
//  AnimalView.swift
//  ReptileDiary
//
//  Created by 변예린 on 11/17/25.
//

import SwiftUI

struct AnimalView: View {
    
    var body: some View {
        
        Text("동물")
        NavigationView {
            Text("도마뱀1")
                .toolbar {
                    Button {
                        print("추가")
                    } label: {
                        Image(systemName: "plus")
                    }

                }
        }
    }
}
    
    #Preview {
        AnimalView()
    }
