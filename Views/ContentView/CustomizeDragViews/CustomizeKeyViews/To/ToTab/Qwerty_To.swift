//
//  Qwerty.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/09.
//
import SwiftUI

struct Qwerty_CustomizeKey_to: View {
    @EnvironmentObject private var viewModel: ViewModel
    @State var builtInOrFullSize: BuiltInOrFullSize = .builtIn
    private var keyMetrics: KeyMetrics {
        KeyMetrics(unitSize: 1.0, baseSizeX: 40)
    }
    enum BuiltInOrFullSize: String, CaseIterable {
        case builtIn
        case fullSize
    }
    var body: some View {
        List {
            HStack {
                Spacer()
                switch viewModel.configuration.keymap.keycodeRegion {
                case .JIS: JIS_FullSize
                case .ANSI: US_FullSize
                case .ISO: UK_FullSize
                }
                Spacer()
            }
        }
        .scrollContentBackground(.hidden)
    }
    
    private var US_row_q_to_z: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_to(.controls_and_symbols(.grave_accent), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.one), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.two), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.three), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.four), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.five), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.six), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.seven), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.eight), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.nine), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.zero), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.hyphen), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.equal_sign), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.delete_or_backspace), unitSize: 1.5, displayKeySize: keyMetrics.baseSizeX)
            }
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_to(.controls_and_symbols(.tab), unitSize: 1.5, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.q), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.w), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.e), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.r), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.t), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.y), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.u), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.i), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.o), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.p), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.open_square_bracket), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.close_square_bracket), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.backslash), displayKeySize: keyMetrics.baseSizeX)
            }
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_to(.modifier_keys(.caps_lock), unitSize: 1.75, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.a), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.s), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.d), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.f), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.g), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.h), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.j), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.k), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.l), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.semicolon), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.single_quotation), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.return_or_enter), unitSize: 1.75, displayKeySize: keyMetrics.baseSizeX)
            }
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_to(.modifier_keys(.left_shift), unitSize: 2.25, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.z), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.x), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.c), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.v), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.b), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.n), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.m), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.comma), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.period), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.slash), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.modifier_keys(.right_shift), unitSize: 2.25, displayKeySize: keyMetrics.baseSizeX)
            }

        }
    }
    
    private var US_BuiltIn: some View {
        VStack(alignment: .leading, spacing: 0) {
            functionRow
            US_row_q_to_z
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_to(.modifier_keys(.keyboard_fn), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.modifier_keys(.left_control), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.modifier_keys(.left_option), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.modifier_keys(.left_command), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.spacebar), unitSize: 5, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.modifier_keys(.right_command), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.modifier_keys(.right_option), displayKeySize: keyMetrics.baseSizeX)
                
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
                    CustomizeKeyView_to(.modifier_keys(.keyboard_fn), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.modifier_keys(.left_control), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.modifier_keys(.left_option), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.modifier_keys(.left_command), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.controls_and_symbols(.spacebar), unitSize: 6, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.modifier_keys(.right_command), unitSize: 1.5, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.modifier_keys(.right_option), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.modifier_keys(.right_control), unitSize: 1.5, displayKeySize: keyMetrics.baseSizeX)
                }
            }.padding(keyMetrics.padding_section)
            arrows.padding(keyMetrics.padding_section)
            tenkey(isJIS: false).padding(keyMetrics.padding_section)
        }
    }
    private var UK_row_q_to_z: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_to(.controls_and_symbols(.section), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.one), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.two), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.three), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.four), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.five), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.six), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.seven), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.eight), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.nine), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.zero), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.hyphen), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.equal_sign), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.delete_or_backspace), unitSize: 1.5, displayKeySize: keyMetrics.baseSizeX)
            }
            ZStack(alignment: .leading) {
                HStack(alignment: .top, spacing: 0) {
                    CustomizeKeyView_to(.controls_and_symbols(.tab), unitSize: 1.5, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.letter_keys(.q), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.letter_keys(.w), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.letter_keys(.e), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.letter_keys(.r), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.letter_keys(.t), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.letter_keys(.y), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.letter_keys(.u), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.letter_keys(.i), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.letter_keys(.o), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.letter_keys(.p), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.controls_and_symbols(.open_square_bracket), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.controls_and_symbols(.close_square_bracket), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.controls_and_symbols(.return_or_enter), keyShape: .enter_UK, displayKeySize: keyMetrics.baseSizeX)
                }
                VStack(alignment: .leading, spacing: 0) {
                    Spacer().frame(width: keyMetrics.frameWidth, height: keyMetrics.frameHeight)
                    HStack(alignment: .bottom, spacing: 0) {
                        CustomizeKeyView_to(.modifier_keys(.caps_lock), unitSize: 1.75, displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.letter_keys(.a), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.letter_keys(.s), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.letter_keys(.d), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.letter_keys(.f), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.letter_keys(.g), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.letter_keys(.h), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.letter_keys(.j), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.letter_keys(.k), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.letter_keys(.l), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.controls_and_symbols(.semicolon), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.controls_and_symbols(.single_quotation), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.controls_and_symbols(.backslash), displayKeySize: keyMetrics.baseSizeX)
                    }
                }
            }
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_to(.modifier_keys(.left_shift), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.grave_accent), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.z), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.x), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.c), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.v), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.b), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.n), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.m), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.comma), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.period), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.slash), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.modifier_keys(.right_shift), unitSize: 2.25, displayKeySize: keyMetrics.baseSizeX)
            }
        }
    }
    private var UK_BuiltIn: some View {
        VStack(alignment: .leading, spacing: 0) {
            functionRow
            UK_row_q_to_z
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_to(.modifier_keys(.keyboard_fn), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.modifier_keys(.left_control), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.modifier_keys(.left_option), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.modifier_keys(.left_command), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.spacebar), unitSize: 5, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.modifier_keys(.right_command), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.modifier_keys(.right_option), displayKeySize: keyMetrics.baseSizeX)
                
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
                    CustomizeKeyView_to(.modifier_keys(.keyboard_fn), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.modifier_keys(.left_control), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.modifier_keys(.left_option), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.modifier_keys(.left_command), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.controls_and_symbols(.spacebar), unitSize: 6, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.modifier_keys(.right_command), unitSize: 1.5, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.modifier_keys(.right_option), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.modifier_keys(.right_control), unitSize: 1.5, displayKeySize: keyMetrics.baseSizeX)
                }
            }.padding(keyMetrics.padding_section)
            arrows.padding(keyMetrics.padding_section)
            tenkey(isJIS: false).padding(keyMetrics.padding_section)
        }
    }
    private var JIS_row_q_to_z: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_to(.number_keys(.one), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.two), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.three), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.four), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.five), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.six), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.seven), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.eight), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.nine), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.number_keys(.zero), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.hyphen), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.shift_symbols(.caret), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.international_keys(.international3), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.delete_or_backspace), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
            }
            ZStack(alignment: .leading) {
                
                HStack(alignment: .top, spacing: 0) {
                    CustomizeKeyView_to(.controls_and_symbols(.tab), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.letter_keys(.q), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.letter_keys(.w), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.letter_keys(.e), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.letter_keys(.r), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.letter_keys(.t), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.letter_keys(.y), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.letter_keys(.u), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.letter_keys(.i), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.letter_keys(.o), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.letter_keys(.p), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.shift_symbols(.commercial_at), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.controls_and_symbols(.open_square_bracket), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.controls_and_symbols(.return_or_enter), unitSize: 1.5, keyShape: .enter_JIS, displayKeySize: keyMetrics.baseSizeX)
                }
                VStack(alignment: .leading, spacing: 0) {
                    Spacer().frame(width: keyMetrics.frameWidth, height: keyMetrics.frameHeight)
                    HStack(alignment: .top, spacing: 0) {
                        CustomizeKeyView_to(.modifier_keys(.left_control), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.letter_keys(.a), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.letter_keys(.s), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.letter_keys(.d), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.letter_keys(.f), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.letter_keys(.g), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.letter_keys(.h), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.letter_keys(.j), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.letter_keys(.k), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.letter_keys(.l), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.controls_and_symbols(.semicolon), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.shift_symbols(.colon), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.controls_and_symbols(.close_square_bracket), displayKeySize: keyMetrics.baseSizeX)
                    }
                }
            }
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_to(.modifier_keys(.left_shift), unitSize: 1.75, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.z), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.x), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.c), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.v), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.b), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.n), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.letter_keys(.m), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.comma), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.period), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.slash), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.international_keys(.international1), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.modifier_keys(.right_shift), unitSize: 1.75, displayKeySize: keyMetrics.baseSizeX)
            }
        }
    }

    private var JIS_BuiltIn: some View {
        VStack(alignment: .leading, spacing: 0) {
            functionRow
            JIS_row_q_to_z
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_to(.modifier_keys(.caps_lock), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.modifier_keys(.left_option), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.modifier_keys(.left_command), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.japanese(.eisuu), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.controls_and_symbols(.spacebar), unitSize: 3.5, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.japanese(.kana), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.modifier_keys(.right_command), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.modifier_keys(.keyboard_fn), displayKeySize: keyMetrics.baseSizeX)
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
                    CustomizeKeyView_to(.modifier_keys(.caps_lock), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.modifier_keys(.left_option), displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.modifier_keys(.left_command), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.japanese(.eisuu), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.controls_and_symbols(.spacebar), unitSize: 3.5, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.japanese(.kana), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.modifier_keys(.right_command), unitSize: 1.25, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.modifier_keys(.right_option), unitSize: 1.5, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.modifier_keys(.right_control), unitSize: 1.5, displayKeySize: keyMetrics.baseSizeX)
                    CustomizeKeyView_to(.modifier_keys(.keyboard_fn), unitSize: 1, displayKeySize: keyMetrics.baseSizeX)
                }
            }.padding(keyMetrics.padding_section)
            arrows.padding(keyMetrics.padding_section)
            tenkey(isJIS: true).padding(keyMetrics.padding_section)
        }
    }
    private var builtInArrows: some View {
        HStack(spacing: 0) {
            CustomizeKeyView_to(.arrow_keys(.left_arrow), displayKeySize: keyMetrics.baseSizeX)
            VStack(alignment: .leading, spacing: 0) {
                CustomizeKeyView_to(.arrow_keys(.up_arrow), keyShape: .arrow_Up, displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.arrow_keys(.down_arrow), keyShape: .arrow_Down, displayKeySize: keyMetrics.baseSizeX)
            }
            CustomizeKeyView_to(.arrow_keys(.right_arrow), displayKeySize: keyMetrics.baseSizeX)
        }
    }
    private var functionRow: some View {
        HStack(alignment: .top, spacing: 0) {
            CustomizeKeyView_to(.controls_and_symbols(.escape), unitSize: 1.5, displayKeySize: keyMetrics.baseSizeX)
            CustomizeKeyView_to(.function_keys(.f1), displayKeySize: keyMetrics.baseSizeX)
            CustomizeKeyView_to(.function_keys(.f2), displayKeySize: keyMetrics.baseSizeX)
            CustomizeKeyView_to(.function_keys(.f3), displayKeySize: keyMetrics.baseSizeX)
            CustomizeKeyView_to(.function_keys(.f4), displayKeySize: keyMetrics.baseSizeX)
            CustomizeKeyView_to(.function_keys(.f5), displayKeySize: keyMetrics.baseSizeX)
            CustomizeKeyView_to(.function_keys(.f6), displayKeySize: keyMetrics.baseSizeX)
            CustomizeKeyView_to(.function_keys(.f7), displayKeySize: keyMetrics.baseSizeX)
            CustomizeKeyView_to(.function_keys(.f8), displayKeySize: keyMetrics.baseSizeX)
            CustomizeKeyView_to(.function_keys(.f9), displayKeySize: keyMetrics.baseSizeX)
            CustomizeKeyView_to(.function_keys(.f10), displayKeySize: keyMetrics.baseSizeX)
            CustomizeKeyView_to(.function_keys(.f11), displayKeySize: keyMetrics.baseSizeX)
            CustomizeKeyView_to(.function_keys(.f12), displayKeySize: keyMetrics.baseSizeX)
            CustomizeKeyView_to(.media_controls(.lock_key_on_magic_keyboard_without_touch_id), displayKeySize: keyMetrics.baseSizeX)
            
        }
    }
    private var arrows: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_to(.function_keys(.f13), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.function_keys(.f14), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.function_keys(.f15), displayKeySize: keyMetrics.baseSizeX)
            }
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_to(.keys_in_pc_keyboards(.insert), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.arrow_keys(.home), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.arrow_keys(.page_up), displayKeySize: keyMetrics.baseSizeX)
            }
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_to(.controls_and_symbols(.delete_forward), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.arrow_keys(.end), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.arrow_keys(.page_down), displayKeySize: keyMetrics.baseSizeX)
            }
            HStack(alignment: .top, spacing: 0) {
                // ここはスペーサー
                spacer1u
                spacer1u
                spacer1u
            }
            HStack(alignment: .top, spacing: 0) {
                spacer1u
                CustomizeKeyView_to(.arrow_keys(.up_arrow), displayKeySize: keyMetrics.baseSizeX)
                spacer1u
            }
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_to(.arrow_keys(.left_arrow), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.arrow_keys(.down_arrow), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.arrow_keys(.right_arrow), displayKeySize: keyMetrics.baseSizeX)
            }
        }
    }
    private func tenkey(isJIS: Bool) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_to(.function_keys(.f16), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.function_keys(.f17), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.function_keys(.f18), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.function_keys(.f19), displayKeySize: keyMetrics.baseSizeX)
            }
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_to(.letter_keys(.a), displayKeySize: keyMetrics.baseSizeX)// clear
                CustomizeKeyView_to(.keypad_keys(.keypad_equal_sign), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.keypad_keys(.keypad_slash), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.keypad_keys(.keypad_asterisk), displayKeySize: keyMetrics.baseSizeX)
            }
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_to(.keypad_keys(.keypad_7), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.keypad_keys(.keypad_8), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.keypad_keys(.keypad_9), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.keypad_keys(.keypad_hyphen), displayKeySize: keyMetrics.baseSizeX)
            }
            HStack(alignment: .top, spacing: 0) {
                CustomizeKeyView_to(.keypad_keys(.keypad_4), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.keypad_keys(.keypad_5), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.keypad_keys(.keypad_6), displayKeySize: keyMetrics.baseSizeX)
                CustomizeKeyView_to(.keypad_keys(.keypad_plus), displayKeySize: keyMetrics.baseSizeX)
            }
            HStack(alignment: .top, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .top, spacing: 0) {
                        CustomizeKeyView_to(.keypad_keys(.keypad_1), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.keypad_keys(.keypad_2), displayKeySize: keyMetrics.baseSizeX)
                        CustomizeKeyView_to(.keypad_keys(.keypad_3), displayKeySize: keyMetrics.baseSizeX)
                    }
                    HStack(alignment: .top, spacing: 0) {
                        if isJIS {
                            CustomizeKeyView_to(.keypad_keys(.keypad_0), displayKeySize: keyMetrics.baseSizeX)
                            CustomizeKeyView_to(.keypad_keys(.keypad_comma), displayKeySize: keyMetrics.baseSizeX)
                            CustomizeKeyView_to(.keypad_keys(.keypad_period), displayKeySize: keyMetrics.baseSizeX)
                        } else {
                            CustomizeKeyView_to(.keypad_keys(.keypad_0), unitSize: 2, displayKeySize: keyMetrics.baseSizeX)
                            CustomizeKeyView_to(.keypad_keys(.keypad_period), displayKeySize: keyMetrics.baseSizeX)
                        }
                    }
                }
                CustomizeKeyView_to(.keypad_keys(.keypad_enter), keyShape: .enter_Tenkey, displayKeySize: keyMetrics.baseSizeX)
            }
        }
    }
    private var spacer1u: some View {
        Spacer()
            .frame(width: keyMetrics.frameWidth, height: keyMetrics.frameWidth)
    }
}
