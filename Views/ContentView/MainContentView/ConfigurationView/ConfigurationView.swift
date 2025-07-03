//
//  PresetView.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2024/12/08.
//
import SwiftData
import SwiftUI

struct ConfigurationView: View {
    @EnvironmentObject private var viewModel: ViewModel
    @Bindable var configuration: Configuration
    
    private var keyMetrics: KeyMetrics { viewModel.keyMetrics }
    @State var isSheetPresented_Export: Bool = false

    var body: some View {
        if viewModel.configuration != .initialConfig {
            VStack(spacing: 5) {
                HStack {
                    Picker("CustomTab", selection: $configuration.selections.tab) {
                        ForEach(SelectedTab.allCases, id: \.self) { type in
                            Text(type.displayString())
                                .help(type.helpText())
                                .tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .frame(maxWidth: 800)
                }
                // キーボードの上に表示するビュー
                Group {
                    if configuration.selections.tab == .remap || configuration.selections.tab == .combo {
                        SelectConditionAndLayerView(
                            conditionDetailCollection: $configuration.conditionDetailCollection,
                            selections: $configuration.selections
                        )
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                }
                
                Spacer()
                
                // キーボードとコンボのリスト、メインなコンテンツ
                HStack {
                    Group {
                        if configuration.selections.tab == .combo {
                            ComboListView()
                                .transition(.move(edge: .trailing).combined(with: .opacity))
                        }
                        
                        if configuration.selections.tab == .macro {
                            MacroView()
                                .transition(.move(edge: .leading).combined(with: .opacity))
                        } else {
                            AllDeviceView(keymap: $configuration.keymap)
                                .transition(.move(edge: .trailing).combined(with: .opacity))
                        }
                    }
                }
                Spacer()
                
                // 下に常時表示するカスタム用のキー
                CustomizeKeyAndMacroKeyView()
                    .transition(.opacity)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        isSheetPresented_Export = true
                    } label: {
                        Label("export configuration", systemImage: "square.and.arrow.up")
                    }
                }
            }
            .sheet(isPresented: $isSheetPresented_Export) {
                ExportSheetView()
            }
            .padding()
            .navigationTitle(viewModel.configuration.name)
            .animation(.default, value: configuration.selections.tab) // アニメーション適用
        } else {
            IntroductionView()
        }
    }
    
}

struct IntroductionView: View {
    let messages = [
        "Stapler-mini is an application for generating JSON configuration files for Karabiner-Elements. With an intuitive interface and visually clear GUI, you can create and apply complex settings for remapping, layers, combos, and macros—without directly editing JSON files.",
        "Stapler-mini was developed to make layer customization intuitive for any keyboard recognized by Karabiner-Elements.",
        "Stapler-mini enables conditional customization based on active applications, IME status, and the number of fingers on a trackpad—thanks to the powerful capabilities of Karabiner-Elements. This level of flexibility is difficult to achieve with a standalone custom keyboard.",
        "Stapler-mini allows you to customize up to three devices simultaneously. Since many users operate both a mouse and a keyboard at the same time, it makes sense to provide full customization for such scenarios."
    ]
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Select configuration or Add one from + Button.")
                    .font(.headline)
                
            }
            .padding()
            
            Text(messages.randomElement() ?? "")
                .font(.caption)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center) // 左寄せ（中央なら .center）
                .lineLimit(nil) // 行数制限なしで折り返し
                .frame(width: 450) // 幅いっぱいにする
            
            HStack {
                Image(nsImage: NSApp.applicationIconImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }
            
            Button("How to Use this Application") {
                openURL(urlString: "https://github.com/9dpbQ/Stapler-mini?tab=readme-ov-file#%E3%82%AB%E3%82%B9%E3%82%BF%E3%83%9E%E3%82%A4%E3%82%BA%E3%81%AE%E6%B5%81%E3%82%8C")
            }
            .buttonStyle(.link)
            .padding()

        }
    }
    private func openURL(urlString: String) {
        guard let url = URL(string: urlString) else {
            print("❌ 無効なURL: \(urlString)")
            return
        }
        NSWorkspace.shared.open(url)
    }
}

struct SelectLayerButtonViews: View {
    @EnvironmentObject private var viewModel: ViewModel
    var body: some View {
        HStack {
            ForEach(Layer.allCases, id: \.self) { layer in
                LayerSelectButton(layer: layer) {
                    viewModel.configuration.selections.layer = layer
                    viewModel.configuration.selections.keyboardKey = .initialKey
                    viewModel.configuration.selections.combo = .initialCombo
                    viewModel.configuration.selections.macro = .initialMacro
                }
                .help(layer.helpText())
                
            }
        }
    }
}

struct LayerSelectButton: View {
    let layer: Layer
    let action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            Text(layer.displayName)
                .foregroundStyle(.black)
        }
        .buttonStyle(LayerButtonStyle(layer: layer))
    }
}

#Preview {
    @Previewable @StateObject var viewModel = ViewModel() // ViewModelを初期化
    SelectLayerButtonViews()
        .environmentObject(viewModel)
        .padding()
}

