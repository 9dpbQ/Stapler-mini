//
//  Qwerty.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/09.
//
import SwiftUI

struct Qwerty_CustomizeKey_From: View {
    @EnvironmentObject private var viewModel: ViewModel
    @State var builtInOrFullSize: BuiltInOrFullSize = .builtIn
    private var keyMetrics: KeyMetrics {
        KeyMetrics(unitSize: 1.0, baseSizeX: 45)
    }
    enum BuiltInOrFullSize: String, CaseIterable {
        case builtIn
        case fullSize
    }
    
    var body: some View {
        List {
            VStack {
                HStack {
                    Spacer()
                    Picker("Keyboard Type", selection: $viewModel.configuration.keymap.keycodeRegion) {
                        ForEach(KeycodeRegion.allCases, id: \.self) { region in
                            Text(region.rawValue).tag(region)
                        }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .frame(width: 300)
                    Picker("Keyboard Size", selection: $builtInOrFullSize) {
                        ForEach(BuiltInOrFullSize.allCases, id: \.self) { type in
                            Text(type.rawValue.capitalized).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .frame(width: 200)
                    Spacer()
                }
                HStack {
                    
                    Spacer()
                    switch viewModel.configuration.keymap.keycodeRegion {
                    case .JIS:
                        switch builtInOrFullSize {
                        case .builtIn:
                            JIS_BuiltIn
                        case .fullSize:
                            JIS_FullSize
                        }
                    case .ANSI:
                        switch builtInOrFullSize {
                        case .builtIn:
                            US_BuiltIn
                        case .fullSize:
                            US_FullSize
                        }
                    case .ISO:
                        switch builtInOrFullSize {
                        case .builtIn:
                            UK_BuiltIn
                        case .fullSize:
                            UK_FullSize
                        }
                    }
                    Spacer()
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
    private var US_row_q_to_z: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_from(.controls_and_symbols(.grave_accent), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.one), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.two), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.three), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.four), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.five), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.six), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.seven), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.eight), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.nine), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.zero), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.hyphen), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.equal_sign_or_caret), region: .ANSI, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.delete_or_backspace), unitSize: 1.5, displayKeySize: keyMetrics.baseSizeX)
            }
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_from(.controls_and_symbols(.tab), unitSize: 1.5, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.q), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.w), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.e), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.r), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.t), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.y), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.u), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.i), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.o), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.p), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.open_square_bracket), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.close_square_bracket), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.backslash_or_yen), region: .ANSI, displayKeySize: keyMetrics.baseSizeX)
            }
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_from(.modifier_keys(.caps_lock), unitSize: 1.75, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.a), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.s), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.d), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.f), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.g), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.h), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.j), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.k), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.l), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.semicolon), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.single_quotation_or_colon), region: .ANSI, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.return_or_enter), unitSize: 1.75, displayKeySize: keyMetrics.baseSizeX)
            }
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_from(.modifier_keys(.left_shift), unitSize: 2.25, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.z), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.x), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.c), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.v), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.b), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.n), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.m), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.comma), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.period), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.slash), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.modifier_keys(.right_shift), unitSize: 2.25, displayKeySize: keyMetrics.baseSizeX)
            }

        }
    }
    
    private var US_BuiltIn: some View {
        VStack(alignment: .leading, spacing: 0) {
            functionRow
            US_row_q_to_z
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_from(.modifier_keys(.keyboard_fn), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.modifier_keys(.left_control), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.modifier_keys(.left_option), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.modifier_keys(.left_command), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.spacebar), unitSize: 5, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.modifier_keys(.right_command), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.modifier_keys(.right_option), displayKeySize: keyMetrics.baseSizeX)
                
                builtInArrows
            }
        }
    }
    private var US_FullSize: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                functionRow
                US_row_q_to_z
                HStack(alignment: .top, spacing: 0) {
                    CustomizeKeyView_from(.modifier_keys(.keyboard_fn), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.modifier_keys(.left_control), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.modifier_keys(.left_option), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.modifier_keys(.left_command), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.controls_and_symbols(.spacebar), unitSize: 6, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.modifier_keys(.right_command), unitSize: 1.5, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.modifier_keys(.right_option), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.modifier_keys(.right_control), unitSize: 1.5, displayKeySize: keyMetrics.baseSizeX)
                }
            }
            .padding(keyMetrics.padding_section)
            arrows.padding(keyMetrics.padding_section)
            tenkey(isJIS: false).padding(keyMetrics.padding_section)
        }
    }
    private var UK_row_q_to_z: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_from(.controls_and_symbols(.section), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.one), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.two), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.three), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.four), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.five), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.six), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.seven), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.eight), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.nine), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.zero), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.hyphen), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.equal_sign_or_caret), region: .ISO, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.delete_or_backspace), unitSize: 1.5, displayKeySize: keyMetrics.baseSizeX)
            }
            ZStack(alignment: .leading) {
                HStack(alignment: .top, spacing: 0) {
                    CustomizeKeyView_from(.controls_and_symbols(.tab), unitSize: 1.5, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.letter_keys(.q), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.letter_keys(.w), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.letter_keys(.e), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.letter_keys(.r), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.letter_keys(.t), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.letter_keys(.y), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.letter_keys(.u), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.letter_keys(.i), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.letter_keys(.o), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.letter_keys(.p), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.controls_and_symbols(.open_square_bracket), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.controls_and_symbols(.close_square_bracket), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.controls_and_symbols(.return_or_enter), keyShape: .enter_UK, displayKeySize: keyMetrics.baseSizeX)
                }
                VStack(alignment: .leading, spacing: 0) {
                    Spacer().frame(width: keyMetrics.frameWidth, height: keyMetrics.frameHeight)
                    HStack(alignment: .bottom, spacing: 0) {
                        CustomizeKeyView_from(.modifier_keys(.caps_lock), unitSize: 1.75, displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.letter_keys(.a), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.letter_keys(.s), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.letter_keys(.d), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.letter_keys(.f), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.letter_keys(.g), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.letter_keys(.h), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.letter_keys(.j), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.letter_keys(.k), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.letter_keys(.l), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.controls_and_symbols(.semicolon), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.controls_and_symbols(.single_quotation_or_colon), region: .ISO, displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.controls_and_symbols(.backslash_or_yen), region: .ISO, displayKeySize: keyMetrics.baseSizeX)
                    }
                }
            }
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_from(.modifier_keys(.left_shift), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.grave_accent), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.z), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.x), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.c), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.v), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.b), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.n), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.m), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.comma), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.period), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.slash), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.modifier_keys(.right_shift), unitSize: 2.25, displayKeySize: keyMetrics.baseSizeX)
            }
        }
    }
    private var UK_BuiltIn: some View {
        VStack(alignment: .leading, spacing: 0) {
            functionRow
            UK_row_q_to_z
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_from(.modifier_keys(.keyboard_fn), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.modifier_keys(.left_control), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.modifier_keys(.left_option), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.modifier_keys(.left_command), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.spacebar), unitSize: 5, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.modifier_keys(.right_command), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.modifier_keys(.right_option), displayKeySize: keyMetrics.baseSizeX)
                
                builtInArrows
            }
        }
    }
    private var UK_FullSize: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                functionRow
                UK_row_q_to_z
                HStack(alignment: .top, spacing: 0) {
                    CustomizeKeyView_from(.modifier_keys(.keyboard_fn), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.modifier_keys(.left_control), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.modifier_keys(.left_option), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.modifier_keys(.left_command), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.controls_and_symbols(.spacebar), unitSize: 6, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.modifier_keys(.right_command), unitSize: 1.5, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.modifier_keys(.right_option), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.modifier_keys(.right_control), unitSize: 1.5, displayKeySize: keyMetrics.baseSizeX)
                }
            }.padding(keyMetrics.padding_section)
            arrows.padding(keyMetrics.padding_section)
            tenkey(isJIS: false).padding(keyMetrics.padding_section)
        }
    }
    private var JIS_row_q_to_z: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_from(.number_keys(.one), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.two), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.three), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.four), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.five), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.six), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.seven), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.eight), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.nine), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.number_keys(.zero), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.hyphen), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.equal_sign_or_caret), region: .JIS, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.international_keys(.international3), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.delete_or_backspace), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
            }
            ZStack(alignment: .leading) {
                
                HStack(alignment: .top, spacing: 0) {
                    CustomizeKeyView_from(.controls_and_symbols(.tab), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.letter_keys(.q), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.letter_keys(.w), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.letter_keys(.e), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.letter_keys(.r), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.letter_keys(.t), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.letter_keys(.y), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.letter_keys(.u), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.letter_keys(.i), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.letter_keys(.o), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.letter_keys(.p), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.controls_and_symbols(.commercial_at_jis), region: .JIS, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.controls_and_symbols(.open_square_bracket), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.controls_and_symbols(.return_or_enter), unitSize: 1.5, keyShape: .enter_JIS, displayKeySize: keyMetrics.baseSizeX)
                }
                VStack(alignment: .leading, spacing: 0) {
                    Spacer().frame(width: keyMetrics.frameWidth, height: keyMetrics.frameHeight)
                    HStack(alignment: .top, spacing: 0) {
                        CustomizeKeyView_from(.modifier_keys(.left_control), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.letter_keys(.a), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.letter_keys(.s), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.letter_keys(.d), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.letter_keys(.f), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.letter_keys(.g), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.letter_keys(.h), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.letter_keys(.j), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.letter_keys(.k), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.letter_keys(.l), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.controls_and_symbols(.semicolon), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.controls_and_symbols(.single_quotation_or_colon), region: .JIS, displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.controls_and_symbols(.close_square_bracket), displayKeySize: keyMetrics.baseSizeX)
                    }
                }
            }
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_from(.modifier_keys(.left_shift), unitSize: 1.75, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.z), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.x), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.c), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.v), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.b), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.n), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.letter_keys(.m), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.comma), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.period), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.slash), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.international_keys(.international1), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.modifier_keys(.right_shift), unitSize: 1.75, displayKeySize: keyMetrics.baseSizeX)
            }
        }
    }

    private var JIS_BuiltIn: some View {
        VStack(alignment: .leading, spacing: 0) {
            functionRow
            JIS_row_q_to_z
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_from(.modifier_keys(.caps_lock), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.modifier_keys(.left_option), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.modifier_keys(.left_command), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.japanese(.eisuu), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.controls_and_symbols(.spacebar), unitSize: 3.5, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.japanese(.kana), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.modifier_keys(.right_command), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.modifier_keys(.keyboard_fn), displayKeySize: keyMetrics.baseSizeX)
                builtInArrows
            }
        }
    }
    private var JIS_FullSize: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                functionRow
                JIS_row_q_to_z
                HStack(alignment: .top, spacing: 0) {
                    CustomizeKeyView_from(.modifier_keys(.caps_lock), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.modifier_keys(.left_option), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.modifier_keys(.left_command), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.japanese(.eisuu), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.controls_and_symbols(.spacebar), unitSize: 3.5, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.japanese(.kana), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.modifier_keys(.right_command), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.modifier_keys(.right_option), unitSize: 1.5, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.modifier_keys(.right_control), unitSize: 1.5, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_from(.modifier_keys(.keyboard_fn), unitSize: 1, displayKeySize: keyMetrics.baseSizeX)
                }
            }
            .padding(keyMetrics.padding_section)
            arrows
                .padding(keyMetrics.padding_section)
            tenkey(isJIS: true)
                .padding(keyMetrics.padding_section)
        }
    }
    private var builtInArrows: some View {
        HStack(spacing: 0) {
            CustomizeKeyView_from(.arrow_keys(.left_arrow), displayKeySize: keyMetrics.baseSizeX)
            VStack(alignment: .leading, spacing: 0) {
                CustomizeKeyView_from(.arrow_keys(.up_arrow), keyShape: .arrow_Up, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.arrow_keys(.down_arrow), keyShape: .arrow_Down, displayKeySize: keyMetrics.baseSizeX)
            }
            CustomizeKeyView_from(.arrow_keys(.right_arrow), displayKeySize: keyMetrics.baseSizeX)
        }
    }
    private var functionRow: some View {
        HStack(alignment: .top, spacing: 0) {
            CustomizeKeyView_from(.controls_and_symbols(.escape), unitSize: 1.5, displayKeySize: keyMetrics.baseSizeX)
            CustomizeKeyView_from(.function_keys(.f1), displayKeySize: keyMetrics.baseSizeX)
            CustomizeKeyView_from(.function_keys(.f2), displayKeySize: keyMetrics.baseSizeX)
            CustomizeKeyView_from(.function_keys(.f3), displayKeySize: keyMetrics.baseSizeX)
            CustomizeKeyView_from(.function_keys(.f4), displayKeySize: keyMetrics.baseSizeX)
            CustomizeKeyView_from(.function_keys(.f5), displayKeySize: keyMetrics.baseSizeX)
            CustomizeKeyView_from(.function_keys(.f6), displayKeySize: keyMetrics.baseSizeX)
            CustomizeKeyView_from(.function_keys(.f7), displayKeySize: keyMetrics.baseSizeX)
            CustomizeKeyView_from(.function_keys(.f8), displayKeySize: keyMetrics.baseSizeX)
            CustomizeKeyView_from(.function_keys(.f9), displayKeySize: keyMetrics.baseSizeX)
            CustomizeKeyView_from(.function_keys(.f10), displayKeySize: keyMetrics.baseSizeX)
            CustomizeKeyView_from(.function_keys(.f11), displayKeySize: keyMetrics.baseSizeX)
            CustomizeKeyView_from(.function_keys(.f12), displayKeySize: keyMetrics.baseSizeX)
        }
    }
    private var arrows: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_from(.function_keys(.f13), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.function_keys(.f14), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.function_keys(.f15), displayKeySize: keyMetrics.baseSizeX)
            }
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_from(.keys_in_pc_keyboards(.insert), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.arrow_keys(.home), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.arrow_keys(.page_up), displayKeySize: keyMetrics.baseSizeX)
            }
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_from(.controls_and_symbols(.delete_forward), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.arrow_keys(.end), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.arrow_keys(.page_down), displayKeySize: keyMetrics.baseSizeX)
            }
            HStack(alignment: .top, spacing: 0) {
                // ここはスペーサー
                spacer1u
                spacer1u
                spacer1u
            }
            HStack(alignment: .top, spacing: 0) {
                spacer1u
                CustomizeKeyView_from(.arrow_keys(.up_arrow), displayKeySize: keyMetrics.baseSizeX)
                spacer1u
            }
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_from(.arrow_keys(.left_arrow), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.arrow_keys(.down_arrow), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.arrow_keys(.right_arrow), displayKeySize: keyMetrics.baseSizeX)
            }
        }
    }
    private var spacer1u: some View {
        Spacer()
            .frame(width: keyMetrics.frameWidth, height: keyMetrics.frameWidth)
    }
    private func tenkey(isJIS: Bool) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_from(.function_keys(.f16), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.function_keys(.f17), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.function_keys(.f18), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.function_keys(.f19), displayKeySize: keyMetrics.baseSizeX)
            }
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_from(.letter_keys(.a), displayKeySize: keyMetrics.baseSizeX)// clear
                CustomizeKeyView_from(.keypad_keys(.keypad_equal_sign), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.keypad_keys(.keypad_slash), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.keypad_keys(.keypad_asterisk), displayKeySize: keyMetrics.baseSizeX)
            }
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_from(.keypad_keys(.keypad_7), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.keypad_keys(.keypad_8), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.keypad_keys(.keypad_9), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.keypad_keys(.keypad_hyphen), displayKeySize: keyMetrics.baseSizeX)
            }
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_from(.keypad_keys(.keypad_4), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.keypad_keys(.keypad_5), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.keypad_keys(.keypad_6), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_from(.keypad_keys(.keypad_plus), displayKeySize: keyMetrics.baseSizeX)
            }
            HStack(alignment: .top, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .top, spacing: 0) {
                        CustomizeKeyView_from(.keypad_keys(.keypad_1), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.keypad_keys(.keypad_2), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_from(.keypad_keys(.keypad_3), displayKeySize: keyMetrics.baseSizeX)
                    }
                    HStack(alignment: .top, spacing: 0) {
                        if isJIS {
                            CustomizeKeyView_from(.keypad_keys(.keypad_0), displayKeySize: keyMetrics.baseSizeX)
                            CustomizeKeyView_from(.keypad_keys(.keypad_comma), displayKeySize: keyMetrics.baseSizeX)
                            CustomizeKeyView_from(.keypad_keys(.keypad_period), displayKeySize: keyMetrics.baseSizeX)
                        } else {
                            CustomizeKeyView_from(.keypad_keys(.keypad_0), unitSize: 2, displayKeySize: keyMetrics.baseSizeX)
                            CustomizeKeyView_from(.keypad_keys(.keypad_period), displayKeySize: keyMetrics.baseSizeX)
                        }
                    }
                }
                CustomizeKeyView_from(.keypad_keys(.keypad_enter), keyShape: .enter_Tenkey, displayKeySize: keyMetrics.baseSizeX)
            }
        }
    }
}
