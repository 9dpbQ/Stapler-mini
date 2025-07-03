//
//  AllKeysView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/03/18.
//


import SwiftUI

struct AllKeysView_From: View {
    @EnvironmentObject private var viewModel: ViewModel
    @State private var searchText: String = ""
    
    var filterdAllKeys: [FromKeycode] {
        let allKeys = FromKeycode.allKeys
        if searchText.isEmpty {
            return allKeys
        } else {
            return allKeys.filter { key in
                key.defaultDisplayString(viewModel.configuration.keymap.keycodeRegion).display.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    let columns = [GridItem(.adaptive(minimum: 65), spacing: 0)]

    var body: some View {
        VStack {
            List {
                HStack {
                    Spacer()
                    
                    TextField("Search in All Keys", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 200)
                }
            }
            .scrollContentBackground(.hidden)
            .scrollDisabled(true)
            .frame(maxHeight: 50)
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(filterdAllKeys, id: \.self) { key in
                        CustomizeKeyView_from(key)
                    }
                }
            }
        }
        
    }
}

#Preview {
    AllKeysView_From()
}
