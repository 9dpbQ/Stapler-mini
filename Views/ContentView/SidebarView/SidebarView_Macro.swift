//
//  SidebarMacroView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/08.
//

import SwiftUI

struct SidebarView_Macro: View {
    @EnvironmentObject private var viewModel: ViewModel
    
    var body: some View {
        if viewModel.configuration.isMacroSelected {
            VStack {
                List(selection: $viewModel.configuration.selections.toDetail_macro) {
                    Section {
                        ForEach(viewModel.configuration.selections.macro.toDetailCollection.collection, id: \.self) { toDetail_macro in
                            HStack {
                                ModifierContentView_HStacked(withModifier: toDetail_macro.withModifier)
                                if toDetail_macro.outputAndDisplay.isSFSymbol {
                                    Image(systemName: toDetail_macro.outputAndDisplay.display)
                                } else {
                                    Text(toDetail_macro.outputAndDisplay.display)
                                }
                                
                                Spacer()
                                Image(systemName: "line.3.horizontal")
                                    .foregroundStyle(.gray)
                            }
                            .tag(toDetail_macro)
                        }
                        .onMove { indexSet, offset in
                            viewModel.configuration.selections.macro.toDetailCollection.collection.move(fromOffsets: indexSet, toOffset: offset)
                        }
                        
                    } header: {
                        TextField("Macro Name", text: $viewModel.configuration.selections.macro.name)
                    }
                }
            }
        } else {
            InitialMacroView()
        }
    }
}
