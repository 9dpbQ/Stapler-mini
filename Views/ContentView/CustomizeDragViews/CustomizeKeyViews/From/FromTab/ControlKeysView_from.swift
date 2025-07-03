//
//  LayerAndModifierKeys.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/03/19.
//


//
//  LayerAndModifierKeys.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/09.
//

import SwiftUI

struct ControlKeys_from: View {
    @EnvironmentObject private var viewModel: ViewModel
    private var keyMetrics: KeyMetrics {
        KeyMetrics(unitSize: 1.0, baseSizeX: viewModel.configuration.displayKeySize)
    }

    var body: some View {
        List {
            Section("Text Control") {
                HStack(spacing: 0) { // textcontrol
                    CustomizeKeyView_from(.controls_and_symbols(.return_or_enter))
                    CustomizeKeyView_from(.controls_and_symbols(.escape))
                    CustomizeKeyView_from(.controls_and_symbols(.delete_or_backspace))
                    CustomizeKeyView_from(.controls_and_symbols(.delete_forward))
                    CustomizeKeyView_from(.controls_and_symbols(.tab))
                    CustomizeKeyView_from(.controls_and_symbols(.spacebar))
                    
                    
                    CustomizeKeyView_from(.media_controls(.lock_key_on_magic_keyboard_without_touch_id)) // koko?
                }
            }
            Section("Arrow") {
                HStack(spacing: 0) { // arrows
                    CustomizeKeyView_from(.arrow_keys(.up_arrow))
                    CustomizeKeyView_from(.arrow_keys(.down_arrow))
                    CustomizeKeyView_from(.arrow_keys(.left_arrow))
                    CustomizeKeyView_from(.arrow_keys(.right_arrow))
                    CustomizeKeyView_from(.arrow_keys(.page_up))
                    CustomizeKeyView_from(.arrow_keys(.page_down))
                    CustomizeKeyView_from(.arrow_keys(.home))
                    CustomizeKeyView_from(.arrow_keys(.end))
                }
            }
            
            Section("Japanese") {
                HStack(spacing: 0) { // Japanese
                    CustomizeKeyView_from(.japanese(.eisuu))
                    CustomizeKeyView_from(.japanese(.kana))
                    CustomizeKeyView_from(.japanese(.pc_henkan))
                    CustomizeKeyView_from(.japanese(.pc_mu_henkan))
                    CustomizeKeyView_from(.japanese(.pc_kana))
                }
            }
            Section("PC Keyboard Control") {
                HStack(spacing: 0) {
                    CustomizeKeyView_from(.keys_in_pc_keyboards(.print_screen))
                    CustomizeKeyView_from(.keys_in_pc_keyboards(.scroll_lock))
                    CustomizeKeyView_from(.keys_in_pc_keyboards(.pause))
                    CustomizeKeyView_from(.keys_in_pc_keyboards(.insert))
                    CustomizeKeyView_from(.keys_in_pc_keyboards(.application))
                    CustomizeKeyView_from(.keys_in_pc_keyboards(.help))
                    CustomizeKeyView_from(.keys_in_pc_keyboards(.power))
                    CustomizeKeyView_from(.keys_in_pc_keyboards(.execute))
                    
                }
                HStack(spacing: 0) {
                    CustomizeKeyView_from(.keys_in_pc_keyboards(.menu))
                    CustomizeKeyView_from(.keys_in_pc_keyboards(.select))
                    CustomizeKeyView_from(.keys_in_pc_keyboards(.stop))
                    CustomizeKeyView_from(.keys_in_pc_keyboards(.again))
                    CustomizeKeyView_from(.keys_in_pc_keyboards(.undo))
                    CustomizeKeyView_from(.keys_in_pc_keyboards(.cut))
                    CustomizeKeyView_from(.keys_in_pc_keyboards(.copy))
                    CustomizeKeyView_from(.keys_in_pc_keyboards(.paste))
                    CustomizeKeyView_from(.keys_in_pc_keyboards(.find))
                }
            }
            
            Section("Sound") {
                HStack(spacing: 0) { // Sound
                    CustomizeKeyView_from(.media_controls(.rewind))
                    CustomizeKeyView_from(.media_controls(.play_or_pause))
                    CustomizeKeyView_from(.media_controls(.fast_forward))
                    CustomizeKeyView_from(.media_controls(.mute))
                    CustomizeKeyView_from(.media_controls(.volume_decrement))
                    CustomizeKeyView_from(.media_controls(.volume_incremnt))
                    CustomizeKeyView_from(.media_controls(.eject))
                }
                HStack(spacing: 0) {
                    CustomizeKeyView_from(.media_controls(.scan_previous_track))
                    CustomizeKeyView_from(.media_controls(.scan_next_track))
                    CustomizeKeyView_from(.media_controls(.stop))
                    CustomizeKeyView_from(.media_controls(.bass_boost))
                    CustomizeKeyView_from(.media_controls(.loudness))
                    CustomizeKeyView_from(.media_controls(.bass_decrement))
                    CustomizeKeyView_from(.media_controls(.bass_increment))
                }
            }
            
            Section("Light") {
                HStack(spacing: 0) { // Light
                    CustomizeKeyView_from(.media_controls(.brightness_down))
                    CustomizeKeyView_from(.media_controls(.brightness_up))
                }
            }
            Section("D Pad") {
                HStack(spacing: 0) { // Dpad
                    CustomizeKeyView_from(.D_pad(.dpad_up))
                    CustomizeKeyView_from(.D_pad(.dpad_down))
                    CustomizeKeyView_from(.D_pad(.dpad_left))
                    CustomizeKeyView_from(.D_pad(.dpad_right))
                }
            }
            
            Section("Application Launch") {
                HStack(spacing: 0) { // applicationLaunch
                    CustomizeKeyView_from(.application_launch_keys(.al_consumer_control_configuration))
                    CustomizeKeyView_from(.application_launch_keys(.al_word_processor))
                    CustomizeKeyView_from(.application_launch_keys(.al_text_editor))
                    CustomizeKeyView_from(.application_launch_keys(.al_spreadsheet))
                    CustomizeKeyView_from(.application_launch_keys(.al_presentation_app))
                    CustomizeKeyView_from(.application_launch_keys(.al_email_reader))
                    CustomizeKeyView_from(.application_launch_keys(.al_calculator))
                    CustomizeKeyView_from(.application_launch_keys(.al_local_machine_browser))
                    CustomizeKeyView_from(.application_launch_keys(.al_internet_browser))
                    CustomizeKeyView_from(.application_launch_keys(.al_dictionary))
                }
            }
            
            Section("Generic GUI Application Control"){
                HStack(spacing: 0) { // GenericGUIApplicationControl
                    CustomizeKeyView_from(.generic_GUI_application_control_keys(.ac_search))
                    CustomizeKeyView_from(.generic_GUI_application_control_keys(.ac_home))
                    CustomizeKeyView_from(.generic_GUI_application_control_keys(.ac_back))
                    CustomizeKeyView_from(.generic_GUI_application_control_keys(.ac_forward))
                    CustomizeKeyView_from(.generic_GUI_application_control_keys(.ac_refresh))
                    CustomizeKeyView_from(.generic_GUI_application_control_keys(.ac_bookmarks))
                    CustomizeKeyView_from(.generic_GUI_application_control_keys(.ac_zoom_out))
                    CustomizeKeyView_from(.generic_GUI_application_control_keys(.ac_zoom_in))
                }
            }
            Section("Remote Controls Button") {
                HStack(spacing: 0) {
                    CustomizeKeyView_from(.remote_control_buttons(.menu_pick))
                    CustomizeKeyView_from(.remote_control_buttons(.menu_up))
                    CustomizeKeyView_from(.remote_control_buttons(.menu_down))
                    CustomizeKeyView_from(.remote_control_buttons(.menu_left))
                    CustomizeKeyView_from(.remote_control_buttons(.menu_right))
                    CustomizeKeyView_from(.remote_control_buttons(.menu_escape))
                    CustomizeKeyView_from(.remote_control_buttons(.menu_value_increase))
                    CustomizeKeyView_from(.remote_control_buttons(.menu_value_decrease))
                    CustomizeKeyView_from(.remote_control_buttons(.data_on_screen))
                    CustomizeKeyView_from(.remote_control_buttons(.closed_caption))
                    CustomizeKeyView_from(.remote_control_buttons(.closed_caption_select))
                }
                HStack(spacing: 0) {
                    CustomizeKeyView_from(.remote_control_buttons(.vcr_or_tv))
                    CustomizeKeyView_from(.remote_control_buttons(.broadcast_mode))
                    CustomizeKeyView_from(.remote_control_buttons(.snapshot))
                    CustomizeKeyView_from(.remote_control_buttons(.still))
                    CustomizeKeyView_from(.remote_control_buttons(.picture_in_picture_toggle))
                    CustomizeKeyView_from(.remote_control_buttons(.picture_in_picture_swap))
                    CustomizeKeyView_from(.remote_control_buttons(.red_menu_button))
                    CustomizeKeyView_from(.remote_control_buttons(.green_menu_button))
                    CustomizeKeyView_from(.remote_control_buttons(.yellow_menu_button))
                    CustomizeKeyView_from(.remote_control_buttons(.aspect))
                    CustomizeKeyView_from(.remote_control_buttons(.three_dimensional_mode_select))
                }
            }
            
            Section("Generic Desktop Key") {
                HStack(spacing: 0) { // generic desktop keys
                    CustomizeKeyView_from(.generic_desktop_keys(.system_sleep))
                }
            }
            
            Section("Others") {
                HStack(spacing: 0) {
                    CustomizeKeyView_from(.others(.keypad_qual_sign_as400))
                    CustomizeKeyView_from(.others(.locking_caps_lock))
                    CustomizeKeyView_from(.others(.locking_num_lock))
                    CustomizeKeyView_from(.others(.locking_scroll_lock))
                    CustomizeKeyView_from(.others(.alternate_erase))
                    CustomizeKeyView_from(.others(.sys_req_or_attention))
                    CustomizeKeyView_from(.others(.cancel))
                    CustomizeKeyView_from(.others(.clear))
                    CustomizeKeyView_from(.others(.prior))
                    CustomizeKeyView_from(.others(.rarely_used_return))
                    
                }
                HStack(spacing: 0) {
                    CustomizeKeyView_from(.others(.separator))
                    CustomizeKeyView_from(.others(.out))
                    CustomizeKeyView_from(.others(.oper))
                    CustomizeKeyView_from(.others(.clear_or_again))
                    CustomizeKeyView_from(.others(.cr_sel_or_props))
                    CustomizeKeyView_from(.others(.ex_sel))
                    CustomizeKeyView_from(.others(.fastforward))
                    CustomizeKeyView_from(.others(.mute))
                    CustomizeKeyView_from(.others(.volume_decrement))
                    CustomizeKeyView_from(.others(.volume_increment))
                    CustomizeKeyView_from(.others(.fn))
                }
            }
            
        }
        .scrollContentBackground(.hidden)
    }
}