struct LayerButtonStyle: ButtonStyle {
    @EnvironmentObject private var viewModel: ViewModel
    let layer: Layer
    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 80, height: 30)
            .background(
                ParallelogramShape()
                    .fill(
                        layer == viewModel.configuration.selections.layer
                        ? layer.accentColor
                        : .gray
                    )
                    .shadow(color: .black.opacity(configuration.isPressed ? 0.1 : 0.3),
                            radius: configuration.isPressed ? 2 : 4,
                            x: configuration.isPressed ? 1 : 2,
                            y: configuration.isPressed ? 1 : 2)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct ParallelogramShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let skewAmount: CGFloat = rect.maxX * 0.15
        
        path.move(to: CGPoint(x: skewAmount, y: rect.minY))//左上から時計まわりに
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - skewAmount, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: skewAmount, y: rect.minY))
        
        return path
    }
}

struct SelectConditionAndLayerView: View {
    @Binding var conditionDetailCollection: ConditionDetailCollection
    @Binding var selections: Selections
    var body: some View {
        VStack {
            List {
                HStack {
                    Picker("Specific Condition", selection: $selections.condition) {
                        ForEach(SpecificCondition.allCases, id: \.self) { condition in
                            Text(conditionDetailCollection.getConditionDetail(condition).name).tag(condition)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 200)
                    
                    if selections.condition != .condition0 {
                        Toggle(
                            isOn: Binding(
                                get: {
                                    conditionDetailCollection.getConditionDetail(selections.condition).isEnabled
                                },
                                set: { newValue in
                                    conditionDetailCollection.getConditionDetail(selections.condition).isEnabled = newValue
                                }
                            )
                        ) {
                            TextField("Condition Name",
                                      text: Binding(
                                        get: {
                                            conditionDetailCollection.getConditionDetail(selections.condition).name
                                        },
                                        set: { newValue in
                                            conditionDetailCollection.getConditionDetail(selections.condition).name = newValue
                                        }
                                      )
                            )
                            .disabled(!conditionDetailCollection.getConditionDetail(selections.condition).isEnabled)
                            .textFieldStyle(.roundedBorder)
                        }
                        .help("Enable this condition.")
                        
                        Picker(
                            "Conditions",
                            selection:
                                Binding(
                                    get: { conditionDetailCollection.getConditionDetail(selections.condition).type },
                                    set: { newValue in
                                        conditionDetailCollection.getConditionDetail(selections.condition).type = newValue
                                    }
                                )
                        ) {
                            ForEach(ConditionType.allCases, id: \.self) { type in
                                Text(type.rawValue)
                                    .help(type.helpText())
                                    .tag(type)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(.segmented)
                        .disabled(!conditionDetailCollection.getConditionDetail(selections.condition).isEnabled)
                        
                        Text(conditionDetailCollection.getConditionDetail(selections.condition).type.textFieldDescription)
                            .frame(width: 60, alignment: .trailing)
                            .foregroundStyle(conditionDetailCollection.getConditionDetail(selections.condition).isEnabled ? .primary : Color.gray)
                        TextField(
                            conditionDetailCollection.getConditionDetail(selections.condition).type.placeholder,
                            text: Binding(
                                get: {
                                    conditionDetailCollection.getConditionDetail(selections.condition).value
                                },
                                set: { newValue in
                                    conditionDetailCollection.getConditionDetail(selections.condition).value = newValue
                                }
                            )
                        )
                        .disabled(!conditionDetailCollection.getConditionDetail(selections.condition).isEnabled)
                        .textFieldStyle(.roundedBorder)
                    } else {
                        Spacer()
                    }
                }
            }
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .frame(maxWidth: 800, maxHeight: 40)

            HStack {
                Spacer()
                SelectLayerButtonViews()
                Spacer()
            }
            .frame(maxWidth: 800)
        }
        .frame(maxHeight: 90)
    }
}

struct StoredConfigurationsListView: View {
    let addAction: (_ storedConfig: StoredConfiguration, _ region: KeycodeRegion) -> Void
    @State var selectedKeyboardRegion: KeycodeRegion = .ANSI
    let storedConfigs: [StoredConfiguration]
    @State var selectedStoredConfiguration: StoredConfiguration? = nil
    
    
    var body: some View {
        VStack {
            HStack {
                Picker("Keyboard layout", selection: $selectedKeyboardRegion) {
                    ForEach(KeycodeRegion.allCases, id: \.self) { region in
                        Text(region.layoutName())
                    }
                }
                .pickerStyle(.segmented)
                .labelsHidden()
                .frame(width: 250)
                .disabled(selectedStoredConfiguration == nil)

                Button("import") {
                    if let config = selectedStoredConfiguration {
                        addAction(config, selectedKeyboardRegion)
                    }
                }
                .disabled(selectedStoredConfiguration == nil)
            }
            .padding(.top)
            List(selection: $selectedStoredConfiguration) {
                ForEach(storedConfigs, id: \.self) { storedConfig in
                    StoredConfigurationView(storedConfig: storedConfig, selectedKeyboardRegion: selectedKeyboardRegion)
                        .tag(storedConfig)
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
}

struct StoredConfigurationView: View {
    let storedConfig: StoredConfiguration
    let selectedKeyboardRegion: KeycodeRegion
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(storedConfig.configurationTitle())
                    .font(.largeTitle)
                HStack {
                    Image(storedConfig.imageFileURL(selectedKeyboardRegion))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 500)
                        .cornerRadius(10)
                    Button(storedConfig.webURL()) {
                        openURL(urlString: storedConfig.webURL())
                    }
                    .buttonStyle(.link)
                    .frame(width: 150)
                }
            }
            Spacer()
        }
    }
    private func openURL(urlString: String) {
        guard let url = URL(string: urlString) else {
            print("❌ 無効なURL: \(urlString)")
            return
        }
        NSWorkspace.shared.open(url)
    }
}
