//
//  SymbolsTab.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/09.
//
import SwiftUI

struct SymbolsTab_to: View {
    @EnvironmentObject private var viewModel: ViewModel
    private var keyMetrics: KeyMetrics {
        KeyMetrics(unitSize: 1.0, baseSizeX: viewModel.configuration.displayKeySize)
    }
    var body: some View {
        List {
            Section("Punctuation mark") {
                HStack(spacing: 0) { // Bracket
                    CustomizeKeyView_to(.controls_and_symbols(.open_square_bracket))
                    CustomizeKeyView_to(.controls_and_symbols(.close_square_bracket))
                    CustomizeKeyView_to(.shift_symbols(.open_curly_bracket))
                    CustomizeKeyView_to(.shift_symbols(.close_curly_bracket))
                    CustomizeKeyView_to(.shift_symbols(.open_parenthesis))
                    CustomizeKeyView_to(.shift_symbols(.close_parenthesis))
                    CustomizeKeyView_to(.shift_symbols(.less_than))
                    CustomizeKeyView_to(.shift_symbols(.greater_than))
                }
                HStack(spacing: 0) { // Quotation
                    CustomizeKeyView_to(.controls_and_symbols(.single_quotation))
                    CustomizeKeyView_to(.shift_symbols(.double_quotation))
                    
                    CustomizeKeyView_to(.option_symbols(.left_single_quotation_mark))
                    CustomizeKeyView_to(.shift_option_symbols(.right_single_quotation_mark))
                    
                    CustomizeKeyView_to(.option_symbols(.left_double_quotation_mark))
                    CustomizeKeyView_to(.shift_option_symbols(.right_double_quotation_mark))
                    
                    CustomizeKeyView_to(.shift_option_symbols(.single_left_pointing_angle_quotation_mark))
                    CustomizeKeyView_to(.shift_option_symbols(.single_right_pointing_angle_quotation_mark))
                    
                    CustomizeKeyView_to(.shift_option_symbols(.single_low_9_quotation_mark))
                    CustomizeKeyView_to(.shift_option_symbols(.double_low_9_quotation_mark))
                }
                HStack(spacing: 0) { // 約物・感嘆など
                    CustomizeKeyView_to(.shift_symbols(.ampersand))
                    CustomizeKeyView_to(.controls_and_symbols(.section))
                    CustomizeKeyView_to(.option_symbols(.pilcrow))
                    CustomizeKeyView_to(.option_symbols(.bullet))
                    CustomizeKeyView_to(.option_symbols(.feminine_ordinal_indicator))
                    CustomizeKeyView_to(.option_symbols(.masculine_ordinal_indicator))
                    
                    CustomizeKeyView_to(.option_symbols(.copy_right))
                    CustomizeKeyView_to(.shift_symbols(.commercial_at))
                    CustomizeKeyView_to(.option_symbols(.trade_mark))
                    CustomizeKeyView_to(.option_symbols(.registered_trademark))
                }
                HStack(spacing: 0) {
                    CustomizeKeyView_to(.controls_and_symbols(.semicolon))
                    CustomizeKeyView_to(.shift_symbols(.colon))
                    
                    CustomizeKeyView_to(.controls_and_symbols(.comma))
                    CustomizeKeyView_to(.controls_and_symbols(.period))
                    CustomizeKeyView_to(.option_symbols(.holizontal_ellipsis))
                    
                    CustomizeKeyView_to(.shift_symbols(.exclamation))
                    CustomizeKeyView_to(.option_symbols(.inverted_exclamation))
                    
                    CustomizeKeyView_to(.shift_symbols(.question))
                    CustomizeKeyView_to(.shift_option_symbols(.inverted_question_mark))
                }
            }
            
            Section("Programing") {
                HStack(spacing: 0) {
                    // 算術演算子
                    CustomizeKeyView_to(.controls_and_symbols(.hyphen))
                    CustomizeKeyView_to(.shift_symbols(.plus))
                    CustomizeKeyView_to(.shift_symbols(.percent))
                    CustomizeKeyView_to(.shift_symbols(.asterisk))
                    CustomizeKeyView_to(.controls_and_symbols(.slash))
                    
                    // 比較、論理演算子
                    CustomizeKeyView_to(.controls_and_symbols(.equal_sign))
                    CustomizeKeyView_to(.shift_symbols(.exclamation))
                    CustomizeKeyView_to(.shift_symbols(.vertical_bar))
                    CustomizeKeyView_to(.shift_symbols(.ampersand))
                    CustomizeKeyView_to(.shift_symbols(.less_than))
                    CustomizeKeyView_to(.shift_symbols(.greater_than))
                }
                HStack(spacing: 0) {
                    CustomizeKeyView_to(.controls_and_symbols(.slash))
                    CustomizeKeyView_to(.controls_and_symbols(.backslash))
                    CustomizeKeyView_to(.controls_and_symbols(.open_square_bracket))
                    CustomizeKeyView_to(.controls_and_symbols(.close_square_bracket))
                    CustomizeKeyView_to(.shift_symbols(.open_curly_bracket))
                    CustomizeKeyView_to(.shift_symbols(.close_curly_bracket))
                    CustomizeKeyView_to(.shift_symbols(.open_parenthesis))
                    CustomizeKeyView_to(.shift_symbols(.close_parenthesis))
                    
                    CustomizeKeyView_to(.shift_symbols(.question))
                    CustomizeKeyView_to(.controls_and_symbols(.semicolon))
                    CustomizeKeyView_to(.shift_symbols(.colon))
                    CustomizeKeyView_to(.shift_symbols(.dollar))
                    
                    CustomizeKeyView_to(.shift_symbols(.caret)) // ^
                    CustomizeKeyView_to(.shift_symbols(.tilde)) // ~
                }
            }
            
            Section("Unit") {
                HStack(spacing: 0) { // 単位
                    CustomizeKeyView_to(.shift_symbols(.dollar))
                    CustomizeKeyView_to(.option_symbols(.cent))
                    CustomizeKeyView_to(.option_symbols(.pound))
                    CustomizeKeyView_to(.option_symbols(.yen_or_backslash))
                    CustomizeKeyView_to(.option_symbols(.backslash_or_yen))
                    
                    CustomizeKeyView_to(.option_symbols(.angstrom))
                    CustomizeKeyView_to(.option_symbols(.f_with_hook))
                    CustomizeKeyView_to(.option_symbols(.omega))
                    CustomizeKeyView_to(.shift_option_symbols(.euro))
                    
                    CustomizeKeyView_to(.shift_option_symbols(.degree))
                }
            }
            
            Section("Math") {
                HStack(spacing: 0) { // 数学
                    CustomizeKeyView_to(.controls_and_symbols(.hyphen))
                    CustomizeKeyView_to(.shift_symbols(.plus))
                    CustomizeKeyView_to(.shift_option_symbols(.plus_minus))
                    
                    CustomizeKeyView_to(.controls_and_symbols(.slash))
                    CustomizeKeyView_to(.shift_symbols(.asterisk))
                    CustomizeKeyView_to(.shift_symbols(.percent))
                    
                    CustomizeKeyView_to(.shift_symbols(.caret))
                    CustomizeKeyView_to(.shift_symbols(.exclamation))
                }
                HStack(spacing: 0) {
                    CustomizeKeyView_to(.controls_and_symbols(.equal_sign))
                    CustomizeKeyView_to(.option_symbols(.not_equal))
                    CustomizeKeyView_to(.option_symbols(.almost_equal))
                    
                    CustomizeKeyView_to(.shift_symbols(.less_than))
                    CustomizeKeyView_to(.shift_symbols(.greater_than))
                    CustomizeKeyView_to(.option_symbols(.less_than_or_equal_to))
                    CustomizeKeyView_to(.option_symbols(.greater_than_or_equal_to))
                    
                    CustomizeKeyView_to(.option_symbols(.sigma))
                    CustomizeKeyView_to(.option_symbols(.pi))
                    CustomizeKeyView_to(.option_symbols(.delta))
                    CustomizeKeyView_to(.option_symbols(.square_root))
                    CustomizeKeyView_to(.option_symbols(.curly_d))
                }
            }
            
            Section("Ligature and Accent") {
                HStack(spacing: 0) { // Ligature and Accent
                    // アクセント記号？
                    CustomizeKeyView_to(.shift_option_symbols(.caron))
                    CustomizeKeyView_to(.shift_option_symbols(.macron))
                    CustomizeKeyView_to(.shift_option_symbols(.breve))
                    
                    CustomizeKeyView_to(.option_symbols(.eszett))
                    
                    // 合字
                    CustomizeKeyView_to(.option_symbols(.oe_ligature))
                    CustomizeKeyView_to(.shift_option_symbols(.capital_oe_ligature))
                    
                    CustomizeKeyView_to(.option_symbols(.o_with_stroke))
                    CustomizeKeyView_to(.shift_option_symbols(.capital_o_with_stroke))
                    
                    CustomizeKeyView_to(.option_symbols(.ae_ligature))
                    CustomizeKeyView_to(.shift_option_symbols(.capital_ae_ligature))
                    
                    CustomizeKeyView_to(.option_symbols(.ae_ligature))
                    CustomizeKeyView_to(.shift_option_symbols(.capital_ae_ligature))
                    
                    CustomizeKeyView_to(.shift_option_symbols(.fi_ligature))
                    CustomizeKeyView_to(.shift_option_symbols(.fl_ligature))
                }
                HStack(spacing: 0) { // 表音記号
                    CustomizeKeyView_to(.option_symbols(.grave_accent))
                    CustomizeKeyView_to(.shift_option_symbols(.only_grave_accent))
                    CustomizeKeyView_to(.shift_option_symbols(.capital_o_with_grave))
                    
                    CustomizeKeyView_to(.option_symbols(.acute_accent))
                    CustomizeKeyView_to(.shift_option_symbols(.double_acute_accent))
                    CustomizeKeyView_to(.shift_option_symbols(.capital_a_acute))
                    CustomizeKeyView_to(.shift_option_symbols(.capital_u_with_acute))
                    CustomizeKeyView_to(.shift_option_symbols(.capital_o_with_acute_accent))
                }
                HStack(spacing: 0) {
                    CustomizeKeyView_to(.option_symbols(.diaeresis))
                    CustomizeKeyView_to(.shift_option_symbols(.only_diaeresis))
                    CustomizeKeyView_to(.shift_option_symbols(.capital_i_with_diaeresis))
                    
                    CustomizeKeyView_to(.option_symbols(.circumflex))
                    CustomizeKeyView_to(.shift_option_symbols(.only_circumflex))
                    CustomizeKeyView_to(.shift_option_symbols(.capital_a_with_circumflex))
                    CustomizeKeyView_to(.shift_option_symbols(.capital_i_with_circumflex))
                    CustomizeKeyView_to(.shift_option_symbols(.capital_o_with_circumflex))
                    
                    CustomizeKeyView_to(.option_symbols(.small_tilde))
                    CustomizeKeyView_to(.shift_option_symbols(.only_small_tilde))
                }
            }
            
                
        }
            
        .scrollContentBackground(.hidden)
    }
}
