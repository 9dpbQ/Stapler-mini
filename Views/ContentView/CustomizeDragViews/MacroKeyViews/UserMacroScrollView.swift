//
//  UserMacroScrollView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/09.
//

import SwiftUI
struct UserMacroScrollView: View {
    @EnvironmentObject private var viewModel: ViewModel
    private var macroCollection: MacroCollection {
        viewModel.configuration.macroCollection
    }
    
    
    let columns = [
        GridItem(.adaptive(minimum: 65 - 65 * 0.07 + 2.5, maximum: 100))
    ]
    
    @State private var searchText: String = ""
    var filterdMacros: [Macro] {
        let allMacros = macroCollection.collection
        if searchText.isEmpty {
            return allMacros
        } else {
            return allMacros.filter { mc in
                mc.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    var body: some View {
        
        if macroCollection.collection.isEmpty {
            Text("User Macro is empty. You can add User Macros from Macro tab.")
                .font(.headline)
                .foregroundStyle(.secondary)
        } else {
            List {
                HStack {
                    Spacer()
                    TextField("Search with Macro name", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 200)
                }
                .listRowSeparator(.hidden)

                if filterdMacros.isEmpty {
                    HStack {
                        Spacer()
                        Text("No results for \"\(searchText)\".")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                            .listRowSeparator(.hidden)
                        Spacer()
                    }
                } else {
                    LazyVGrid(columns: columns, spacing: 5) {
                        ForEach(filterdMacros, id: \.self) { macro in
                            MacroKeyView(macro, sizeX: viewModel.configuration.displayKeySize)
                        }
                        .listRowSeparator(.hidden)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            
        }
    }
}
