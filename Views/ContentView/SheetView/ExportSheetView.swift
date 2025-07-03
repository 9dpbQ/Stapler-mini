//
//  ExportSheetView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/01/29.
//

import SwiftUI

struct ExportSheetView: View {
    @EnvironmentObject private var viewModel: ViewModel
    private var configuration: Configuration { viewModel.configuration }
    
    @State var showingAlert: Bool = false
    @State var alertMessage: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            List {
                VStack {
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
                            print("share configuration file")
                            exportConfigurationAsJSON(configuration)
                        }) {
                            Label("Share", systemImage: "square.and.arrow.up")
                        }
                    }
                    .padding(.bottom)
                    
                    
                    TextField("ConfigurationName", text: $viewModel.configuration.name)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                      
                }
                Section {
                    Picker("Output Keycode Region", selection: $viewModel.configuration.keymap.keycodeRegion) {
                        ForEach(KeycodeRegion.allCases, id: \.self) { region in
                            Text(region.rawValue).tag(region)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section {
                    HStack {
                        Spacer()
                        
                        Button{
                            JSONExporter.exportPresetAsJSON(configuration, showingAlert: $showingAlert, alertMessage: $alertMessage)
                        } label: {
                            Label ("Export to Karabiner-Elements", systemImage: "document.badge.gearshape")
                        }
                    }
                }
            }
            .listStyle(.sidebar)
            .scrollDisabled(true)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Export Result"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        .frame(minWidth: 300, minHeight: 220)
    }
}

//#Preview {
//    ExportSheetView()
//}
