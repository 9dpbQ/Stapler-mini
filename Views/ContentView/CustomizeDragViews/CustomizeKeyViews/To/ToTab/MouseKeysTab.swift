//
//  MouseKeysTab.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/09.
//
import SwiftUI

struct MouseKeysTab_to: View {
    @EnvironmentObject private var viewModel: ViewModel
    private var keyMetrics: KeyMetrics {
        KeyMetrics(unitSize: 1.0, baseSizeX: viewModel.configuration.displayKeySize)
    }
    var body: some View {
        List {
            Section("Mouse buttons") {
                HStack(spacing: 0) { // Mouse Buttons 14個ずつ
                    CustomizeKeyView_to(.mouse_buttons(.button1))
                    CustomizeKeyView_to(.mouse_buttons(.button2))
                    CustomizeKeyView_to(.mouse_buttons(.button3))
                    CustomizeKeyView_to(.mouse_buttons(.button4))
                    CustomizeKeyView_to(.mouse_buttons(.button5))
                    CustomizeKeyView_to(.mouse_buttons(.button6))
                    CustomizeKeyView_to(.mouse_buttons(.button7))
                    CustomizeKeyView_to(.mouse_buttons(.button8))
                    CustomizeKeyView_to(.mouse_buttons(.button9))
                    CustomizeKeyView_to(.mouse_buttons(.button10))
                }
                HStack(spacing: 0) {
                    CustomizeKeyView_to(.mouse_buttons(.button11))
                    CustomizeKeyView_to(.mouse_buttons(.button12))
                    CustomizeKeyView_to(.mouse_buttons(.button13))
                    CustomizeKeyView_to(.mouse_buttons(.button14))
                    CustomizeKeyView_to(.mouse_buttons(.button15))
                    CustomizeKeyView_to(.mouse_buttons(.button16))
                    CustomizeKeyView_to(.mouse_buttons(.button17))
                    CustomizeKeyView_to(.mouse_buttons(.button18))
                    CustomizeKeyView_to(.mouse_buttons(.button19))
                    CustomizeKeyView_to(.mouse_buttons(.button20))
                }
                HStack(spacing: 0) {
                    CustomizeKeyView_to(.mouse_buttons(.button21))
                    CustomizeKeyView_to(.mouse_buttons(.button22))
                    CustomizeKeyView_to(.mouse_buttons(.button23))
                    CustomizeKeyView_to(.mouse_buttons(.button24))
                    CustomizeKeyView_to(.mouse_buttons(.button25))
                    CustomizeKeyView_to(.mouse_buttons(.button26))
                    CustomizeKeyView_to(.mouse_buttons(.button27))
                    CustomizeKeyView_to(.mouse_buttons(.button28))
                    CustomizeKeyView_to(.mouse_buttons(.button29))
                    CustomizeKeyView_to(.mouse_buttons(.button30))
                    CustomizeKeyView_to(.mouse_buttons(.button31))
                    CustomizeKeyView_to(.mouse_buttons(.button32))
                }
            }
            Section("Cursor Move") {
                HStack { // mouse Cursor Move
                    VStack(spacing: 0) {
                        CustomizeKeyView_to(.mouse_keys(.mouse_up_slow))
                        HStack(spacing: 0) {
                            CustomizeKeyView_to(.mouse_keys(.mouse_left_slow))
                            CustomizeKeyView_to(.mouse_keys(.mouse_down_slow))
                            CustomizeKeyView_to(.mouse_keys(.mouse_right_slow))
                        }
                    }
                    
                    VStack(spacing: 0) {
                        CustomizeKeyView_to(.mouse_keys(.mouse_up))
                        HStack(spacing: 0) {
                            CustomizeKeyView_to(.mouse_keys(.mouse_left))
                            CustomizeKeyView_to(.mouse_keys(.mouse_down))
                            CustomizeKeyView_to(.mouse_keys(.mouse_right))
                        }
                    }
                    VStack(spacing: 0) {
                        CustomizeKeyView_to(.mouse_keys(.mouse_up_fast))
                        HStack(spacing: 0) {
                            CustomizeKeyView_to(.mouse_keys(.mouse_left_fast))
                            CustomizeKeyView_to(.mouse_keys(.mouse_down_fast))
                            CustomizeKeyView_to(.mouse_keys(.mouse_right_fast))
                        }
                    }
                }
            }
            Section("Scroll") {
                HStack { // Scroll
                    VStack(spacing: 0) {
                        CustomizeKeyView_to(.mouse_keys(.scroll_up_slow))
                        HStack(spacing: 0) {
                            CustomizeKeyView_to(.mouse_keys(.scroll_left_slow))
                            CustomizeKeyView_to(.mouse_keys(.scroll_down_slow))
                            CustomizeKeyView_to(.mouse_keys(.scroll_right_slow))
                        }
                    }
                    VStack(spacing: 0) {
                        CustomizeKeyView_to(.mouse_keys(.scroll_up))
                        HStack(spacing: 0) {
                            CustomizeKeyView_to(.mouse_keys(.scroll_left))
                            CustomizeKeyView_to(.mouse_keys(.scroll_down))
                            CustomizeKeyView_to(.mouse_keys(.scroll_right))
                        }
                    }
                    VStack(spacing: 0) {
                        CustomizeKeyView_to(.mouse_keys(.scroll_up_fast))
                        HStack(spacing: 0) {
                            CustomizeKeyView_to(.mouse_keys(.scroll_left_fast))
                            CustomizeKeyView_to(.mouse_keys(.scroll_down_fast))
                            CustomizeKeyView_to(.mouse_keys(.scroll_right_fast))
                        }
                    }
                }
            }
            Section("Speed Multiplier") {
                HStack(spacing: 0) { // Speed Multiplier
                    CustomizeKeyView_to(.mouse_keys(.speed_multiplier0125))
                    CustomizeKeyView_to(.mouse_keys(.speed_multiplier025))
                    CustomizeKeyView_to(.mouse_keys(.speed_multiplier05))
                    CustomizeKeyView_to(.mouse_keys(.speed_multiplier2))
                }
            }
           
            Section("Double Click") {
                HStack(spacing: 0) { // Double Click
                    CustomizeKeyView_to(.software_function(.CGEvent_double_click_left))
                    CustomizeKeyView_to(.software_function(.CGEvent_double_click_right))
                    CustomizeKeyView_to(.software_function(.CGEvent_double_click_center))
                }
            }
            Section("Set Mouse Cursor Position") {
                HStack(spacing: 0) { // Set Mouse Cursor Position
                    CustomizeKeyView_to(.software_function(.set_mouse_cursor_position_to_origin_of_the_first_screen))
                    CustomizeKeyView_to(.software_function(.set_mouse_cursor_position_to_center_of_the_first_screen))
                    CustomizeKeyView_to(.software_function(.set_mouse_cursor_position_to_origin_of_the_second_screen))
                    CustomizeKeyView_to(.software_function(.set_mouse_cursor_position_to_center_of_the_second_screen))
                    // 増やしても良いかもね。キーコードないの数字を変えればできそうな予感。要検証。
                }
            }
        }
        .scrollContentBackground(.hidden)
    }

}
