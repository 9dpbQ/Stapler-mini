//
//  ContentView.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2024/12/07.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var viewModel: ViewModel
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [SortDescriptor(\Configuration.name, order: .forward)]) private var configurations: [Configuration]

    @State private var selectedConfig: Configuration?
    @State private var isInspectorPresented: Bool = false
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var isSheetPresented_AddConfig: Bool = false

    var body: some View {
        NavigationSplitView {
            List(selection: $selectedConfig) {
                // 設定一覧セクション
                ForEach(configurations) { config in
                    NavigationLink(value: config) {
                        Group {
                            if config.id != selectedConfig?.id {
                                Text(config.name)
                            } else {
                                TextField("Configuration name", text: $viewModel.configuration.name)
                            }
                        }
                        .dropDestination(for: DragClass.self) { items, location in
                            guard let item = items.first else { return false }
                            if let macro = item.macro {
                                config.macroCollection.collection.append(macro)
                                return true
                            }
                            return true
                        }
                        .contextMenu {
                            Button("delete") {
                                withAnimation {
                                    selectedConfig = nil
                                    viewModel.configuration = .initialConfig
                                    modelContext.delete(config)
                                }
                            }
                        }
                    }
                    .tag(config)
                }

                // Sample セクション（tagなし）
                Section {
                    DisclosureGroup("Sample") {
                        NavigationLink {
                            StoredConfigurationsListView(
                                addAction: { storedConfig, region in
                                    if let newConfig = loadStoredConfig(storedConfig: storedConfig, region: region) {
                                        modelContext.insert(newConfig)
                                    }
                                },
                                storedConfigs: [.onishi, .onik, .astarte, .wakasagi, .dvorakJP, .eucalyn, .m_shiki]
                            )
                        } label: {
                            Text("Layouts for Japanese and English")
                        }

                        NavigationLink {
                            StoredConfigurationsListView(
                                addAction: { storedConfig, region in
                                    if let newConfig = loadStoredConfig(storedConfig: storedConfig, region: region) {
                                        modelContext.insert(newConfig)
                                    }
                                },
                                storedConfigs: [.colemak, .mtgap, .dvorak, .poqtea, .uciea_vanilla, .workman]
                            )
                        } label: {
                            Text("Layouts for English")
                        }

                        NavigationLink {
                            StoredConfigurationsListView(
                                addAction: { storedConfig, region in
                                    if let newConfig = loadStoredConfig(storedConfig: storedConfig, region: region) {
                                        modelContext.insert(newConfig)
                                    }
                                },
                                storedConfigs: [.layerSample]
                            )
                        } label: {
                            Text("Layer Sample")
                        }
                    }
                }
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200, max: 220)
            .toolbar {
                ToolbarItem {
                    Button {
                        isSheetPresented_AddConfig = true
                    } label: {
                        Label("add Config", systemImage: "plus")
                    }
                }
            }
        } detail: {
            if let config = selectedConfig {
                ConfigurationView(configuration: config)
            } else {
                IntroductionView()
            }
        }
        .onChange(of: selectedConfig) { newConfig in
            if let config = newConfig {
                viewModel.configuration = config
            } else {
                viewModel.configuration = Configuration.initialConfig
            }
        }
        .inspector(isPresented: $isInspectorPresented) {
             SidebarView()
                .inspectorColumnWidth(min: 180, ideal: 200, max: 220)
                .toolbar {
                    ToolbarItem {
                        Button {
                            isInspectorPresented.toggle()
                        } label: {
                            Label("toggle inspector", systemImage: "sidebar.right")
                        }
                    }
                }
        }
        .sheet(isPresented: $isSheetPresented_AddConfig) {
            AddConfigSheetView(
                isSheetPresented: $isSheetPresented_AddConfig,
                onDecision: addConfig,
                importConfiguration: {
                    loadConfiguration { configuration in
                        if let newConfiguration = configuration {
                            modelContext.insert(newConfiguration)
                            print("Success loading configuration")
                        } else {
                            print("Fail to load configuration")
                            showingAlert = true
                            alertMessage = "Fail to Load Configuration. If you need help, please contact the developer on Discord."
                        }
                    }
                }
            )
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Result"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    func addConfig(_ newConfiguration: Configuration) {
        withAnimation {
            modelContext.insert(newConfiguration)
        }
    }

    func addStoredConfig(_ storedConfig: StoredConfiguration, _ region: KeycodeRegion) {
        if let newConfig = loadStoredConfig(storedConfig: storedConfig, region: region) {
            modelContext.insert(newConfig)
        }
    }
}
