//
//  ControlKeysTab.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/09.
//
import SwiftUI

struct ControlKeysTab_to: View {
    @EnvironmentObject private var viewModel: ViewModel
    private var keyMetrics: KeyMetrics {
        KeyMetrics(unitSize: 1.0, baseSizeX: viewModel.configuration.displayKeySize)
    }
    
    var body: some View {
        List {
            Section("Text Control") {
                HStack(spacing: 0) { // Text
                    CustomizeKeyView_to(.controls_and_symbols(.return_or_enter))
                    CustomizeKeyView_to(.controls_and_symbols(.escape))
                    CustomizeKeyView_to(.controls_and_symbols(.delete_or_backspace))
                    CustomizeKeyView_to(.controls_and_symbols(.delete_forward))
                    CustomizeKeyView_to(.controls_and_symbols(.tab))
                    CustomizeKeyView_to(.controls_and_symbols(.spacebar))
                }
            }
            Section("Arrow") {
                HStack(spacing: 0) { // Arrows
                    CustomizeKeyView_to(.arrow_keys(.up_arrow))
                    CustomizeKeyView_to(.arrow_keys(.down_arrow))
                    CustomizeKeyView_to(.arrow_keys(.left_arrow))
                    CustomizeKeyView_to(.arrow_keys(.right_arrow))
                    CustomizeKeyView_to(.arrow_keys(.page_up))
                    CustomizeKeyView_to(.arrow_keys(.page_down))
                    CustomizeKeyView_to(.arrow_keys(.home))
                    CustomizeKeyView_to(.arrow_keys(.end))
                }
            }
            Section("System Control") {
                HStack(spacing: 0) { // System
                    CustomizeKeyView_to(.media_controls(.mission_control))
                    CustomizeKeyView_to(.media_controls(.spotlight))
                    CustomizeKeyView_to(.media_controls(.dictation))
                    CustomizeKeyView_to(.media_controls(.launchpad))
                    CustomizeKeyView_to(.media_controls(.dashboard))
                    CustomizeKeyView_to(.media_controls(.lock_key_on_magic_keyboard_without_touch_id))
                    CustomizeKeyView_to(.software_function(.sleep))
                    CustomizeKeyView_to(.media_controls(.eject))
                    CustomizeKeyView_to(.japanese(.eisuu))
                    CustomizeKeyView_to(.japanese(.kana))
                    CustomizeKeyView_to(.international_keys(.lang1))
                    CustomizeKeyView_to(.international_keys(.lang2))
                }
            }
            Section("Sound") {
                HStack(spacing: 0) { // sound
                    CustomizeKeyView_to(.media_controls(.rewind))
                    CustomizeKeyView_to(.media_controls(.play_or_pause))
                    CustomizeKeyView_to(.media_controls(.fast_forward))
                    CustomizeKeyView_to(.media_controls(.mute))
                    CustomizeKeyView_to(.media_controls(.volume_decrement))
                    CustomizeKeyView_to(.media_controls(.volume_incremnt))
                    CustomizeKeyView_to(.media_controls(.scan_previous_track))
                    CustomizeKeyView_to(.media_controls(.scan_next_track))
                }
            }
            Section("Light") {
                HStack(spacing: 0) { // Light
                    CustomizeKeyView_to(.media_controls(.display_brightness_decrement))
                    CustomizeKeyView_to(.media_controls(.display_brightness_increment))
                    CustomizeKeyView_to(.media_controls(.illumination_up))
                    CustomizeKeyView_to(.media_controls(.illumination_down))
                    CustomizeKeyView_to(.media_controls(.brightness_down))
                    CustomizeKeyView_to(.media_controls(.brightness_up))
                }
            }
            Section("Application Launch") {
                HStack(spacing: 0) { // Application Launch
                    CustomizeKeyView_to(.application_launch_keys(.al_consumer_control_configuration))
                    CustomizeKeyView_to(.application_launch_keys(.al_word_processor))
                    CustomizeKeyView_to(.application_launch_keys(.al_text_editor))
                    CustomizeKeyView_to(.application_launch_keys(.al_spreadsheet))
                    CustomizeKeyView_to(.application_launch_keys(.al_presentation_app))
                    CustomizeKeyView_to(.application_launch_keys(.al_email_reader))
                    CustomizeKeyView_to(.application_launch_keys(.al_calculator))
                    CustomizeKeyView_to(.application_launch_keys(.al_local_machine_browser))
                    CustomizeKeyView_to(.application_launch_keys(.al_internet_browser))
                    CustomizeKeyView_to(.application_launch_keys(.al_dictionalry))
                }
            }
            Section("Others") {
                HStack(spacing: 0) { // Others
                    CustomizeKeyView_to(.others(.expose_desktop))
                    CustomizeKeyView_to(.others(.language))
                    CustomizeKeyView_to(.others(.apple_top_case_display_brightness_decrement))
                    CustomizeKeyView_to(.others(.apple_top_case_display_brightness_increment))
                    CustomizeKeyView_to(.others(.video_mirror))
                    CustomizeKeyView_to(.others(.illumination_toggle))
                    CustomizeKeyView_to(.others(.illumination_decrement))
                    CustomizeKeyView_to(.others(.illumination_increment))       
                }
            }
            
        }
        .scrollContentBackground(.hidden)
    }
}
