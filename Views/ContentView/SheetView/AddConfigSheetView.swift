//
//  AddConfigSheetView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/01/29.
//

import SwiftUI

struct AddConfigSheetView: View {
    @EnvironmentObject private var viewModel: ViewModel
    private var configuration: Configuration { viewModel.configuration }
    
    @Binding var isSheetPresented: Bool
    
    let onDecision: (Configuration) -> Void
    let importConfiguration: () -> Void
    
    @State var keyboardProduct: KeyboardProduct = .basic
    @State var keycodeRegion: KeycodeRegion = .ANSI
    @State var keyboardSize: KeyboardSize = .builtinSize
    @State var includeFunction: Bool = true
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            List {
                HStack {
                    OnHoverButtonView(
                        symbolName: "xmark.circle",
                        hoverColor: .red,
                        size: CGSize(width: 20, height: 20)
                    ) {
                        dismiss()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        print("Import configuration file")
                        importConfiguration()
                        dismiss()
                    }) {
                        Label("Import Configuration", systemImage: "square.and.arrow.down")
                    }
                    .help("import json file as Configuration.")
                }
                Picker("Keyboard Product", selection: $keyboardProduct) {
                    ForEach(KeyboardProduct.allCases, id: \.self) { product in
                        Text(product.displayString()).tag(product)
                    }
                }
                Picker("Keyboard Region", selection: $keycodeRegion) {
                    ForEach(KeycodeRegion.allCases, id: \.self) { region in
                        Text(region.rawValue).tag(region)
                    }
                }
                Picker("Keyboard size", selection: $keyboardSize) {
                    ForEach(KeyboardSize.allCases, id: \.self) { size in
                        Text(size.displayString()).tag(size)
                    }
                }
                .pickerStyle(.segmented)
                
                Toggle("Include FunctionKey", isOn: $includeFunction)
                    .toggleStyle(.switch)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button{
                        let newConfig = Configuration(
                            name: keyboardProduct.name(),
                            keymap: keyboardProduct.getKeymap(
                                fnRow: includeFunction,
                                keyboardSize: keyboardSize,
                                region: keycodeRegion)
                        )
                        onDecision(newConfig)
                        dismiss()
                    } label: {
                        Label ("Add Configuration", systemImage: "plus")
                    }
                }
            }
            .listStyle(.sidebar)
            .scrollDisabled(true)
        }
        .frame(minWidth: 300, minHeight: 220)

    }
}

