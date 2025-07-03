//
//  KeycodeList.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2024/12/11.
//

import Foundation

enum FromKeycode: Codable, Hashable {
    case modifier_keys(ModifierKeys)
    case controls_and_symbols(ControlsAndSymbols)
    case arrow_keys(ArrowKeys)
    case letter_keys(LetterKeys)
    case number_keys(NumberKeys)
    case function_keys(FunctionKeys)
    case media_controls(MediaControls)
    case keypad_keys(KeypadKeys)
    case keys_in_pc_keyboards(KeysInPCKeyboards)
    case international_keys(InternationalKeys)
    case japanese(Japanese)
    case mouse_buttons(MouseButtons)
    case D_pad(DPad)
    case application_launch_keys(ApplicationLaunchKeys)
    case generic_GUI_application_control_keys(GenericGUIApplicationControlKeys)
    case remote_control_buttons(RemoteControlButtons)
    case generic_desktop_keys(GenericDesktopKeys)
    case others(Others)
    
    func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
        switch self {
        case .modifier_keys(let modifierKeys):
            modifierKeys.keycodeInfo(region)
        case .controls_and_symbols(let controlsAndSymbols):
            controlsAndSymbols.keycodeInfo(region)
        case .arrow_keys(let arrowKeys):
            arrowKeys.keycodeInfo(region)
        case .letter_keys(let letterKeys):
            letterKeys.keycodeInfo(region)
        case .number_keys(let numberKeys):
            numberKeys.keycodeInfo(region)
        case .function_keys(let functionKeys):
            functionKeys.keycodeInfo(region)
        case .media_controls(let mediaControls):
            mediaControls.keycodeInfo(region)
        case .keypad_keys(let keypadKeys):
            keypadKeys.keycodeInfo(region)
        case .keys_in_pc_keyboards(let keysInPCKeyboards):
            keysInPCKeyboards.keycodeInfo(region)
        case .international_keys(let internationalKeys):
            internationalKeys.keycodeInfo(region)
        case .japanese(let japanese):
            japanese.keycodeInfo(region)
        case .mouse_buttons(let mouseButtons):
            mouseButtons.keycodeInfo(region)
        case .D_pad(let dPad):
            dPad.keycodeInfo(region)
        case .application_launch_keys(let applicationLaunchKeys):
            applicationLaunchKeys.keycodeInfo(region)
        case .generic_GUI_application_control_keys(let genericDesktopKeys):
            genericDesktopKeys.keycodeInfo(region)
        case .remote_control_buttons(let remoteControlButtons):
            remoteControlButtons.keycodeInfo(region)
        case .generic_desktop_keys(let genericDesktopKeys):
            genericDesktopKeys.keycodeInfo(region)
        case .others(let others):
            others.keycodeInfo(region)
        }
    }
    func defaultDisplayString(_ region: KeycodeRegion) -> (display: String, isSFSymbol: Bool) {
        switch self {
        case .modifier_keys(let modifierKeys):
            modifierKeys.displaySymbol()
        case .controls_and_symbols(let controlsAndSymbols):
            controlsAndSymbols.displaySymbol(region)
        case .arrow_keys(let arrowKeys):
            arrowKeys.displaySymbol()
        case .letter_keys(let letterKeys):
            letterKeys.displaySymbol()
        case .number_keys(let numberKeys):
            numberKeys.displaySymbol()
        case .function_keys(let functionKeys):
            functionKeys.displaySymbol()
        case .media_controls(let mediaControls):
            mediaControls.displaySymbol()
        case .keypad_keys(let keypadKeys):
            keypadKeys.displaySymbol()
        case .keys_in_pc_keyboards(let keysInPCKeyboards):
            keysInPCKeyboards.displaySymbol()
        case .international_keys(let internationalKeys):
            internationalKeys.displaySymbol()
        case .japanese(let japanese):
            japanese.displaySymbol()
        case .mouse_buttons(let mouseButtons):
            mouseButtons.displaySymbol()
        case .D_pad(let dPad):
            dPad.displaySymbol()
        case .application_launch_keys(let applicationLaunchKeys):
            applicationLaunchKeys.displaySymbol()
        case .generic_GUI_application_control_keys(let genericDesktopKeys):
            genericDesktopKeys.displaySymbol()
        case .remote_control_buttons(let remoteControlButtons):
            remoteControlButtons.displaySymbol()
        case .generic_desktop_keys(let genericDesktopKeys):
            genericDesktopKeys.displaySymbol()
        case .others(let others):
            others.displaySymbol()
        }
    }
    enum ControlsAndSymbols: String, CaseIterable, Codable {
        case return_or_enter
        case escape
        case delete_or_backspace
        case delete_forward
        case tab
        case spacebar
        
        case hyphen // (hyphen)
        case equal_sign_or_caret // = or ^(ansi: equal_sign, iso: equal_sign, jis: equal_sign)
        case open_square_bracket // [ (ansi: open_bracket, iso: open_bracket, jis: close_bracket)
        case close_square_bracket // ] (ansi, iso: close_bracket, jis: backslash)
        case open_square_bracket_jis // jis: close_bracket
        case close_square_bracket_jis // jis: backslash
        case commercial_at_jis // @ (open_bracket)
        case backslash_or_yen //  \ (ansi: backslash, iso: non_us_pound or backslash, jis: international3)
        case semicolon // ; (semicolon)
        case single_quotation_or_colon // 'or: (ansi, iso: quote, jis: quote)
        case grave_accent // ` (ansi: grave_accent_and_tilde, iso: non_us_backslash, jis: grave_accent_and_tilde)
        case comma // , (comma)
        case period // . (priod)
        case slash // / (slash)
        case section // § (ansi: non_us_backslash, iso: grave_accent_and_tilde, jis:  non_us_backlash)
        
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            switch self {
            case .return_or_enter:
                KeycodeInfoCollection(KeycodeInfo(keyCodeString: "return_or_enter")).keycodeInfo(region)
            case .escape:
                KeycodeInfoCollection(KeycodeInfo(keyCodeString: "escape")).keycodeInfo(region)
            case .delete_or_backspace:
                KeycodeInfoCollection(KeycodeInfo(keyCodeString: "delete_or_backspace")).keycodeInfo(region)
            case .delete_forward:
                KeycodeInfoCollection(KeycodeInfo(keyCodeString: "delete_forward")).keycodeInfo(region)
            case .tab:
                KeycodeInfoCollection(KeycodeInfo(keyCodeString: "tab")).keycodeInfo(region)
            case .spacebar:
                KeycodeInfoCollection(KeycodeInfo(keyCodeString: "spacebar")).keycodeInfo(region)
            case .hyphen:
                KeycodeInfoCollection(KeycodeInfo(keyCodeString: "hyphen")).keycodeInfo(region)
            case .equal_sign_or_caret:
                KeycodeInfoCollection(KeycodeInfo(keyCodeString: "equal_sign")).keycodeInfo(region)
            case .open_square_bracket:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "open_bracket"),
                    JIS: KeycodeInfo(keyCodeString: "close_bracket")
                ).keycodeInfo(region)
            case .close_square_bracket:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "close_bracket"),
                    JIS: KeycodeInfo(keyCodeString: "backslash")
                ).keycodeInfo(region)
            case .open_square_bracket_jis:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "close_bracket")
                ).keycodeInfo(region)
            case .close_square_bracket_jis:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "backslash")
                ).keycodeInfo(region)
            case .commercial_at_jis:
                KeycodeInfo(keyCodeString: "open_bracket")
            case .backslash_or_yen:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "backslash"),
                    JIS: KeycodeInfo(keyCodeString: "international3")
                ).keycodeInfo(region)
            case .semicolon:
                KeycodeInfoCollection(KeycodeInfo(keyCodeString: "semicolon")).keycodeInfo(region)
            case .single_quotation_or_colon:
                KeycodeInfoCollection(KeycodeInfo(keyCodeString: "quote")).keycodeInfo(region)
            case .grave_accent:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "grave_accent_and_tilde"),
                    ISO: KeycodeInfo(keyCodeString: "non_us_backslash")
                ).keycodeInfo(region)
            case .comma:
                KeycodeInfoCollection(KeycodeInfo(keyCodeString: "comma")).keycodeInfo(region)
            case .period:
                KeycodeInfoCollection(KeycodeInfo(keyCodeString: "period")).keycodeInfo(region)
            case .slash:
                KeycodeInfoCollection(KeycodeInfo(keyCodeString: "slash")).keycodeInfo(region)
            case .section:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "non_us_backslash"),
                    ISO: KeycodeInfo(keyCodeString: "grave_accent_and_tilde")
                ).keycodeInfo(region)
            }
        }
        func displaySymbol(_ region: KeycodeRegion) -> (display: String, isSFSymbol: Bool) {
            switch self {
            case .return_or_enter: ("return", true)
            case .escape: ("escape", true)
            case .delete_or_backspace: ("delete.left", true)
            case .delete_forward: ("delete.right", true)
            case .tab: ("arrow.right.to.line", true)
            case .spacebar: ("␣", false)
            case .hyphen: ("-", false)
            case .equal_sign_or_caret:
                switch region {
                case .JIS: ("^", false)
                default: ("=", false)
                }
            case .open_square_bracket, .open_square_bracket_jis: ("[", false)
            case .close_square_bracket, .close_square_bracket_jis: ("]", false)
            case .commercial_at_jis: ("@", false)
            case .backslash_or_yen:
                switch region {
                case .JIS:
                    ("¥", false)
                default:
                    ("\\", false)
                }
            case .semicolon: (";", false)
            case .single_quotation_or_colon:
                switch region {
                case .JIS: (":", false)
                default: ("'", false)
                }
            case .grave_accent: ("`", false)
            case .comma: (",", false)
            case .period: (".", false)
            case .slash: ("/", false)
            case .section: ("§", false)
            }
        }
    }
    enum ArrowKeys: String, CaseIterable, Codable {
        case up_arrow
        case down_arrow
        case left_arrow
        case right_arrow
        case page_up
        case page_down
        case home
        case end
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            KeycodeInfo(keyCodeString: self.rawValue)
        }
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            switch self {
            case .up_arrow: ("arrowtriangle.up.fill", true)
            case .down_arrow: ("arrowtriangle.down.fill", true)
            case .left_arrow: ("arrowtriangle.left.fill", true)
            case .right_arrow: ("arrowtriangle.right.fill", true)
            case .page_up: ("arrow.up", true)
            case .page_down: ("arrow.down", true)
            case .home: ("arrow.up.to.line", true)
            case .end: ("arrow.down.to.line", true)
            }
        }
    }
    enum FunctionKeys: String, CaseIterable, Codable {
        case f1, f2, f3, f4, f5, f6, f7, f8
        case f9, f10, f11, f12, f13, f14, f15, f16
        case f17, f18, f19, f20, f21, f22, f23, f24
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            KeycodeInfo(keyCodeString: self.rawValue)
        }
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            (self.rawValue.capitalized, false)
        }
    }
    enum MediaControls: String, CaseIterable, Codable {
        
        case rewind, play_or_pause, fast_forward, mute, volume_decrement, volume_incremnt
        case lock_key_on_magic_keyboard_without_touch_id
        case eject
        case brightness_down, brightness_up
        case scan_previous_track, scan_next_track
        case stop
        case bass_boost, loudness, bass_decrement, bass_increment
        
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            switch self {
            case .rewind:
                KeycodeInfo(functionType: .consumer, keyCodeString: "rewind")
            case .play_or_pause:
                KeycodeInfo(functionType: .consumer, keyCodeString: "play_or_pause")
            case .fast_forward:
                KeycodeInfo(functionType: .consumer, keyCodeString: "fast_forward")
            case .mute:
                KeycodeInfo(functionType: .consumer, keyCodeString: "mute")
            case .volume_decrement:
                KeycodeInfo(functionType: .consumer, keyCodeString: "volume_decrement")
            case .volume_incremnt:
                KeycodeInfo(functionType: .consumer, keyCodeString: "volume_increment")
            case .lock_key_on_magic_keyboard_without_touch_id:
                KeycodeInfo(functionType: .consumer, keyCodeString: "al_terminal_lock_or_screensaver")
            case .eject:
                KeycodeInfo(functionType: .consumer, keyCodeString: "eject")
            case .brightness_down:
                KeycodeInfo(functionType: .appleVendorTopCase, keyCodeString: "brightness_down")
            case .brightness_up:
                KeycodeInfo(functionType: .appleVendorTopCase, keyCodeString: "brightness_up")
            case .scan_previous_track:
                KeycodeInfo(functionType: .appleVendorTopCase, keyCodeString: "scan_previous_track")
            case .scan_next_track:
                KeycodeInfo(functionType: .appleVendorTopCase, keyCodeString: "scan_next_track")
            case .stop:
                KeycodeInfo(functionType: .consumer, keyCodeString: "stop")
            case .bass_boost:
                KeycodeInfo(functionType: .consumer, keyCodeString: "bass_boost")
            case .loudness:
                KeycodeInfo(functionType: .consumer, keyCodeString: "loudness")
            case .bass_increment:
                KeycodeInfo(functionType: .consumer, keyCodeString: "bass_increment")
            case .bass_decrement:
                KeycodeInfo(functionType: .consumer, keyCodeString: "bass_decrement")
            }
        }
        
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            switch self {
            case .rewind:
                ("backward", true)
            case .play_or_pause:
                ("playpause", true)
            case .fast_forward:
                ("forward", true)
            case .mute:
                ("speaker.slash", true)
            case .volume_decrement:
                ("speaker.wave.1", true)
            case .volume_incremnt:
                ("speaker.wave.3", true)
            case .lock_key_on_magic_keyboard_without_touch_id:
                ("lock", true)
            case .eject:
                ("eject", true)
            case .brightness_down:
                ("sun.min.fill", true)
            case .brightness_up:
                ("sun.max.fill", true)
            case .scan_previous_track:
                ("scan prev", false) // CDの読み込みとかに使えるのかな？
            case .scan_next_track:
                ("scan next", false)
            case .stop:
                ("stop", false)
            case .bass_boost:
                ("bass boost", false)
            case .loudness:
                ("loudness", false)
            case .bass_increment:
                ("bass increment", false)
            case .bass_decrement:
                ("bass decrement", false)
            }
        }
        
        
    }
    
    enum KeysInPCKeyboards: String, CaseIterable, Codable {
        case print_screen, scroll_lock, pause, insert, application, help, power
        case execute, menu, select, stop
        case again, undo, cut, copy, paste, find
        
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            KeycodeInfo(keyCodeString: self.rawValue)
        }
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            switch self {
            case .print_screen:
                ("printer", true)
            case .scroll_lock:
                ("scroll lock", false)
            case .pause:
                ("pause", false)
            case .insert:
                ("text.insert", true)
            case .application:
                ("filemenu.and.selection", true)
            case .help:
                ("questionmark.circle", true)
            case .power:
                ("power", true)
            default:
                (self.rawValue, false)
            }
        }
        
    }
    
    enum InternationalKeys: String, CaseIterable, Codable {
        case international1, international2, international3, international4, international5, international6, international7, international8, international9
        case lang1, lang2, lang3, lang4, lang5, lang6, lang7, lang8, lang9
        
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            KeycodeInfo(keyCodeString: self.rawValue)
        }
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            switch self {
            case .international1:
                ("_", false)
            case .international3:
                ("\\", false)
            default:
                (self.rawValue, false)
            }
        }
    }
    
    enum Japanese: String, CaseIterable, Codable {
        case eisuu, kana
        case pc_mu_henkan, pc_henkan, pc_kana
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            
            switch self {
            case .eisuu:
                KeycodeInfo(keyCodeString: "japanese_eisuu")
            case .kana:
                KeycodeInfo(keyCodeString: "japanese_kana")
            case .pc_mu_henkan:
                KeycodeInfo(keyCodeString: "japanese_pc_nfer")
            case .pc_henkan:
                KeycodeInfo(keyCodeString: "japanese_pc_xfer")
            case .pc_kana:
                KeycodeInfo(keyCodeString: "japanese_pc_katakana")
            }
        }
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            switch self {
            case .eisuu:
                ("英数", false)
            case .kana:
                ("かな", false)
            case .pc_mu_henkan:
                ("無変換", false)
            case .pc_henkan:
                ("変換", false)
            case .pc_kana:
                ("pcカナ", false)//キーコードを見るに多分カタカナ変換のキーだと思うので、表示はカナで良いのかも？わからん
            }
        }
    }
    
    enum DPad: String, CaseIterable, Codable {
        case dpad_up, dpad_down, dpad_left, dpad_right
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            KeycodeInfo(functionType: .generic_desktop, keyCodeString: self.rawValue)
        }
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            switch self {
            case .dpad_up:
                ("pad up", false)
            case .dpad_down:
                ("pad down", false)
            case .dpad_left:
                ("pad left", false)
            case .dpad_right:
                ("pad right", false)
            }
        }
    }
    
    enum ApplicationLaunchKeys: String, CaseIterable, Codable {
        case al_consumer_control_configuration // Music
        case al_word_processor // Pages
        case al_text_editor // TextEdit
        case al_spreadsheet // numbers
        case al_graphics_editor
        case al_presentation_app // Keynote
        case al_database_app
        case al_email_reader // Mail
        case al_newsreader
        case al_voicemail
        case al_contacts_or_addres_book
        case al_Calendar_Or_Schedule
        case al_task_or_project_manager
        case al_log_or_journal_or_timecard
        case al_checkbook_or_finance
        case al_calculator // Calculator
        case al_a_or_v_capture_or_playback
        case al_local_machine_browser // Finder
        case al_lan_or_wan_browser
        case al_internet_browser // Safari
        case al_remote_networking_or_isp_connect
        case al_network_conference
        case al_network_chat
        case al_telephony_or_dialer
        case al_logon, al_logoff
        case al_control_panel
        case al_command_line_processor_or_run
        case al_process_or_task_manager
        case al_select_task_or_application
        case al_next_task_or_application
        case al_previous_task_or_application
        case al_preemptive_halt_task_or_application
        case al_integrated_help_center
        case al_documents
        case al_thesaurus
        case al_dictionary // Dictionary
        case al_desktop
        case al_spell_check
        case al_grammer_check
        case al_wireless_status
        case al_keyboard_layout
        case al_virus_protection
        case al_encryption
        case al_screen_saver
        case al_alarms
        case al_clock
        case al_file_browser
        case al_power_status
        case al_image_browser
        case al_audio_browser
        case al_movie_browser
        case al_digital_rights_manager
        case al_digital_wallet
        case al_instant_messaging
        case al_oem_feature_browser
        case al_oem_help
        case al_online_community
        case al_entertainment_content_browser
        case al_online_shopping_browser
        case al_smart_card_information_or_help
        case al_market_monitor_or_finance_browser
        case al_customized_corporate_news_browser
        case al_online_activity_browser
        case al_research_or_search_browser
        case al_audio_player
        case al_message_status
        case al_contact_sync
        case al_navigation
        case al_contextaware_desktop_assistant
        
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            KeycodeInfo(functionType: .consumer, keyCodeString: self.rawValue)
        }
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            switch self {
            case .al_consumer_control_configuration:
                ("Music", false)
            case .al_word_processor:
                ("Pages", false)
            case .al_text_editor:
                ("TextEdit", false)
            case .al_spreadsheet:
                ("Numbers", false)
            case .al_presentation_app:
                ("Keynote", false)
            case .al_email_reader:
                ("Mail", false)
            case .al_calculator:
                ("Calc", false)
            case .al_local_machine_browser:
                ("Finder", false)
            case .al_internet_browser:
                ("safari", false)
            case .al_dictionary:
                ("Dictio", false)
            default:
                (self.rawValue.replacingOccurrences(of: "al_", with: "").replacingOccurrences(of: "_", with: " "), false)
            }
        }
                
        
    }
    
    enum GenericGUIApplicationControlKeys: String, CaseIterable, Codable {
        case ac_search, ac_home, ac_back, ac_forward, ac_refresh, ac_bookmarks, ac_zoom_out, ac_zoom_in
        
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            KeycodeInfo(functionType: .consumer, keyCodeString: self.rawValue)
        }
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            let displayName = self.rawValue.replacingOccurrences(of: "_", with: " ")
            return (displayName, false)
        }
    }
    
    enum RemoteControlButtons: String, CaseIterable, Codable {
        case menu_pick, menu_up, menu_down, menu_left, menu_right, menu_escape
        case menu_value_increase, menu_value_decrease
        case data_on_screen
        case closed_caption, closed_caption_select
        case vcr_or_tv
        case broadcast_mode
        case snapshot
        case still
        case picture_in_picture_toggle, picture_in_picture_swap
        case red_menu_button, green_menu_button, yellow_menu_button
        case aspect, three_dimensional_mode_select
        
        
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            KeycodeInfo(functionType: .consumer, keyCodeString: self.rawValue)
        }
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            let displayName = self.rawValue.replacingOccurrences(of: "_", with: " ")
            return (displayName, false)
        }
    }
    
    enum GenericDesktopKeys: String, CaseIterable, Codable {
        case system_sleep
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            KeycodeInfo(functionType: .generic_desktop, keyCodeString: self.rawValue)
        }
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            let displayName = self.rawValue.replacingOccurrences(of: "_", with: " ")
            return (displayName, false)
        }
    }
    
    enum Others: String, CaseIterable, Codable {
        case keypad_qual_sign_as400
        case locking_caps_lock, locking_num_lock, locking_scroll_lock
        case alternate_erase, sys_req_or_attention
        case cancel, clear, prior
        case rarely_used_return
        case separator, out, oper, clear_or_again, cr_sel_or_props, ex_sel
        case fastforward, mute, volume_decrement, volume_increment
        case fn
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            switch self {
            case .rarely_used_return:
                KeycodeInfo(keyCodeString: "return")
            case .fastforward:
                KeycodeInfo(functionType: .consumer, keyCodeString: self.rawValue)
            default:
                KeycodeInfo(keyCodeString: self.rawValue)
            }
        }
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            let displayName = self.rawValue.replacingOccurrences(of: "_", with: " ")
            return (displayName, false)
        }
    }
}

extension FromKeycode {
    static var allKeys: [FromKeycode] {
        var cases: [FromKeycode] = []
        cases += ModifierKeys.allCases.map { .modifier_keys($0) }
        cases += ControlsAndSymbols.allCases.map { .controls_and_symbols($0) }
        cases += ArrowKeys.allCases.map { .arrow_keys($0) }
        cases += LetterKeys.allCases.map { .letter_keys($0) }
        cases += NumberKeys.allCases.map { .number_keys($0) }
        cases += FunctionKeys.allCases.map { .function_keys($0) }
        cases += MediaControls.allCases.map { .media_controls($0) }
        cases += KeypadKeys.allCases.map { .keypad_keys($0) }
        cases += KeysInPCKeyboards.allCases.map { .keys_in_pc_keyboards($0) }
        cases += InternationalKeys.allCases.map { .international_keys($0) }
        cases += Japanese.allCases.map { .japanese($0) }
        cases += MouseButtons.allCases.map { .mouse_buttons($0) }
        cases += DPad.allCases.map { .D_pad($0) }
        cases += ApplicationLaunchKeys.allCases.map { .application_launch_keys($0) }
        cases += GenericGUIApplicationControlKeys.allCases.map { .generic_GUI_application_control_keys($0) }
        cases += RemoteControlButtons.allCases.map { .remote_control_buttons($0) }
        cases += GenericDesktopKeys.allCases.map { .generic_desktop_keys($0) }
        cases += Others.allCases.map { .others($0) }
        
        return cases
    }
}


enum ToKeycode: Codable, Equatable, Hashable {
    case not_customized_key(NotCustomizedKey)
    case disable_this_key(DisableThisKey)
    case layer_keys(LayerKeys)
    case modifier_keys(ModifierKeys)
    case controls_and_symbols(ControlsAndSymbols)
    case shift_symbols(ShiftSymbols)
    case option_symbols(OptionSymbols)
    case shift_option_symbols(ShiftOptionSymbols)
    case arrow_keys(ArrowKeys)
    case letter_keys(LetterKeys)
    case number_keys(NumberKeys)
    case function_keys(FunctionKeys)
    case media_controls(MediaControls)
    case keypad_keys(KeypadKeys)
    case keys_in_pc_keyboards(KeysInPCKeyboards)
    case international_keys(InternationalKeys)
    case japanese(Japanese)
    case mouse_buttons(MouseButtons)
    case mouse_keys(MouseKeys)
    case software_function(SoftwareFunction)
    case application_launch_keys(ApplicationLaunchKeys)
    case others(Others)
    
    func layerInfo() -> Layer? {
        switch self {
        case .layer_keys(let layerKeys):
            return layerKeys.layer()
        default:
            return nil
        }
    }
    
    func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo? {
        switch self {
        case .not_customized_key(let notCustomizedKey):
            notCustomizedKey.keycodeInfo(region)
        case .disable_this_key(let disableThisKey):
            disableThisKey.keycodeInfo(region)
        case .layer_keys(let layerKeys):
            layerKeys.keycodeInfo(region)
        case .modifier_keys(let modifierKeys):
            modifierKeys.keycodeInfo(region)
        case .controls_and_symbols(let controlsAndSymbols):
            controlsAndSymbols.keycodeInfo(region)
        case .shift_symbols(let shiftSymbols):
            shiftSymbols.keycodeInfo(region)
        case .option_symbols(let optionSymbols):
            optionSymbols.keycodeInfo(region)
        case .shift_option_symbols(let shiftOptionSymbols):
            shiftOptionSymbols.keycodeInfo(region)
        case .arrow_keys(let arrowKeys):
            arrowKeys.keycodeInfo(region)
        case .letter_keys(let letterKeys):
            letterKeys.keycodeInfo(region)
        case .number_keys(let numberKeys):
            numberKeys.keycodeInfo(region)
        case .function_keys(let functionKeys):
            functionKeys.keycodeInfo(region)
        case .media_controls(let mediaControls):
            mediaControls.keycodeInfo(region)
        case .keypad_keys(let keypadKeys):
            keypadKeys.keycodeInfo(region)
        case .keys_in_pc_keyboards(let keysInPCKeyboards):
            keysInPCKeyboards.keycodeInfo(region)
        case .international_keys(let internationalKeys):
            internationalKeys.keycodeInfo(region)
        case .japanese(let japanese):
            japanese.keycodeInfo(region)
        case .mouse_buttons(let mouseButtons):
            mouseButtons.keycodeInfo(region)
        case .mouse_keys(let mouseKeys):
            mouseKeys.keycodeInfo(region)
        case .software_function(let softwareFunction):
            softwareFunction.keycodeInfo(region)
        case .application_launch_keys(let applicationLaunchKeys):
            applicationLaunchKeys.keycodeInfo(region)
        case .others(let others):
            others.keycodeInfo(region)
        }
    }
    
    func defaultDisplayString() -> (display: String, isSFSymbol: Bool) {
        switch self {
        case .not_customized_key(let notCustomizedKey):
            notCustomizedKey.displayString()
        case .disable_this_key(let disableThisKey):
            disableThisKey.displayString()
        case .layer_keys(let layerKeys):
            layerKeys.displayString()
        case .modifier_keys(let modifierKeys):
            modifierKeys.displaySymbol()
        case .controls_and_symbols(let controlsAndSymbols):
            controlsAndSymbols.displaySymbol()
        case .shift_symbols(let shiftSymbols):
            shiftSymbols.displaySymbol()
        case .option_symbols(let optionSymbols):
            optionSymbols.displaySymbol()
        case .shift_option_symbols(let shiftOptionSymbols):
            shiftOptionSymbols.displaySymbol()
        case .arrow_keys(let arrowKeys):
            arrowKeys.displaySymbol()
        case .letter_keys(let letterKeys):
            letterKeys.displaySymbol()
        case .number_keys(let numberKeys):
            numberKeys.displaySymbol()
        case .function_keys(let functionKeys):
            functionKeys.displaySymbol()
        case .media_controls(let mediaControls):
            mediaControls.displaySymbol()
        case .keypad_keys(let keypadKeys):
            keypadKeys.displaySymbol()
        case .keys_in_pc_keyboards(let keysInPCKeyboards):
            keysInPCKeyboards.displaySymbol()
        case .international_keys(let internationalKeys):
            internationalKeys.displaySymbol()
        case .japanese(let japanese):
            japanese.displaySymbol()
        case .mouse_buttons(let mouseButtons):
            mouseButtons.displaySymbol()
        case .mouse_keys(let mouseKeys):
            mouseKeys.displaySymbol()
        case .software_function(let softwareFunction):
            softwareFunction.displaySymbol()
        case .application_launch_keys(let applicationLaunchKeys):
            applicationLaunchKeys.displaySymbol()
        case .others(let others):
            others.displaySymbol()
        }
    }
    
    enum NotCustomizedKey: String, CaseIterable, Codable {
        case not_customized
        
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo? { nil }
        func displayString() -> (display: String, isSFSymbol: Bool) { ("none", false) }
    }
    
    enum DisableThisKey: String, CaseIterable, Codable {
        case vk_none
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            KeycodeInfo(keyCodeString: "vk_none")
        }
        func displayString() -> (display: String, isSFSymbol: Bool) {
            ("square.dotted", true)
        }
    }
    
    enum LayerKeys: String, CaseIterable, Codable {
        case layer1, layer1_on, layer1_off
        case layer2, layer2_on, layer2_off
        case layer3, layer3_on, layer3_off
        case layer4, layer4_on, layer4_off
        case layer5, layer5_on, layer5_off
        case layer6, layer6_on, layer6_off
        case layer7, layer7_on, layer7_off
        case layer8, layer8_on, layer8_off
        
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            switch self {
            case .layer1, .layer2, .layer3, .layer4, .layer5, .layer6, .layer7, .layer8 : KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"\(self.variableName())\",\"value\": true, \"key_up_value\": false}")
            case .layer1_on, .layer2_on, .layer3_on, .layer4_on, .layer5_on, .layer6_on, .layer7_on, .layer8_on :
                KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"\(self.variableName())\",\"value\": true}")
            case .layer1_off, .layer2_off, .layer3_off, .layer4_off, .layer5_off, .layer6_off, .layer7_off, .layer8_off :
                KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"\(self.variableName())\",\"value\": false}")
            }
        }
        func variableName() -> String {
            switch self {
            case .layer1, .layer1_on, .layer1_off :
                "layer1"
            case .layer2, .layer2_on, .layer2_off :
                "layer2"
            case .layer3, .layer3_on, .layer3_off :
                "layer3"
            case .layer4, .layer4_on, .layer4_off :
                "layer4"
            case .layer5, .layer5_on, .layer5_off :
                "layer5"
            case .layer6, .layer6_on, .layer6_off :
                "layer6"
            case .layer7, .layer7_on, .layer7_off :
                "layer7"
            case .layer8, .layer8_on, .layer8_off :
                "layer8"
            }
        }
        
        func layer() -> Layer {
            switch self {
            case .layer1, .layer1_on, .layer1_off :
                Layer.layer1
            case .layer2, .layer2_on, .layer2_off :
                Layer.layer2
            case .layer3, .layer3_on, .layer3_off :
                Layer.layer3
            case .layer4, .layer4_on, .layer4_off :
                Layer.layer4
            case .layer5, .layer5_on, .layer5_off :
                Layer.layer5
            case .layer6, .layer6_on, .layer6_off :
                Layer.layer6
            case .layer7, .layer7_on, .layer7_off :
                Layer.layer7
            case .layer8, .layer8_on, .layer8_off :
                Layer.layer8
            }
        }
        
        func displayString() -> (display: String, isSFSymbol: Bool) {
            switch self {
            case .layer1:
                ("1.square", true)
            case .layer2 :
                ("2.square", true)
            case .layer3 :
                ("3.square", true)
            case .layer4 :
                ("4.square", true)
            case .layer5 :
                ("5.square", true)
            case .layer6 :
                ("6.square", true)
            case .layer7 :
                ("7.square", true)
            case .layer8 :
                ("8.square", true)
            case .layer1_on, .layer2_on, .layer3_on, .layer4_on, .layer5_on, .layer6_on, .layer7_on, .layer8_on:
                ("ON", false)
            case.layer1_off, .layer2_off, .layer3_off, .layer4_off, .layer5_off, .layer6_off, .layer7_off, .layer8_off:
                ("OFF", false)
            }
        }
    }
    
    enum ControlsAndSymbols: String, CaseIterable, Codable {
        ///カテゴリ別のEnumでは、caseに最終的に出力される文字を表す単語と
        ///それに対して(ansi: , iso: , jis:)のキーコードをもらえるような関数がある
        case return_or_enter
        case escape
        case delete_or_backspace
        case delete_forward
        case tab
        case spacebar
        
        case hyphen // (hyphen)
        case equal_sign // = (ansi: equal_sign, iso: equal_sign, jis: hyphen + shift)
        case open_square_bracket // [ (ansi: open_bracket, iso: open_bracket, jis: close_bracket)
        case close_square_bracket // ] (ansi, iso: close_bracket, jis: backslash)
        case backslash // ansi: backslash, iso: non_us_pound, jis: international3
        case semicolon // ; (semicolon)
        case single_quotation // ' (ansi, iso: quote, jis:7+shift)
        case grave_accent // ` (ansi: grave_accent_and_tilde, iso: non_us_backslash, jis: grave_accent_and_tilde)
        case comma // , (comma)
        case period // . (priod)
        case slash // / (slash)
        case section // § (ansi: non_us_backslash, iso: grave_accent_and_tilde, jis:  non_us_backlash)
        
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            switch self {
            case .return_or_enter:
                KeycodeInfoCollection(KeycodeInfo(keyCodeString: "return_or_enter")).keycodeInfo(region)
            case .escape:
                KeycodeInfoCollection(KeycodeInfo(keyCodeString: "escape")).keycodeInfo(region)
            case .delete_or_backspace:
                KeycodeInfoCollection(KeycodeInfo(keyCodeString: "delete_or_backspace")).keycodeInfo(region)
            case .delete_forward:
                KeycodeInfoCollection(KeycodeInfo(keyCodeString: "delete_forward")).keycodeInfo(region)
            case .tab:
                KeycodeInfoCollection(KeycodeInfo(keyCodeString: "tab")).keycodeInfo(region)
            case .spacebar:
                KeycodeInfoCollection(KeycodeInfo(keyCodeString: "spacebar")).keycodeInfo(region)
            case .hyphen:
                KeycodeInfoCollection(KeycodeInfo(keyCodeString: "hyphen")).keycodeInfo(region)
            case .equal_sign:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "equal_sign"),
                    JIS: KeycodeInfo(keyCodeString: "hyphen", includeShift: true)
                ).keycodeInfo(region)
            case .open_square_bracket:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "open_bracket"),
                    JIS: KeycodeInfo(keyCodeString: "close_bracket")
                ).keycodeInfo(region)
            case .close_square_bracket:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "close_bracket"),
                    JIS: KeycodeInfo(keyCodeString: "backslash")
                ).keycodeInfo(region)
            case .backslash:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "backslash"),
                    JIS: KeycodeInfo(keyCodeString: "international3")
                ).keycodeInfo(region)
            case .semicolon:
                KeycodeInfoCollection(KeycodeInfo(keyCodeString: "semicolon")).keycodeInfo(region)
            case .single_quotation:
                KeycodeInfoCollection(KeycodeInfo(keyCodeString: "quote")).keycodeInfo(region)
            case .grave_accent:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "grave_accent_and_tilde"),
                    ISO: KeycodeInfo(keyCodeString: "non_us_backslash")
                ).keycodeInfo(region)
            case .comma:
                KeycodeInfoCollection(KeycodeInfo(keyCodeString: "comma")).keycodeInfo(region)
            case .period:
                KeycodeInfoCollection(KeycodeInfo(keyCodeString: "period")).keycodeInfo(region)
            case .slash:
                KeycodeInfoCollection(KeycodeInfo(keyCodeString: "slash")).keycodeInfo(region)
            case .section:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "non_us_backslash"),
                    ISO: KeycodeInfo(keyCodeString: "grave_accent_and_tilde")
                ).keycodeInfo(region)
            }
        }
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            switch self {
            case .return_or_enter: ("return", true)
            case .escape: ("escape", true)
            case .delete_or_backspace: ("delete.left", true)
            case .delete_forward: ("delete.right", true)
            case .tab: ("arrow.right.to.line", true)
            case .spacebar: ("␣", false)
            case .hyphen: ("-", false)
            case .equal_sign: ("=", false)
            case .open_square_bracket: ("[", false)
            case .close_square_bracket: ("]", false)
            case .backslash: ("\\", false)
            case .semicolon: (";", false)
            case .single_quotation: ("'", false)
            case .grave_accent: ("`", false)
            case .comma: (",", false)
            case .period: (".", false)
            case .slash: ("/", false)
            case .section: ("§", false)
            }
        }
    }
    enum ShiftSymbols: String, CaseIterable, Codable {
        // Symbols
        case under_bar // _ (ansi,iso: hyphen+shift, jis: international1)
        case plus // + (ansi: equal_sign + shift, jis: semicolon + shift)
        case open_curly_bracket // { (ansi, iso: open_bracket + shift, jis: close+shift)
        case close_curly_bracket // } (ansi, iso: close+shift, jis: backslash+shift)
        case vertical_bar // | (ansi, iso: backslash + shift, jis: internationl3 + shift)
        case colon // : (ansi, iso: semi+shift, jis: quote)
        case double_quotation // " (ansi, iso: quote+shift, jis: 2+shift)
        case tilde // ~ (ansi: grave_accent_and_tilde+shift, iso: non_us_backslash+shift, jis: equal_sign+shift)
        case less_than // < (comma+shift)
        case greater_than // > (period+shift)
        case question // ? (slash + shift)
//        case plus_minus // ±, (ansi: non_us_backslash + shift, iso: ???, jis: non_us_backslash + shift)
        
        case exclamation // ! (1+shift)
        case commercial_at // @ (ansi, iso: 2+shift, jis: open_bracket)
        case number_sign // # (3+shift)
        case dollar // $ (4+shift)
        case percent // % (5+shift)
        case caret // ^ (ansi, iso: 6+shift, jis: equal_sign)
        case ampersand // & (ansi, iso: 7+shift, jis: 6+shift)
        case asterisk // * (ansi, iso: 8+shift, jis: quote+shift)
        case open_parenthesis // ( (ansi, iso: 9+shift, jis: 8+shift)
        case close_parenthesis // ) (ansi, iso: 0+shift, jis: 9+shift)
        
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            switch self {
            case .under_bar:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "hyphen", includeShift: true),
                    JIS: KeycodeInfo(keyCodeString: "international1")
                ).keycodeInfo(region)
            case .plus:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "equal_sign", includeShift: true),
                    JIS: KeycodeInfo(keyCodeString: "semicolon", includeShift: true)
                ).keycodeInfo(region)
            case .open_curly_bracket:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "open_bracket", includeShift: true),
                    JIS: KeycodeInfo(keyCodeString: "close_bracket", includeShift: true)
                ).keycodeInfo(region)
            case .close_curly_bracket:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "close_bracket", includeShift: true),
                    JIS: KeycodeInfo(keyCodeString: "backslash", includeShift: true)
                ).keycodeInfo(region)
            case .vertical_bar:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "backslash", includeShift: true),
                    JIS: KeycodeInfo(keyCodeString: "international3", includeShift: true)
                ).keycodeInfo(region)
            case .colon:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "semicolon", includeShift: true),
                    JIS: KeycodeInfo(keyCodeString: "quote")
                ).keycodeInfo(region)
            case .double_quotation:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "quote", includeShift: true),
                    JIS: KeycodeInfo(keyCodeString: "2", includeShift: true)
                ).keycodeInfo(region)
            case .tilde:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "grave_accent_and_tilde", includeShift: true),
                    ISO: KeycodeInfo(keyCodeString: "non_us_backslash", includeShift: true),
                    JIS: KeycodeInfo(keyCodeString: "equal_sign", includeShift: true)
                ).keycodeInfo(region)
            case .less_than:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "comma", includeShift: true)
                ).keycodeInfo(region)
            case .greater_than:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "period", includeShift: true)
                ).keycodeInfo(region)
            case .question:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "slash", includeShift: true)
                ).keycodeInfo(region)
                
            case .exclamation:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "1", includeShift: true)
                ).keycodeInfo(region)
            case .commercial_at:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "2", includeShift: true),
                    JIS: KeycodeInfo(keyCodeString: "open_bracket")
                ).keycodeInfo(region)
            case .number_sign:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "3", includeShift: true)
                ).keycodeInfo(region)
            case .dollar:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "4", includeShift: true)
                ).keycodeInfo(region)
            case .percent:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "5", includeShift: true)
                ).keycodeInfo(region)
            case .caret:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "6", includeShift: true),
                    JIS: KeycodeInfo(keyCodeString: "equal_sign")
                ).keycodeInfo(region)
            case .ampersand:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "7", includeShift: true),
                    JIS: KeycodeInfo(keyCodeString: "6", includeShift: true)
                ).keycodeInfo(region)
            case .asterisk:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "8", includeShift: true),
                    JIS: KeycodeInfo(keyCodeString: "7", includeShift: true)
                ).keycodeInfo(region)
            case .open_parenthesis:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "9", includeShift: true),
                    JIS: KeycodeInfo(keyCodeString: "8", includeShift: true)
                ).keycodeInfo(region)
            case .close_parenthesis:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "0", includeShift: true),
                    JIS: KeycodeInfo(keyCodeString: "9", includeShift: true)
                ).keycodeInfo(region)
            }
            
        }
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            switch self {
            case .under_bar:
                ("_", false)
            case .plus:
                ("+", false)
            case .open_curly_bracket:
                ("{", false)
            case .close_curly_bracket:
                ("}", false)
            case .vertical_bar:
                ("|", false)
            case .colon:
                (":", false)
            case .double_quotation:
                ("\"", false)
            case .tilde:
                ("~", false)
            case .less_than:
                ("<", false)
            case .greater_than:
                (">", false)
            case .question:
                ("?", false)
            case .exclamation:
                ("!", false)
            case .commercial_at:
                ("@", false)
            case .number_sign:
                ("#", false)
            case .dollar:
                ("$", false)
            case .percent:
                ("%", false)
            case .caret:
                ("^", false)
            case .ampersand:
                ("&", false)
            case .asterisk:
                ("*", false)
            case .open_parenthesis:
                ("(", false)
            case .close_parenthesis:
                (")", false)
            }
        }
    }
    enum OptionSymbols: String, CaseIterable, Codable {
        
        // with symbols
        case en_dash // – (hyphen+option)
        case not_equal // ≠ (equal+option)
        case left_double_quotation_mark // “ (open_bracket+option)
        case left_single_quotation_mark // ‘ (close_bracket+option)
        //↓日本語IMEでバックスラッシュで入力している文字ではない方が打たれる↓
        case yen_or_backslash // ¥ (ansi: backslash+option, jis: ?)
//        case left_pointing_double_angle_quotation_mark // « (ansi: ?, jis: backslash+option)
        
        case holizontal_ellipsis // … (semicolon+option)
        case ae_ligature // æ (quote+option)
        case less_than_or_equal_to // ≤ (comma+option)
        case greater_than_or_equal_to // ≥ (period+option)
        case grave_accent // ◌̀ (iso: non_us_backslash+option,jis:international1 + option)
        
        // with number
        case inverted_exclamation // ¡ (1+option)
        case trade_mark // ™ (2+option)
        case pound // £ (3+option)
        case cent // ¢ (4+option)
        case infinity // ∞ (5+option)
        case section // § (6+option)
        case pilcrow // ¶ (7+option)
        case bullet // • (ansi, iso: 8+option, jis: ?)
        case feminine_ordinal_indicator // ª (ansi, iso: 9+option, jis: 8+option)
        case masculine_ordinal_indicator // º (ansi, iso: 0+option, jis: 9+option)
        
        // with letter
        case oe_ligature // œ (q+option)
        case sigma // ∑ (w+option)
        case acute_accent // ◌́ (e+option) and typed Letter. -> á
        case registered_trademark // ® (r+option)
        case dagger // † (t+option)
        case backslash_or_yen // \ (y+option)
        case diaeresis // ◌̈ (u+option)
        case circumflex // ◌̂ (i+option)
        case o_with_stroke // ø (o+option) oeの合字でœで代用されることもある
        case pi // π (p+option)
        case angstrom // å (a+option) 1å=0.1nm
        case eszett // ß (s+option) sの無声音
        case curly_d // ∂ (d+option) 数学記号、偏微分に用いられる
        case f_with_hook // ƒ (f+option)
        case copy_right // © (g+option)
        case dot_above // ˙ (h+option)
        case delta // ∆ (j+option) 増加量とか
        case ring_above // ˚ (k+option)
        case not_sign // ¬ (l+option)
        case omega // Ω (z+option)
        case almost_equal // ≈ (x+option)
        case c_with_cedilla // ç (c+option)
        case square_root // √ (v+option)
        case integral // ∫ (b+option)
        
        case small_tilde // ◌̃ (n+option)
        case mu // µ (m+option) 接頭辞マイクロ
        
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            switch self {
            case .en_dash:
                KeycodeInfo(keyCodeString: "hyphen", includeOption: true)
            case .not_equal:
                KeycodeInfo(keyCodeString: "equal_sign", includeOption: true)
            case .left_double_quotation_mark:
                KeycodeInfo(keyCodeString: "open_bracket", includeOption: true)
            case .left_single_quotation_mark:
                KeycodeInfo(keyCodeString: "close_bracket", includeOption: true)
            case .yen_or_backslash:
                KeycodeInfo(keyCodeString: "backslash", includeOption: true)
            case .holizontal_ellipsis:
                KeycodeInfo(keyCodeString: "semicolon", includeOption: true)
            case .ae_ligature:
                KeycodeInfo(keyCodeString: "quote", includeOption: true)
            case .less_than_or_equal_to:
                KeycodeInfo(keyCodeString: "comma", includeOption: true)
            case .greater_than_or_equal_to:
                KeycodeInfo(keyCodeString: "period", includeOption: true)
            case .grave_accent:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "non_us_backslash", includeOption: true),
                    JIS: KeycodeInfo(keyCodeString: "international1", includeOption: true)
                ).keycodeInfo(region)
            case .inverted_exclamation:
                KeycodeInfo(keyCodeString: "1", includeOption: true)
            case .trade_mark:
                KeycodeInfo(keyCodeString: "2", includeOption: true)
            case .pound:
                KeycodeInfo(keyCodeString: "3", includeOption: true)
            case .cent:
                KeycodeInfo(keyCodeString: "4", includeOption: true)
            case .infinity:
                KeycodeInfo(keyCodeString: "5", includeOption: true)
            case .section:
                KeycodeInfo(keyCodeString: "6", includeOption: true)
            case .pilcrow:
                KeycodeInfo(keyCodeString: "7", includeOption: true)
            case .bullet:
                KeycodeInfo(keyCodeString: "8", includeOption: true)
            case .feminine_ordinal_indicator:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "9", includeOption: true),
                    JIS: KeycodeInfo(keyCodeString: "8", includeOption: true)
                ).keycodeInfo(region)
            case .masculine_ordinal_indicator:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "0", includeOption: true),
                    JIS: KeycodeInfo(keyCodeString: "9", includeOption: true)
                ).keycodeInfo(region)
                
                
            case .oe_ligature:
                KeycodeInfo(keyCodeString: "q", includeOption: true)
            case .sigma:
                KeycodeInfo(keyCodeString: "w", includeOption: true)
            case .acute_accent:
                KeycodeInfo(keyCodeString: "e", includeOption: true)
            case .registered_trademark:
                KeycodeInfo(keyCodeString: "r", includeOption: true)
            case .dagger:
                KeycodeInfo(keyCodeString: "t", includeOption: true)
            case .backslash_or_yen:
                KeycodeInfo(keyCodeString: "y", includeOption: true)
            case .diaeresis:
                KeycodeInfo(keyCodeString: "u", includeOption: true)
            case .circumflex:
                KeycodeInfo(keyCodeString: "i", includeOption: true)
            case .o_with_stroke:
                KeycodeInfo(keyCodeString: "o", includeOption: true)
            case .pi:
                KeycodeInfo(keyCodeString: "p", includeOption: true)
                
            case .angstrom:
                KeycodeInfo(keyCodeString: "a", includeOption: true)
            case .eszett:
                KeycodeInfo(keyCodeString: "s", includeOption: true)
            case .curly_d:
                KeycodeInfo(keyCodeString: "d", includeOption: true)
            case .f_with_hook:
                KeycodeInfo(keyCodeString: "f", includeOption: true)
            case .copy_right:
                KeycodeInfo(keyCodeString: "g", includeOption: true)
            case .dot_above:
                KeycodeInfo(keyCodeString: "h", includeOption: true)
            case .delta:
                KeycodeInfo(keyCodeString: "j", includeOption: true)
            case .ring_above:
                KeycodeInfo(keyCodeString: "k", includeOption: true)
            case .not_sign:
                KeycodeInfo(keyCodeString: "l", includeOption: true)
                
            case .omega:
                KeycodeInfo(keyCodeString: "z", includeOption: true)
            case .almost_equal:
                KeycodeInfo(keyCodeString: "x", includeOption: true)
            case .c_with_cedilla:
                KeycodeInfo(keyCodeString: "c", includeOption: true)
            case .square_root:
                KeycodeInfo(keyCodeString: "v", includeOption: true)
            case .integral:
                KeycodeInfo(keyCodeString: "b", includeOption: true)
            case .small_tilde:
                KeycodeInfo(keyCodeString: "n", includeOption: true)
            case .mu:
                KeycodeInfo(keyCodeString: "m", includeOption: true)
            }
        }
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            switch self {
            case .en_dash:
                ("–", false)
            case .not_equal:
                ("≠", false)
            case .left_double_quotation_mark:
                ("“", false)
            case .left_single_quotation_mark:
                ("‘", false)
            case .yen_or_backslash:
                ("¥", false)
            case .holizontal_ellipsis:
                ("…", false)
            case .ae_ligature:
                ("æ", false)
            case .less_than_or_equal_to:
                ("≤", false)
            case .greater_than_or_equal_to:
                ("≥", false)
            case .grave_accent:
                ("◌̀", false)
            case .inverted_exclamation:
                ("¡", false)
            case .trade_mark:
                ("™", false)
            case .pound:
                ("£", false)
            case .cent:
                ("¢", false)
            case .infinity:
                ("∞", false)
            case .section:
                ("§", false)
            case .pilcrow:
                ("¶", false)
            case .bullet:
                ("•", false)
            case .feminine_ordinal_indicator:
                ("ª", false)
            case .masculine_ordinal_indicator:
                ("º", false)
            case .oe_ligature:
                ("œ", false)
            case .sigma:
                ("∑", false)
            case .acute_accent:
                ("◌́", false)
            case .registered_trademark:
                ("®", false)
            case .dagger:
                ("†", false)
            case .backslash_or_yen:
                ("\\", false)
            case .diaeresis:
                ("◌̈", false)
            case .circumflex:
                ("◌̂", false)
            case .o_with_stroke:
                ("ø", false)
            case .pi:
                ("π", false)
            case .angstrom:
                ("å", false)
            case .eszett:
                ("ß", false)
            case .curly_d:
                ("∂", false)
            case .f_with_hook:
                ("ƒ", false)
            case .copy_right:
                ("©", false)
            case .dot_above:
                ("˙", false)
            case .delta:
                ("∆", false)
            case .ring_above:
                ("˚", false)
            case .not_sign:
                ("¬", false)
            case .omega:
                ("Ω", false)
            case .almost_equal:
                ("≈", false)
            case .c_with_cedilla:
                ("ç", false)
            case .square_root:
                ("√", false)
            case .integral:
                ("∫", false)
            case .small_tilde:
                ("◌̃", false)
            case .mu:
                ("µ", false)
            }
            
        }
        
    }
    enum ShiftOptionSymbols: String, CaseIterable, Codable {
        
        // with symbols
        case em_dash // — (hyphen+option+shift)
        case plus_minus // ± (equal+option+shift)
        
        case right_double_quotation_mark // ” (open_bracket+option+shift)
        case right_single_quotation_mark // ’ (close_bracket+option+shift)
        case right_pointing_double_angle_quotation_mark // » (backslash+option+shift)
        
        case capital_u_with_acute // Ú (semicolon+option+shift)
        case capital_ae_ligature // Æ (quote+option+shift)
        case macron // ¯ (comma+option+shift) マクロン:数学で平均値や平均を表現する
        case breve // ˘ (period+option+shift)
        case inverted_question_mark // ¿ (slash+option+shift)
        case only_grave_accent // ` (iso: non_us_backslash + option+shift, jis: international1 + option + shift)
        
        // numbers
        case fraction_slash // ⁄ (1+shift+option) 分数に使われるスラッシュらしい。19へぇ〜
        case euro // € (2+shift+option)
        case single_left_pointing_angle_quotation_mark // ‹ (3+shift+option)
        case single_right_pointing_angle_quotation_mark // › (4+shift+option)
        case fi_ligature // ﬁ (5+shift+option)
        case fl_ligature // ﬂ (6+shift+option)
        case double_dagger // ‡ (7+shift+option)
        case degree // ° (8+shift+option)
        case middle_dot // · (9+shift+option)
        case single_low_9_quotation_mark // ‚ (0+shift+option)
        
        // with letter
        case capital_oe_ligature // Œ (q+shift+option)
        case double_low_9_quotation_mark // „ (w+shift+option)
        case acute_accent_ // ´ (e+option+shift) //Pokémonのアクセント記号
        case caron // ˇ (t+shift+option)
        case capital_a_acute // Á (y+shift+option)
        case only_diaeresis // ¨ (u+option+shift) 二重母音ではないことを示す記号
        case only_circumflex // ˆ (i+option+shift)
        case capital_o_with_stroke // Ø (o+shift+option)
        case capital_pi // ∏ (p+shift+option)
        case capital_i_with_circumflex // Î (d+shift+option)
        case capital_i_with_diaeresis // Ï (f+shift+option)
        case double_acute_accent // ˝ (g+shift+option)
        case capital_o_with_acute_accent // Ó (h+shift+option)
        case capital_o_with_circumflex // Ô (j+shift+option)
        case capital_o_with_grave // Ò (l+shift+option)
        case lozenge // ◊ (v+shift+option)
        case i_dotless // ı (b+shift+option)
        case only_small_tilde // ˜ (n+option+shift)
        case capital_a_with_circumflex // Â (m+shift+option)
        
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            switch self {
            case .em_dash:
                KeycodeInfo(keyCodeString: "hyphen", includeShift: true, includeOption: true)
            case .plus_minus:
                KeycodeInfo(keyCodeString: "equal_sign", includeShift: true, includeOption: true)
            case .right_double_quotation_mark:
                KeycodeInfo(keyCodeString: "open_bracket", includeShift: true, includeOption: true)

            case .right_single_quotation_mark:
                KeycodeInfo(keyCodeString: "close_bracket", includeShift: true, includeOption: true)
            case .right_pointing_double_angle_quotation_mark:
                KeycodeInfo(keyCodeString: "backslash", includeShift: true, includeOption: true)
            case .capital_u_with_acute:
                KeycodeInfo(keyCodeString: "semicolon", includeShift: true, includeOption: true)
            case .capital_ae_ligature:
                KeycodeInfo(keyCodeString: "quote", includeShift: true, includeOption: true)
            case .macron:
                KeycodeInfo(keyCodeString: "comma", includeShift: true, includeOption: true)
            case .breve:
                KeycodeInfo(keyCodeString: "period", includeShift: true, includeOption: true)
            case .inverted_question_mark:
                KeycodeInfo(keyCodeString: "slash", includeShift: true, includeOption: true)
            case .only_grave_accent:
                KeycodeInfoCollection(
                    KeycodeInfo(keyCodeString: "grave_accent_and_tilde"),
                    ISO: KeycodeInfo(keyCodeString: "non_us_backslash", includeShift: true, includeOption: true),
                    JIS: KeycodeInfo(keyCodeString: "international1", includeShift: true, includeOption: true)
                ).keycodeInfo(region)
                
                
            case .fraction_slash:
                KeycodeInfo(keyCodeString: "1", includeShift: true, includeOption: true)
            case .euro:
                KeycodeInfo(keyCodeString: "2", includeShift: true, includeOption: true)
            case .single_left_pointing_angle_quotation_mark:
                KeycodeInfo(keyCodeString: "3", includeShift: true, includeOption: true)
            case .single_right_pointing_angle_quotation_mark:
                KeycodeInfo(keyCodeString: "4", includeShift: true, includeOption: true)
            case .fi_ligature:
                KeycodeInfo(keyCodeString: "5", includeShift: true, includeOption: true)
            case .fl_ligature:
                KeycodeInfo(keyCodeString: "6", includeShift: true, includeOption: true)
            case .double_dagger:
                KeycodeInfo(keyCodeString: "7", includeShift: true, includeOption: true)
            case .degree:
                KeycodeInfo(keyCodeString: "8", includeShift: true, includeOption: true)
            case .middle_dot:
                KeycodeInfo(keyCodeString: "9", includeShift: true, includeOption: true)
            case .single_low_9_quotation_mark:
                KeycodeInfo(keyCodeString: "0", includeShift: true, includeOption: true)
                
            case .capital_oe_ligature:
                KeycodeInfo(keyCodeString: "q", includeShift: true, includeOption: true)
            case .double_low_9_quotation_mark:
                KeycodeInfo(keyCodeString: "w", includeShift: true, includeOption: true)
            case .acute_accent_:
                KeycodeInfo(keyCodeString: "e", includeShift: true, includeOption: true)
            case .caron:
                KeycodeInfo(keyCodeString: "t", includeShift: true, includeOption: true)
            case .capital_a_acute:
                KeycodeInfo(keyCodeString: "y", includeShift: true, includeOption: true)
            case .only_diaeresis:
                KeycodeInfo(keyCodeString: "u", includeShift: true, includeOption: true)
            case .only_circumflex:
                KeycodeInfo(keyCodeString: "i", includeShift: true, includeOption: true)
            case .capital_o_with_stroke:
                KeycodeInfo(keyCodeString: "o", includeShift: true, includeOption: true)
            case .capital_pi:
                KeycodeInfo(keyCodeString: "p", includeShift: true, includeOption: true)
            case .capital_i_with_circumflex:
                KeycodeInfo(keyCodeString: "d", includeShift: true, includeOption: true)
            case .capital_i_with_diaeresis:
                KeycodeInfo(keyCodeString: "f", includeShift: true, includeOption: true)
            case .double_acute_accent:
                KeycodeInfo(keyCodeString: "g", includeShift: true, includeOption: true)
            case .capital_o_with_acute_accent:
                KeycodeInfo(keyCodeString: "h", includeShift: true, includeOption: true)
            case .capital_o_with_circumflex:
                KeycodeInfo(keyCodeString: "j", includeShift: true, includeOption: true)
            case .capital_o_with_grave:
                KeycodeInfo(keyCodeString: "l", includeShift: true, includeOption: true)
            case .lozenge:
                KeycodeInfo(keyCodeString: "v", includeShift: true, includeOption: true)
            case .i_dotless:
                KeycodeInfo(keyCodeString: "b", includeShift: true, includeOption: true)
            case .only_small_tilde:
                KeycodeInfo(keyCodeString: "n", includeShift: true, includeOption: true)
            case .capital_a_with_circumflex:
                KeycodeInfo(keyCodeString: "m", includeShift: true, includeOption: true)
            }
        }
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            switch self {
            case .em_dash:
                ("—", false)
            case .plus_minus:
                ("±", false)
            case .right_double_quotation_mark:
                ("”", false)
            case .right_single_quotation_mark:
                ("’", false)
            case .right_pointing_double_angle_quotation_mark:
                ("»", false)
            case .capital_u_with_acute:
                ("Ú", false)
            case .capital_ae_ligature:
                ("Æ", false)
            case .macron:
                ("¯", false)
            case .breve:
                ("˘", false)
            case .inverted_question_mark:
                ("¿", false)
            case .only_grave_accent:
                ("`", false)
            case .fraction_slash:
                ("⁄", false)
            case .euro:
                ("€", false)
            case .single_left_pointing_angle_quotation_mark:
                ("‹", false)
            case .single_right_pointing_angle_quotation_mark:
                ("›", false)
            case .fi_ligature:
                ("ﬁ", false)
            case .fl_ligature:
                ("ﬂ", false)
            case .double_dagger:
                ("‡", false)
            case .degree:
                ("°", false)
            case .middle_dot:
                ("·", false)
            case .single_low_9_quotation_mark:
                ("‚", false)
            case .capital_oe_ligature:
                ("Œ", false)
            case .double_low_9_quotation_mark:
                ("„", false)
            case .acute_accent_:
                ("´", false)
            case .caron:
                ("ˇ", false)
            case .capital_a_acute:
                ("Á", false)
            case .only_diaeresis:
                ("¨", false)
            case .only_circumflex:
                ("ˆ", false)
            case .capital_o_with_stroke:
                ("Ø", false)
            case .capital_pi:
                ("∏", false)
            case .capital_i_with_circumflex:
                ("Î", false)
            case .capital_i_with_diaeresis:
                ("Ï", false)
            case .double_acute_accent:
                ("˝", false)
            case .capital_o_with_acute_accent:
                ("Ó", false)
            case .capital_o_with_circumflex:
                ("Ô", false)
            case .capital_o_with_grave:
                ("Ò", false)
            case .lozenge:
                ("◊", false)
            case .i_dotless:
                ("ı", false)
            case .only_small_tilde:
                ("˜", false)
            case .capital_a_with_circumflex:
                ("Â", false)
            }
        }
    }
    enum ArrowKeys: String, CaseIterable, Codable {
        case up_arrow
        case down_arrow
        case left_arrow
        case right_arrow
        case page_up
        case page_down
        case home
        case end
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            KeycodeInfo(keyCodeString: self.rawValue)
        }
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            switch self {
            case .up_arrow: ("arrowtriangle.up.fill", true)
            case .down_arrow: ("arrowtriangle.down.fill", true)
            case .left_arrow: ("arrowtriangle.left.fill", true)
            case .right_arrow: ("arrowtriangle.right.fill", true)
            case .page_up: ("arrow.up", true)
            case .page_down: ("arrow.down", true)
            case .home: ("arrow.up.to.line", true)
            case .end: ("arrow.down.to.line", true)
            }
        }
    }
   
    
    enum FunctionKeys: String, CaseIterable, Codable {
        case f1, f2, f3, f4, f5, f6, f7, f8
        case f9, f10, f11, f12, f13, f14, f15, f16
        case f17, f18, f19, f20
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            KeycodeInfo(keyCodeString: self.rawValue)
        }
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            (self.rawValue.capitalized, false)
        }
    }
    
    enum MediaControls: String, CaseIterable, Codable {
        case display_brightness_decrement, display_brightness_increment
        case mission_control, spotlight, dictation, launchpad
        case dashboard
        case illumination_up, illumination_down
        case rewind, play_or_pause, fast_forward, mute, volume_decrement, volume_incremnt
        case lock_key_on_magic_keyboard_without_touch_id
        case eject
        case brightness_down, brightness_up
        case scan_previous_track, scan_next_track
        
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            switch self {
            case .display_brightness_decrement:
                KeycodeInfo(functionType: .consumer, keyCodeString: "display_brightness_decrement")
            case .display_brightness_increment:
                KeycodeInfo(functionType: .consumer, keyCodeString: "display_brightness_increment")
            case .mission_control:
                KeycodeInfo(functionType: .appleVendorKeyboard, keyCodeString: "mission_control")
            case .spotlight:
                KeycodeInfo(functionType: .appleVendorKeyboard, keyCodeString: "spotlight")
            case .dictation:
                KeycodeInfo(functionType: .consumer, keyCodeString: "dictation")
            case .launchpad:
                KeycodeInfo(functionType: .appleVendorKeyboard, keyCodeString: "launchpad")
            case .dashboard:
                KeycodeInfo(functionType: .appleVendorKeyboard, keyCodeString: "dashboard")// Launchpadとの違いはわからない
            case .illumination_up:
                KeycodeInfo(functionType: .appleVendorTopCase, keyCodeString: "illumination_up")
            case .illumination_down:
                KeycodeInfo(functionType: .appleVendorTopCase, keyCodeString: "illumination_down")
            case .rewind:
                KeycodeInfo(functionType: .consumer, keyCodeString: "rewind")
            case .play_or_pause:
                KeycodeInfo(functionType: .consumer, keyCodeString: "play_or_pause")
            case .fast_forward:
                KeycodeInfo(functionType: .consumer, keyCodeString: "fast_forward")
            case .mute:
                KeycodeInfo(functionType: .consumer, keyCodeString: "mute")
            case .volume_decrement:
                KeycodeInfo(functionType: .consumer, keyCodeString: "volume_decrement")
            case .volume_incremnt:
                KeycodeInfo(functionType: .consumer, keyCodeString: "volume_increment")
            case .lock_key_on_magic_keyboard_without_touch_id:
                KeycodeInfo(functionType: .consumer, keyCodeString: "al_terminal_lock_or_screensaver")
            case .eject:
                KeycodeInfo(functionType: .consumer, keyCodeString: "eject")
            case .brightness_down:
                KeycodeInfo(functionType: .appleVendorTopCase, keyCodeString: "brightness_down")
            case .brightness_up:
                KeycodeInfo(functionType: .appleVendorTopCase, keyCodeString: "brightness_up")
            case .scan_previous_track:
                KeycodeInfo(functionType: .appleVendorTopCase, keyCodeString: "scan_previous_track")
            case .scan_next_track:
                KeycodeInfo(functionType: .appleVendorTopCase, keyCodeString: "scan_next_track")
            }
        }
        
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            switch self {
            case .display_brightness_decrement:
                ("sun.min.fill", true)
            case .display_brightness_increment:
                ("sun.max.fill", true)
            case .mission_control:
                ("rectangle.3.group", true)
            case .spotlight:
                ("magnifyingglass", true)
            case .dictation:
                ("microphone", true)
            case .launchpad:
                ("square.grid.3x2", true)
            case .dashboard:
                ("square.grid.3x2", true)
            case .illumination_up:
                ("light.max", true)
            case .illumination_down:
                ("light.min", true)
            case .rewind:
                ("backward", true)
            case .play_or_pause:
                ("playpause", true)
            case .fast_forward:
                ("forward", true)
            case .mute:
                ("speaker.slash", true)
            case .volume_decrement:
                ("speaker.wave.1", true)
            case .volume_incremnt:
                ("speaker.wave.3", true)
            case .lock_key_on_magic_keyboard_without_touch_id:
                ("lock", true)
            case .eject:
                ("eject", true)
            case .brightness_down:
                ("sun.min.fill", true)
            case .brightness_up:
                ("sun.max.fill", true)
            case .scan_previous_track:
                ("scan prev", false) // CDの読み込みとかに使えるのかな？
            case .scan_next_track:
                ("scan next", false)
            }
        }
        
        
    }
    
        
    enum KeysInPCKeyboards: String, CaseIterable, Codable {
        case print_screen, scroll_lock, pause, insert, application, help, power
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            KeycodeInfo(keyCodeString: self.rawValue)
        }
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            switch self {
            case .print_screen:
                ("printer", true)
            case .scroll_lock:
                ("scroll lock", false)
            case .pause:
                ("pause", false)
            case .insert:
                ("text.insert", true)
            case .application:
                ("filemenu.and.selection", true)
            case .help:
                ("questionmark.circle", true)
            case .power:
                ("power", true)
            }
        }
        
    }
    
    enum InternationalKeys: String, CaseIterable, Codable {
        case international1, international3
        case lang1, lang2
        
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            KeycodeInfo(keyCodeString: self.rawValue)
        }
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            switch self {
            case .international1:
                ("_", false)
            case .international3:
                ("\\", false)
            case .lang1:
                ("lang1", false)
            case .lang2:
                ("lang2", false)
            }
        }
    }
    
    enum Japanese: String, CaseIterable, Codable {
        case eisuu, kana
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            switch self {
            case .eisuu:
                KeycodeInfo(keyCodeString: "japanese_eisuu")
            case .kana:
                KeycodeInfo(keyCodeString: "japanese_kana")
            }
        }
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            switch self {
            case .eisuu:
                ("英数", false)
            case .kana:
                ("かな", false)
            }
        }
    }
        
    
    
    enum MouseKeys: String, CaseIterable, Codable {
        case mouse_up_slow, mouse_up, mouse_up_fast
        case mouse_down_slow, mouse_down, mouse_down_fast
        case mouse_left_slow, mouse_left, mouse_left_fast
        case mouse_right_slow, mouse_right, mouse_right_fast
        case scroll_up_slow, scroll_up, scroll_up_fast
        case scroll_down_slow, scroll_down, scroll_down_fast
        case scroll_left_slow, scroll_left, scroll_left_fast
        case scroll_right_slow, scroll_right, scroll_right_fast
        case speed_multiplier0125, speed_multiplier025, speed_multiplier05, speed_multiplier2
        
        //mousekey
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            switch self {
            case .mouse_up_slow:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"y\": -768 }")
            case .mouse_up:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"y\": -1536 }")
            case .mouse_up_fast:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"y\": -3072 }")
            case .mouse_down_slow:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"y\": 768 }")
            case .mouse_down:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"y\": 1536 }")
            case .mouse_down_fast:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"y\": 3072 }")
            case .mouse_left_slow:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"x\": -768 }")
            case .mouse_left:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"x\": -1536 }")
            case .mouse_left_fast:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"x\": -3072 }")
            case .mouse_right_slow:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"x\": 768 }")
            case .mouse_right:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"x\": 1536 }")
            case .mouse_right_fast:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"x\": 3072 }")
            case .scroll_up_slow:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"vertical_wheel\": -16 }")
            case .scroll_up:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"vertical_wheel\": -32 }")
            case .scroll_up_fast:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"vertical_wheel\": -64 }")
            case .scroll_down_slow:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"vertical_wheel\": 16 }")
            case .scroll_down:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"vertical_wheel\": 32 }")
            case .scroll_down_fast:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"vertical_wheel\": 64 }")
            case .scroll_left_slow:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"horizontal_wheel\": 16 }")
            case .scroll_left:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"horizontal_wheel\": 32 }")
            case .scroll_left_fast:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"horizontal_wheel\": 64 }")
            case .scroll_right_slow:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"horizontal_wheel\": -16 }")
            case .scroll_right:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"horizontal_wheel\": -32 }")
            case .scroll_right_fast:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"horizontal_wheel\": -64 }")
            case .speed_multiplier0125:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"speed_multiplier\": 0.125 }")
            case .speed_multiplier025:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"speed_multiplier\": 0.25 }")
            case .speed_multiplier05:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"speed_multiplier\": 0.5 }")
            case .speed_multiplier2:
                KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"speed_multiplier\": 2 }")
            }
        }
        
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            switch self {
            case .mouse_up_slow:
                ("cursorarrow.motionlines", true)
            case .mouse_up:
                ("cursorarrow.motionlines", true)
            case .mouse_up_fast:
                ("cursorarrow.motionlines", true)
            case .mouse_down_slow:
                ("cursorarrow.motionlines", true)
            case .mouse_down:
                ("cursorarrow.motionlines", true)
            case .mouse_down_fast:
                ("cursorarrow.motionlines", true)
            case .mouse_left_slow:
                ("cursorarrow.motionlines", true)
            case .mouse_left:
                ("cursorarrow.motionlines", true)
            case .mouse_left_fast:
                ("cursorarrow.motionlines", true)
            case .mouse_right_slow:
                ("cursorarrow.motionlines", true)
            case .mouse_right:
                ("cursorarrow.motionlines", true)
            case .mouse_right_fast:
                ("cursorarrow.motionlines", true)
            case .scroll_up_slow:
                ("hand.point.up.left.and.text", true)
            case .scroll_up:
                ("hand.point.up.left.and.text", true)
            case .scroll_up_fast:
                ("hand.point.up.left.and.text", true)
            case .scroll_down_slow:
                ("hand.point.up.left.and.text", true)
            case .scroll_down:
                ("hand.point.up.left.and.text", true)
            case .scroll_down_fast:
                ("hand.point.up.left.and.text", true)
            case .scroll_left_slow:
                ("hand.point.up.left.and.text", true)
            case .scroll_left:
                ("hand.point.up.left.and.text", true)
            case .scroll_left_fast:
                ("hand.point.up.left.and.text", true)
            case .scroll_right_slow:
                ("hand.point.up.left.and.text", true)
            case .scroll_right:
                ("hand.point.up.left.and.text", true)
            case .scroll_right_fast:
                ("hand.point.up.left.and.text", true)
            case .speed_multiplier0125:
                ("tachometer", true)
            case .speed_multiplier025:
                ("tachometer", true)
            case .speed_multiplier05:
                ("tachometer", true)
            case .speed_multiplier2:
                ("tachometer", true)
            }
        }
    }
    
    enum SoftwareFunction: String, CaseIterable, Codable {
        case CGEvent_double_click_left, CGEvent_double_click_right, CGEvent_double_click_center
        case set_mouse_cursor_position_to_origin_of_the_first_screen
        case set_mouse_cursor_position_to_center_of_the_first_screen
        case set_mouse_cursor_position_to_origin_of_the_second_screen
        case set_mouse_cursor_position_to_center_of_the_second_screen
        case sleep
        
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            switch self {
            case .CGEvent_double_click_left:
                KeycodeInfo(functionType: .software, keyCodeString: "{ \"cg_event_double_click\": { \"button\": 0 } }")
            case .CGEvent_double_click_right:
                KeycodeInfo(functionType: .software, keyCodeString: "{ \"cg_event_double_click\": { \"button\": 1 } }")
            case .CGEvent_double_click_center:
                KeycodeInfo(functionType: .software, keyCodeString: "{ \"cg_event_double_click\": { \"button\": 2 } }")
            case .set_mouse_cursor_position_to_origin_of_the_first_screen:
                KeycodeInfo(functionType: .software, keyCodeString: "{\"set_mouse_cursor_position\": {\"screen\": 0,\"x\": 0,\"y\": 0}}")
            case .set_mouse_cursor_position_to_center_of_the_first_screen:
                KeycodeInfo(functionType: .software, keyCodeString: "{\"set_mouse_cursor_position\": {\"screen\": 0,\"x\": \"50%\",\"y\": \"50%\" }}")
            case .set_mouse_cursor_position_to_origin_of_the_second_screen:
                KeycodeInfo(functionType: .software, keyCodeString: "{\"set_mouse_cursor_position\": {\"screen\": 1,\"x\": 0,\"y\": 0}}")
            case .set_mouse_cursor_position_to_center_of_the_second_screen:
                KeycodeInfo(functionType: .software, keyCodeString: "{\"set_mouse_cursor_position\": {\"screen\": 1,\"x\": \"50%\",\"y\": \"50%\" }}")
            case .sleep:
                KeycodeInfo(functionType: .software, keyCodeString: "{ \"iokit_power_management_sleep_system\": {} }")
            }
        }
        
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            switch self {
            case .CGEvent_double_click_left:
                ("cursorarrow.click.2", true)
            case .CGEvent_double_click_right:
                ("cursorarrow.click.2", true)
            case .CGEvent_double_click_center:
                ("cursorarrow.click.2", true)
            case .set_mouse_cursor_position_to_origin_of_the_first_screen:
                ("dot.scope.display", true)
            case .set_mouse_cursor_position_to_center_of_the_first_screen:
                ("dot.scope.display", true)
            case .set_mouse_cursor_position_to_origin_of_the_second_screen:
                ("dot.scope.display", true)
            case .set_mouse_cursor_position_to_center_of_the_second_screen:
                ("dot.scope.display", true)
            case .sleep:
                ("powersleep", true)
            }
        }
    }
    
    enum ApplicationLaunchKeys: String, CaseIterable, Codable {
        case al_consumer_control_configuration // Music
        case al_word_processor // Pages
        case al_text_editor // TextEdit
        case al_spreadsheet // numbers
        case al_presentation_app // Keynote
        case al_email_reader // Mail
        case al_calculator // Calculator
        case al_local_machine_browser // Finder
        case al_internet_browser // Safari
        case al_dictionalry // Dictionary
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            switch self {
            case .al_consumer_control_configuration:
                KeycodeInfo(functionType: .consumer, keyCodeString: "al_consumer_control_configuration")
            case .al_word_processor:
                KeycodeInfo(functionType: .consumer, keyCodeString: "al_word_processor")
            case .al_text_editor:
                KeycodeInfo(functionType: .consumer, keyCodeString: "al_text_editor")
            case .al_spreadsheet:
                KeycodeInfo(functionType: .consumer, keyCodeString: "al_spreadsheet")
            case .al_presentation_app:
                KeycodeInfo(functionType: .consumer, keyCodeString: "al_presentation_app")
            case .al_email_reader:
                KeycodeInfo(functionType: .consumer, keyCodeString: "al_email_reader")
            case .al_calculator:
                KeycodeInfo(functionType: .consumer, keyCodeString: "al_calculator")
            case .al_local_machine_browser:
                KeycodeInfo(functionType: .consumer, keyCodeString: "al_local_machine_browser")
            case .al_internet_browser:
                KeycodeInfo(functionType: .consumer, keyCodeString: "al_internet_browser")
            case .al_dictionalry:
                KeycodeInfo(functionType: .consumer, keyCodeString: "al_dictionary")
            }
        }
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            switch self {
            case .al_consumer_control_configuration:
                ("Music", false)
            case .al_word_processor:
                ("Pages", false)
            case .al_text_editor:
                ("TextEdit", false)
            case .al_spreadsheet:
                ("Numbers", false)
            case .al_presentation_app:
                ("Kenote", false)
            case .al_email_reader:
                ("Mail", false)
            case .al_calculator:
                ("Calc", false)
            case .al_local_machine_browser:
                ("Finder", false)
            case .al_internet_browser:
                ("safari", false)
            case .al_dictionalry:
                ("Dictio", false)
            }
        }
                
        
    }
    
    enum Others: String, CaseIterable, Codable {
        case expose_desktop, language
        case apple_top_case_display_brightness_decrement, apple_top_case_display_brightness_increment
        case video_mirror
        case illumination_toggle, illumination_decrement, illumination_increment // keyboard ilumination
        func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
            switch self {
            case .expose_desktop:
                KeycodeInfo(functionType: .appleVendorKeyboard, keyCodeString: "expose_desktop")
            case .language:
                KeycodeInfo(functionType: .appleVendorKeyboard, keyCodeString: "language")
            case .apple_top_case_display_brightness_decrement:
                KeycodeInfo(functionType: .keyCode, keyCodeString: "apple_top_case_display_brightness_decrement")
            case .apple_top_case_display_brightness_increment:
                KeycodeInfo(functionType: .keyCode, keyCodeString: "apple_top_case_display_brightness_increment")
            case .video_mirror:
                KeycodeInfo(functionType: .appleVendorTopCase, keyCodeString: "video_mirror")
            case .illumination_toggle:
                KeycodeInfo(functionType: .appleVendorTopCase, keyCodeString: "illumination_toggle")
            case .illumination_decrement:
                KeycodeInfo(functionType: .appleVendorTopCase, keyCodeString: "illumination_decrement")
            case .illumination_increment:
                KeycodeInfo(functionType: .appleVendorTopCase, keyCodeString: "illumination_increment")
            }
        }
        func displaySymbol() -> (display: String, isSFSymbol: Bool) {
            switch self {
            case .expose_desktop:
                ("expose desctop", false)
            case .language:
                ("language", false)
            case .apple_top_case_display_brightness_decrement:
                ("sun.min.fill", true)
            case .apple_top_case_display_brightness_increment:
                ("sun.max.fill", true)
            case .video_mirror:
                ("video mirror", false)
            case .illumination_toggle:
                ("light.max", true)
            case .illumination_decrement:
                ("light.max", true)
            case .illumination_increment:
                ("light.min", true)
            }
        }
    }
}

extension ToKeycode {
    static var allKeys: [ToKeycode] { // 全てのTokeycodeを含む配列
        var cases: [ToKeycode] = []
//        cases += NotCustomizedKey.allCases.map { .not_customized_key($0) }
        cases += DisableThisKey.allCases.map { .disable_this_key($0) }
        cases += LayerKeys.allCases.map { .layer_keys($0) }
        cases += ModifierKeys.allCases.map { .modifier_keys($0) }
        cases += ControlsAndSymbols.allCases.map { .controls_and_symbols($0) }
        cases += ShiftSymbols.allCases.map { .shift_symbols($0) }
        cases += OptionSymbols.allCases.map { .option_symbols($0) }
        cases += ShiftOptionSymbols.allCases.map { .shift_option_symbols($0) }
        cases += ArrowKeys.allCases.map { .arrow_keys($0) }
        cases += LetterKeys.allCases.map { .letter_keys($0) }
        cases += NumberKeys.allCases.map { .number_keys($0) }
        cases += FunctionKeys.allCases.map { .function_keys($0) }
        cases += MediaControls.allCases.map { .media_controls($0) }
        cases += KeypadKeys.allCases.map { .keypad_keys($0) }
        cases += KeysInPCKeyboards.allCases.map { .keys_in_pc_keyboards($0) }
        cases += InternationalKeys.allCases.map { .international_keys($0) }
        cases += Japanese.allCases.map { .japanese($0) }
        cases += MouseButtons.allCases.map { .mouse_buttons($0) }
        cases += MouseKeys.allCases.map { .mouse_keys($0) }
        cases += SoftwareFunction.allCases.map { .software_function($0) }
        cases += ApplicationLaunchKeys.allCases.map { .application_launch_keys($0) }
        cases += Others.allCases.map { .others($0) }
        
        return cases
    }
}

enum KeyCodeFunctionType: String {//jsonでいうキーコード本体と対になる値。文字列は.rawValueで呼び出せる。
    case appleVendorKeyboard = "apple_vendor_keyboard_key_code"
    case appleVendorTopCase = "apple_vendor_top_case_key_code"
    case consumer = "consumer_key_code"
    case keyCode = "key_code"
    case setVariable = "set_variable"
    case mouse = "mouse_key"
    case pointing = "pointing_button"
    case software = "software_function"
    case generic_desktop = "generic_desktop"
}
struct KeycodeInfoCollection {
    let ANSI: KeycodeInfo
    let ISO: KeycodeInfo
    let JIS: KeycodeInfo

    init(_ ANSI: KeycodeInfo, ISO: KeycodeInfo? = nil, JIS: KeycodeInfo? = nil) {
        self.ANSI = ANSI
        self.ISO = ISO ?? ANSI
        self.JIS = JIS ?? ANSI
    }
    func keycodeInfo(_ keycodeRegion: KeycodeRegion) -> KeycodeInfo {
        switch keycodeRegion {
        case .ANSI:
            self.ANSI
        case .ISO:
            self.ISO
        case .JIS:
            self.JIS
        }
    }
}

struct KeycodeInfo {
    let functionType: KeyCodeFunctionType
    let keyCodeString: String
    
    let includeShift: Bool
    let includeCommand: Bool
    let includeOption: Bool
    let includeControl: Bool
    let includeFn: Bool
    
    init(functionType: KeyCodeFunctionType = .keyCode, keyCodeString: String, includeShift: Bool = false, includeCommand: Bool = false, includeOption: Bool = false, includeControl: Bool = false, includeFn: Bool = false) {
        self.functionType = functionType
        self.keyCodeString = keyCodeString
        self.includeShift = includeShift
        self.includeCommand = includeCommand
        self.includeOption = includeOption
        self.includeControl = includeControl
        self.includeFn = includeFn
    }
}

///KeycodeList
///ANSI・ISO・JISの三種類でキーコードが違うことがあったりするのでそれらを網羅する構造体
///
//struct KeycodeList {
//    static let ANSI: [String: KeycodeInfo] = [
//        //keyOutput: (functionType,KeyCodeString)
//        
//        "none": KeycodeInfo(functionType: .keyCode, keyCodeString: "vk_none"),
//        "vk_none": KeycodeInfo(functionType: .keyCode, keyCodeString: "vk_none"),
//        //BasicKeys
//            //Alphabet
//        "a": KeycodeInfo(functionType: .keyCode, keyCodeString: "a"),
//        "b": KeycodeInfo(functionType: .keyCode, keyCodeString: "b"),
//        "c": KeycodeInfo(functionType: .keyCode, keyCodeString: "c"),
//        "d": KeycodeInfo(functionType: .keyCode, keyCodeString: "d"),
//        "e": KeycodeInfo(functionType: .keyCode, keyCodeString: "e"),
//        "f": KeycodeInfo(functionType: .keyCode, keyCodeString: "f"),
//        "g": KeycodeInfo(functionType: .keyCode, keyCodeString: "g"),
//        "h": KeycodeInfo(functionType: .keyCode, keyCodeString: "h"),
//        "i": KeycodeInfo(functionType: .keyCode, keyCodeString: "i"),
//        "j": KeycodeInfo(functionType: .keyCode, keyCodeString: "j"),
//        "k": KeycodeInfo(functionType: .keyCode, keyCodeString: "k"),
//        "l": KeycodeInfo(functionType: .keyCode, keyCodeString: "l"),
//        "m": KeycodeInfo(functionType: .keyCode, keyCodeString: "m"),
//        "n": KeycodeInfo(functionType: .keyCode, keyCodeString: "n"),
//        "o": KeycodeInfo(functionType: .keyCode, keyCodeString: "o"),
//        "p": KeycodeInfo(functionType: .keyCode, keyCodeString: "p"),
//        "q": KeycodeInfo(functionType: .keyCode, keyCodeString: "q"),
//        "r": KeycodeInfo(functionType: .keyCode, keyCodeString: "r"),
//        "s": KeycodeInfo(functionType: .keyCode, keyCodeString: "s"),
//        "t": KeycodeInfo(functionType: .keyCode, keyCodeString: "t"),
//        "u": KeycodeInfo(functionType: .keyCode, keyCodeString: "u"),
//        "v": KeycodeInfo(functionType: .keyCode, keyCodeString: "v"),
//        "w": KeycodeInfo(functionType: .keyCode, keyCodeString: "w"),
//        "x": KeycodeInfo(functionType: .keyCode, keyCodeString: "x"),
//        "y": KeycodeInfo(functionType: .keyCode, keyCodeString: "y"),
//        "z": KeycodeInfo(functionType: .keyCode, keyCodeString: "z"),
//            //Number
//        "1": KeycodeInfo(functionType: .keyCode, keyCodeString: "1"),
//        "2": KeycodeInfo(functionType: .keyCode, keyCodeString: "2"),
//        "3": KeycodeInfo(functionType: .keyCode, keyCodeString: "3"),
//        "4": KeycodeInfo(functionType: .keyCode, keyCodeString: "4"),
//        "5": KeycodeInfo(functionType: .keyCode, keyCodeString: "5"),
//        "6": KeycodeInfo(functionType: .keyCode, keyCodeString: "6"),
//        "7": KeycodeInfo(functionType: .keyCode, keyCodeString: "7"),
//        "8": KeycodeInfo(functionType: .keyCode, keyCodeString: "8"),
//        "9": KeycodeInfo(functionType: .keyCode, keyCodeString: "9"),
//        "0": KeycodeInfo(functionType: .keyCode, keyCodeString: "0"),
//
//        //SymbolKeys
//            //単打系
//        "`": KeycodeInfo(functionType: .keyCode, keyCodeString: "grave_accent_and_tilde"),
//        "-": KeycodeInfo(functionType: .keyCode, keyCodeString: "hyphen"),
//        "=": KeycodeInfo(functionType: .keyCode, keyCodeString: "equal_sign"),
//        "[": KeycodeInfo(functionType: .keyCode, keyCodeString: "open_bracket"),
//        "]": KeycodeInfo(functionType: .keyCode, keyCodeString: "close_bracket"),
//        "\\": KeycodeInfo(functionType: .keyCode, keyCodeString: "backslash"),
//        ";": KeycodeInfo(functionType: .keyCode, keyCodeString: "semicolon"),
//        "'": KeycodeInfo(functionType: .keyCode, keyCodeString: "quote"),
//        ",": KeycodeInfo(functionType: .keyCode, keyCodeString: "comma"),
//        ".": KeycodeInfo(functionType: .keyCode, keyCodeString: "period"),
//        "/": KeycodeInfo(functionType: .keyCode, keyCodeString: "slash"),
//            //Shift + Number
//        "!": KeycodeInfo(functionType: .keyCode, keyCodeString: "1", includeShift: true),
//        "@": KeycodeInfo(functionType: .keyCode, keyCodeString: "2", includeShift: true),
//        "#": KeycodeInfo(functionType: .keyCode, keyCodeString: "3", includeShift: true),
//        "$": KeycodeInfo(functionType: .keyCode, keyCodeString: "4", includeShift: true),
//        "%": KeycodeInfo(functionType: .keyCode, keyCodeString: "5", includeShift: true),
//        "^": KeycodeInfo(functionType: .keyCode, keyCodeString: "6", includeShift: true),
//        "&": KeycodeInfo(functionType: .keyCode, keyCodeString: "7", includeShift: true),
//        "*": KeycodeInfo(functionType: .keyCode, keyCodeString: "8", includeShift: true),
//        "(": KeycodeInfo(functionType: .keyCode, keyCodeString: "9", includeShift: true),
//        ")": KeycodeInfo(functionType: .keyCode, keyCodeString: "0", includeShift: true),
//
//            //Shift + Symbol
//        "~": KeycodeInfo(functionType: .keyCode, keyCodeString: "grave_accent_and_tilde", includeShift: true),
//        "_": KeycodeInfo(functionType: .keyCode, keyCodeString: "hyphen", includeShift: true),
//        "+": KeycodeInfo(functionType: .keyCode, keyCodeString: "equal_sign", includeShift: true),
//        "{": KeycodeInfo(functionType: .keyCode, keyCodeString: "open_bracket", includeShift: true),
//        "}": KeycodeInfo(functionType: .keyCode, keyCodeString: "close_bracket", includeShift: true),
//        "|": KeycodeInfo(functionType: .keyCode, keyCodeString: "backslash", includeShift: true),
//        ":": KeycodeInfo(functionType: .keyCode, keyCodeString: "semicolon", includeShift: true),
//        "\"": KeycodeInfo(functionType: .keyCode, keyCodeString: "quote", includeShift: true),
//        "<": KeycodeInfo(functionType: .keyCode, keyCodeString: "comma", includeShift: true),
//        ">": KeycodeInfo(functionType: .keyCode, keyCodeString: "period", includeShift: true),
//        "?": KeycodeInfo(functionType: .keyCode, keyCodeString: "slash", includeShift: true),
//        //KeypadKeys
//        "keypad_0": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_0"),
//        "keypad_1": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_1"),
//        "keypad_2": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_2"),
//        "keypad_3": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_3"),
//        "keypad_4": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_4"),
//        "keypad_5": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_5"),
//        "keypad_6": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_6"),
//        "keypad_7": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_7"),
//        "keypad_8": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_8"),
//        "keypad_9": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_9"),
//        "keypad_num_lock": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_num_lock"),
//        "keypad_slash": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_slash"),
//        "keypad_asterisk": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_asterisk"),
//        "keypad_hyphen": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_hyphen"),
//        "keypad_plus": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_plus"),
//        "keypad_equal_sign": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_equal_sign"),
//        "keypad_enter": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_enter"),
//        "keypad_comma": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_comma"),
//        "keypad_period": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_period"),
//        
//        //ControlKeys
//        "return": KeycodeInfo(functionType: .keyCode, keyCodeString: "return_or_enter"),
//        "␣": KeycodeInfo(functionType: .keyCode, keyCodeString: "spacebar"),
//        "spacebar": KeycodeInfo(functionType: .keyCode, keyCodeString: "spacebar"),
//        "tab": KeycodeInfo(functionType: .keyCode, keyCodeString: "tab"),
//        "esc": KeycodeInfo(functionType: .keyCode, keyCodeString: "escape"),
//        "BS": KeycodeInfo(functionType: .keyCode, keyCodeString: "delete_or_backspace"),
//        "Del": KeycodeInfo(functionType: .keyCode, keyCodeString: "delete_forward"),
//        "caps": KeycodeInfo(functionType: .keyCode, keyCodeString: "caps_lock"),
//
//        "↑": KeycodeInfo(functionType: .keyCode, keyCodeString: "up_arrow"),
//        "↓": KeycodeInfo(functionType: .keyCode, keyCodeString: "down_arrow"),
//        "←": KeycodeInfo(functionType: .keyCode, keyCodeString: "left_arrow"),
//        "→": KeycodeInfo(functionType: .keyCode, keyCodeString: "right_arrow"),
//        "かな": KeycodeInfo(functionType: .keyCode, keyCodeString: "japanese_kana"),
//        "英数": KeycodeInfo(functionType: .keyCode, keyCodeString: "japanese_eisuu"),
//        "変換": KeycodeInfo(functionType: .keyCode, keyCodeString: "要調査"),
//        "無変換": KeycodeInfo(functionType: .keyCode, keyCodeString: "要調査"),
//            //FullSizeKeyboard
//        "print_screen": KeycodeInfo(functionType: .keyCode, keyCodeString: "print_screen"),
//        "scroll_lock": KeycodeInfo(functionType: .keyCode, keyCodeString: "scroll_lock"),
//        "pause": KeycodeInfo(functionType: .keyCode, keyCodeString: "pause"),
//        "insert": KeycodeInfo(functionType: .keyCode, keyCodeString: "insert"),
//        "application": KeycodeInfo(functionType: .keyCode, keyCodeString: "application"),
//        "help": KeycodeInfo(functionType: .keyCode, keyCodeString: "help"),
//        "power": KeycodeInfo(functionType: .keyCode, keyCodeString: "power"),
//        "page_up": KeycodeInfo(functionType: .keyCode, keyCodeString: "page_ap"),
//        "page_down": KeycodeInfo(functionType: .keyCode, keyCodeString: "page_down"),
//        "home": KeycodeInfo(functionType: .keyCode, keyCodeString: "home"),
//        "end": KeycodeInfo(functionType: .keyCode, keyCodeString: "end"),
//        
//            //MacOS
//        "mission_control": KeycodeInfo(functionType: .appleVendorKeyboard, keyCodeString: "mission_control"),
//        "spotlight": KeycodeInfo(functionType: .appleVendorKeyboard, keyCodeString: "spotlight"),
//        "dictation": KeycodeInfo(functionType: .consumer, keyCodeString: "dictation"),
//        "launchpad": KeycodeInfo(functionType: .appleVendorKeyboard, keyCodeString: "launchpad"),
//            //Sound
//        "rewind": KeycodeInfo(functionType: .consumer, keyCodeString: "rewind"),
//        "play_or_pause": KeycodeInfo(functionType: .consumer, keyCodeString: "play_or_pause"),
//        "fast_forward": KeycodeInfo(functionType: .consumer, keyCodeString: "fast_forward"),
//        "mute": KeycodeInfo(functionType: .consumer, keyCodeString: "mute"),
//        "volume_decrement": KeycodeInfo(functionType: .consumer, keyCodeString: "volume_decrement"),
//        "volume_increment": KeycodeInfo(functionType: .consumer, keyCodeString: "volume_increment"),
//        "eject": KeycodeInfo(functionType: .consumer, keyCodeString: "eject"),
//            //Light
//        "display_brightness_increment": KeycodeInfo(functionType: .consumer, keyCodeString: "display_brightness_increment"),
//        "display_brightness_decrement": KeycodeInfo(functionType: .consumer, keyCodeString: "display_brightness_decrement"),
//        "brightness_up": KeycodeInfo(functionType: .appleVendorKeyboard, keyCodeString: "brightness_up"),
//        "brightness_down": KeycodeInfo(functionType: .appleVendorKeyboard, keyCodeString: "brightness_up"),
//        "illumination_up": KeycodeInfo(functionType: .appleVendorTopCase, keyCodeString: "illumination_up"),
//        "illumination_down": KeycodeInfo(functionType: .appleVendorTopCase, keyCodeString: "illumination_down"),
//        
//        //international
//        "international1": KeycodeInfo(functionType: .keyCode, keyCodeString: "international1"),
//        "international2": KeycodeInfo(functionType: .keyCode, keyCodeString: "international2"),
//        "international3": KeycodeInfo(functionType: .keyCode, keyCodeString: "international3"),
//        "international4": KeycodeInfo(functionType: .keyCode, keyCodeString: "international4"),
//        "international5": KeycodeInfo(functionType: .keyCode, keyCodeString: "international5"),
//        "international6": KeycodeInfo(functionType: .keyCode, keyCodeString: "international6"),
//        "international7": KeycodeInfo(functionType: .keyCode, keyCodeString: "international7"),
//        "international8": KeycodeInfo(functionType: .keyCode, keyCodeString: "international8"),
//        "international9": KeycodeInfo(functionType: .keyCode, keyCodeString: "international9"),
//        "lang1": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang1"),
//        "lang2": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang2"),
//        "lang3": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang3"),
//        "lang4": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang4"),
//        "lang5": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang5"),
//        "lang6": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang6"),
//        "lang7": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang7"),
//        "lang8": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang8"),
//        "lang9": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang9"),
//        
//        //SpecialKeys
//        "layer1": KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"layer1\",\"value\": true, \"key_up_value\": false}"),
//        "layer2": KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"layer2\",\"value\": true, \"key_up_value\": false}"),
//        "layer3": KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"layer3\",\"value\": true, \"key_up_value\": false}"),
//        "layer4": KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"layer4\",\"value\": true, \"key_up_value\": false}"),
//        "layer5": KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"layer5\",\"value\": true, \"key_up_value\": false}"),
//        "layer6": KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"layer6\",\"value\": true, \"key_up_value\": false}"),
//        "layer7": KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"layer7\",\"value\": true, \"key_up_value\": false}"),
//        "layer8": KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"layer8\",\"value\": true, \"key_up_value\": false}"),
//
//        "left_shift": KeycodeInfo(functionType: .keyCode, keyCodeString: "left_shift"),
//        "right_shift": KeycodeInfo(functionType: .keyCode, keyCodeString: "right_shift"),
//        "left_command": KeycodeInfo(functionType: .keyCode, keyCodeString: "left_command"),
//        "right_command": KeycodeInfo(functionType: .keyCode, keyCodeString: "right_command"),
//        "left_control": KeycodeInfo(functionType: .keyCode, keyCodeString: "left_control"),
//        "right_control": KeycodeInfo(functionType: .keyCode, keyCodeString: "right_control"),
//        "left_option": KeycodeInfo(functionType: .keyCode, keyCodeString: "left_option"),
//        "right_option": KeycodeInfo(functionType: .keyCode, keyCodeString: "right_option"),
//        "fn": KeycodeInfo(functionType: .appleVendorTopCase, keyCodeString: "keyboard_fn"),
//        
//        //fucntionKeys
//        "F1": KeycodeInfo(functionType: .keyCode, keyCodeString: "f1"),
//        "F2": KeycodeInfo(functionType: .keyCode, keyCodeString: "f2"),
//        "F3": KeycodeInfo(functionType: .keyCode, keyCodeString: "f3"),
//        "F4": KeycodeInfo(functionType: .keyCode, keyCodeString: "f4"),
//        "F5": KeycodeInfo(functionType: .keyCode, keyCodeString: "f5"),
//        "F6": KeycodeInfo(functionType: .keyCode, keyCodeString: "f6"),
//        "F7": KeycodeInfo(functionType: .keyCode, keyCodeString: "f7"),
//        "F8": KeycodeInfo(functionType: .keyCode, keyCodeString: "f8"),
//        "F9": KeycodeInfo(functionType: .keyCode, keyCodeString: "f9"),
//        "F10": KeycodeInfo(functionType: .keyCode, keyCodeString: "f10"),
//        "F11": KeycodeInfo(functionType: .keyCode, keyCodeString: "f11"),
//        "F12": KeycodeInfo(functionType: .keyCode, keyCodeString: "f12"),
//        "F13": KeycodeInfo(functionType: .keyCode, keyCodeString: "f13"),
//        "F14": KeycodeInfo(functionType: .keyCode, keyCodeString: "f14"),
//        "F15": KeycodeInfo(functionType: .keyCode, keyCodeString: "f15"),
//        "F16": KeycodeInfo(functionType: .keyCode, keyCodeString: "f16"),
//        "F17": KeycodeInfo(functionType: .keyCode, keyCodeString: "f17"),
//        "F18": KeycodeInfo(functionType: .keyCode, keyCodeString: "f18"),
//        "F19": KeycodeInfo(functionType: .keyCode, keyCodeString: "f19"),
//        "F20": KeycodeInfo(functionType: .keyCode, keyCodeString: "f20"),
//        "F21": KeycodeInfo(functionType: .keyCode, keyCodeString: "f21"),
//        "F22": KeycodeInfo(functionType: .keyCode, keyCodeString: "f22"),
//        "F23": KeycodeInfo(functionType: .keyCode, keyCodeString: "f23"),
//        "F24": KeycodeInfo(functionType: .keyCode, keyCodeString: "f24"),
//        //MouseKey
//        "mouse_up": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"y\": -1536 }"),
//        "mouse_up(fast)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"y\": -3072 }"),
//        "mouse_up(slow)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"y\": -768 }"),
//        "mouse_down": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"y\": 1536 }"),
//        "mouse_down(fast)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"y\": 3072 }"),
//        "mouse_down(slow)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"y\": 768 }"),
//        "mouse_left": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"x\": -1536 }"),
//        "mouse_left(fast)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"x\": -3072 }"),
//        "mouse_left(slow)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"x\": -768 }"),
//        "mouse_right": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"x\": 1536 }"),
//        "mouse_right(fast)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"x\": 3072 }"),
//        "mouse_right(slow)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"x\": 768 }"),
//            "scroll_up": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"vertical_wheel\": -32 }"),
//        "scroll_up(fast)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"vertical_wheel\": -64 }"),
//        "scroll_up(slow)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"vertical_wheel\": -16 }"),
//        "scroll_down": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"vertical_wheel\": 32 }"),
//        "scroll_down(fast)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"vertical_wheel\": 64 }"),
//        "scroll_down(slow)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"vertical_wheel\": 16 }"),
//        "scroll_left": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"horizontal_wheel\": 32 }"),
//        "scroll_left(fast)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"horizontal_wheel\": 64 }"),
//        "scroll_left(slow)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"horizontal_wheel\": 16 }"),
//        "scroll_right": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"horizontal_wheel\": -32 }"),
//        "scroll_right(fast)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"horizontal_wheel\": -64 }"),
//        "scroll_right(slow)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"horizontal_wheel\": -16 }"),
//        "speed_multi_plier(2.0)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"speed_multiplier\": 2 }"),
//        "speed_multi_plier(0.5)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"speed_multiplier\": 0.5 }"),
//        "speed_multi_plier(0.25)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"speed_multiplier\": 0.25 }"),
//        "speed_multi_plier(0.125)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"speed_multiplier\": 0.125 }"),
//        "button1": KeycodeInfo(functionType: .pointing, keyCodeString: "button1"),
//        "button2": KeycodeInfo(functionType: .pointing, keyCodeString: "button2"),
//        "button3": KeycodeInfo(functionType: .pointing, keyCodeString: "button3"),
//        "button4": KeycodeInfo(functionType: .pointing, keyCodeString: "button4"),
//        "button5": KeycodeInfo(functionType: .pointing, keyCodeString: "button5"),
//        "button6": KeycodeInfo(functionType: .pointing, keyCodeString: "button6"),
//        "button7": KeycodeInfo(functionType: .pointing, keyCodeString: "button7"),
//        "button8": KeycodeInfo(functionType: .pointing, keyCodeString: "button8"),
//        "button9": KeycodeInfo(functionType: .pointing, keyCodeString: "button9"),
//        "button10": KeycodeInfo(functionType: .pointing, keyCodeString: "button10"),
//        "button11": KeycodeInfo(functionType: .pointing, keyCodeString: "button11"),
//        "button12": KeycodeInfo(functionType: .pointing, keyCodeString: "button12"),
//        "button13": KeycodeInfo(functionType: .pointing, keyCodeString: "button13"),
//        "button14": KeycodeInfo(functionType: .pointing, keyCodeString: "button14"),
//        "button15": KeycodeInfo(functionType: .pointing, keyCodeString: "button15"),
//        "button16": KeycodeInfo(functionType: .pointing, keyCodeString: "button16"),
//        "button17": KeycodeInfo(functionType: .pointing, keyCodeString: "button17"),
//        "button18": KeycodeInfo(functionType: .pointing, keyCodeString: "button18"),
//        "button19": KeycodeInfo(functionType: .pointing, keyCodeString: "button19"),
//        "button20": KeycodeInfo(functionType: .pointing, keyCodeString: "button20"),
//        "button21": KeycodeInfo(functionType: .pointing, keyCodeString: "button21"),
//        "button22": KeycodeInfo(functionType: .pointing, keyCodeString: "button22"),
//        "button23": KeycodeInfo(functionType: .pointing, keyCodeString: "button23"),
//        "button24": KeycodeInfo(functionType: .pointing, keyCodeString: "button24"),
//        "button25": KeycodeInfo(functionType: .pointing, keyCodeString: "button25"),
//        "button26": KeycodeInfo(functionType: .pointing, keyCodeString: "button26"),
//        "button27": KeycodeInfo(functionType: .pointing, keyCodeString: "button27"),
//        "button28": KeycodeInfo(functionType: .pointing, keyCodeString: "button28"),
//        "button29": KeycodeInfo(functionType: .pointing, keyCodeString: "button29"),
//        "button30": KeycodeInfo(functionType: .pointing, keyCodeString: "button30"),
//        "button31": KeycodeInfo(functionType: .pointing, keyCodeString: "button31"),
//        "button32": KeycodeInfo(functionType: .pointing, keyCodeString: "button32"),
//        
//        //Rigion UK
//        "§_UK": KeycodeInfo(functionType: .keyCode, keyCodeString: "grave_accent_and_tilde"),
//        "`_UK": KeycodeInfo(functionType: .keyCode, keyCodeString: "non_us_backslash"),
//        //Rigion JIS
//        "^_JIS": KeycodeInfo(functionType: .keyCode, keyCodeString: "equal_sign"),
//        "@_JIS": KeycodeInfo(functionType: .keyCode, keyCodeString: "open_bracket"),
//        "[_JIS": KeycodeInfo(functionType: .keyCode, keyCodeString: "close_bracket"),
//        "]_JIS": KeycodeInfo(functionType: .keyCode, keyCodeString: "backslash"),
//        ":_JIS": KeycodeInfo(functionType: .keyCode, keyCodeString: "quote"),
//        
//
//    ]
//    
//    static let JIS: [String: KeycodeInfo] = [
//        //出力されて打たれるキー：それに対するキーコードfunctionType,KeyCodeString
//        "vk_none": KeycodeInfo(functionType: .keyCode, keyCodeString: "vk_none"),
//        //BasicKeys
//            //Alphabet
//        "a": KeycodeInfo(functionType: .keyCode, keyCodeString: "a"),
//        "b": KeycodeInfo(functionType: .keyCode, keyCodeString: "b"),
//        "c": KeycodeInfo(functionType: .keyCode, keyCodeString: "c"),
//        "d": KeycodeInfo(functionType: .keyCode, keyCodeString: "d"),
//        "e": KeycodeInfo(functionType: .keyCode, keyCodeString: "e"),
//        "f": KeycodeInfo(functionType: .keyCode, keyCodeString: "f"),
//        "g": KeycodeInfo(functionType: .keyCode, keyCodeString: "g"),
//        "h": KeycodeInfo(functionType: .keyCode, keyCodeString: "h"),
//        "i": KeycodeInfo(functionType: .keyCode, keyCodeString: "i"),
//        "j": KeycodeInfo(functionType: .keyCode, keyCodeString: "j"),
//        "k": KeycodeInfo(functionType: .keyCode, keyCodeString: "k"),
//        "l": KeycodeInfo(functionType: .keyCode, keyCodeString: "l"),
//        "m": KeycodeInfo(functionType: .keyCode, keyCodeString: "m"),
//        "n": KeycodeInfo(functionType: .keyCode, keyCodeString: "n"),
//        "o": KeycodeInfo(functionType: .keyCode, keyCodeString: "o"),
//        "p": KeycodeInfo(functionType: .keyCode, keyCodeString: "p"),
//        "q": KeycodeInfo(functionType: .keyCode, keyCodeString: "q"),
//        "r": KeycodeInfo(functionType: .keyCode, keyCodeString: "r"),
//        "s": KeycodeInfo(functionType: .keyCode, keyCodeString: "s"),
//        "t": KeycodeInfo(functionType: .keyCode, keyCodeString: "t"),
//        "u": KeycodeInfo(functionType: .keyCode, keyCodeString: "u"),
//        "v": KeycodeInfo(functionType: .keyCode, keyCodeString: "v"),
//        "w": KeycodeInfo(functionType: .keyCode, keyCodeString: "w"),
//        "x": KeycodeInfo(functionType: .keyCode, keyCodeString: "x"),
//        "y": KeycodeInfo(functionType: .keyCode, keyCodeString: "y"),
//        "z": KeycodeInfo(functionType: .keyCode, keyCodeString: "z"),
//            //Number
//        "0": KeycodeInfo(functionType: .keyCode, keyCodeString: "0"),
//        "1": KeycodeInfo(functionType: .keyCode, keyCodeString: "1"),
//        "2": KeycodeInfo(functionType: .keyCode, keyCodeString: "2"),
//        "3": KeycodeInfo(functionType: .keyCode, keyCodeString: "3"),
//        "4": KeycodeInfo(functionType: .keyCode, keyCodeString: "4"),
//        "5": KeycodeInfo(functionType: .keyCode, keyCodeString: "5"),
//        "6": KeycodeInfo(functionType: .keyCode, keyCodeString: "6"),
//        "7": KeycodeInfo(functionType: .keyCode, keyCodeString: "7"),
//        "8": KeycodeInfo(functionType: .keyCode, keyCodeString: "8"),
//        "9": KeycodeInfo(functionType: .keyCode, keyCodeString: "9"),
//        //SymbolKeys
//            //単打系
//        "`": KeycodeInfo(functionType: .keyCode, keyCodeString: "open_bracket", includeShift: true),
//        "-": KeycodeInfo(functionType: .keyCode, keyCodeString: "hyphen"),
//        "=": KeycodeInfo(functionType: .keyCode, keyCodeString: "hyphen", includeShift: true),
//        "[": KeycodeInfo(functionType: .keyCode, keyCodeString: "close_bracket"),
//        "]": KeycodeInfo(functionType: .keyCode, keyCodeString: "backslash"),
//        "\\": KeycodeInfo(functionType: .keyCode, keyCodeString: "international3"),
//        ";": KeycodeInfo(functionType: .keyCode, keyCodeString: "semicolon"),
//        "'": KeycodeInfo(functionType: .keyCode, keyCodeString: "7", includeShift: true),
//        ",": KeycodeInfo(functionType: .keyCode, keyCodeString: "comma"),
//        ".": KeycodeInfo(functionType: .keyCode, keyCodeString: "period"),
//        "/": KeycodeInfo(functionType: .keyCode, keyCodeString: "slash"),
//            //Shift + Number
//        "!": KeycodeInfo(functionType: .keyCode, keyCodeString: "1", includeShift: true),
//        "@": KeycodeInfo(functionType: .keyCode, keyCodeString: "open_bracket"),
//        "#": KeycodeInfo(functionType: .keyCode, keyCodeString: "3", includeShift: true),
//        "$": KeycodeInfo(functionType: .keyCode, keyCodeString: "4", includeShift: true),
//        "%": KeycodeInfo(functionType: .keyCode, keyCodeString: "5", includeShift: true),
//        "^": KeycodeInfo(functionType: .keyCode, keyCodeString: "equal_sign"),
//        "&": KeycodeInfo(functionType: .keyCode, keyCodeString: "6", includeShift: true),
//        "*": KeycodeInfo(functionType: .keyCode, keyCodeString: "quote", includeShift: true),
//        "(": KeycodeInfo(functionType: .keyCode, keyCodeString: "8", includeShift: true),
//        ")": KeycodeInfo(functionType: .keyCode, keyCodeString: "9", includeShift: true),
//
//            //Shift + Symbol
//        "~": KeycodeInfo(functionType: .keyCode, keyCodeString: "equal_sign", includeShift: true),
//        "_": KeycodeInfo(functionType: .keyCode, keyCodeString: "international1"),
//        "+": KeycodeInfo(functionType: .keyCode, keyCodeString: "semicolon", includeShift: true),
//        "{": KeycodeInfo(functionType: .keyCode, keyCodeString: "close_bracket", includeShift: true),
//        "}": KeycodeInfo(functionType: .keyCode, keyCodeString: "backslash", includeShift: true),
//        "|": KeycodeInfo(functionType: .keyCode, keyCodeString: "international3", includeShift: true),
//        ":": KeycodeInfo(functionType: .keyCode, keyCodeString: "quote"),
//        "\"": KeycodeInfo(functionType: .keyCode, keyCodeString: "2", includeShift: true),
//        "<": KeycodeInfo(functionType: .keyCode, keyCodeString: "comma", includeShift: true),
//        ">": KeycodeInfo(functionType: .keyCode, keyCodeString: "period", includeShift: true),
//        "?": KeycodeInfo(functionType: .keyCode, keyCodeString: "slash", includeShift: true),
//        
//        //KeypadKeys
//        "keypad_0": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_0"),
//        "keypad_1": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_1"),
//        "keypad_2": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_2"),
//        "keypad_3": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_3"),
//        "keypad_4": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_4"),
//        "keypad_5": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_5"),
//        "keypad_6": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_6"),
//        "keypad_7": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_7"),
//        "keypad_8": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_8"),
//        "keypad_9": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_9"),
//        "keypad_num_lock": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_num_lock"),
//        "keypad_slash": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_slash"),
//        "keypad_asterisk": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_asterisk"),
//        "keypad_hyphen": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_hyphen"),
//        "keypad_plus": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_plus"),
//        "keypad_equal_sign": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_equal_sign"),
//        "keypad_enter": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_enter"),
//        "keypad_comma": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_comma"),
//        "keypad_period": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_period"),
//        
//        //ControlKeys
//            //Basic
//        "return": KeycodeInfo(functionType: .keyCode, keyCodeString: "return_or_enter"),
//        "␣": KeycodeInfo(functionType: .keyCode, keyCodeString: "spacebar"),
//        "spacebar": KeycodeInfo(functionType: .keyCode, keyCodeString: "spacebar"),
//        "tab": KeycodeInfo(functionType: .keyCode, keyCodeString: "tab"),
//        "esc": KeycodeInfo(functionType: .keyCode, keyCodeString: "escape"),
//        "BS": KeycodeInfo(functionType: .keyCode, keyCodeString: "delete_or_backspace"),
//        "Del": KeycodeInfo(functionType: .keyCode, keyCodeString: "delete_forward"),
//        "caps": KeycodeInfo(functionType: .keyCode, keyCodeString: "caps_lock"),
//        
//        "↑": KeycodeInfo(functionType: .keyCode, keyCodeString: "up_arrow"),
//        "↓": KeycodeInfo(functionType: .keyCode, keyCodeString: "down_arrow"),
//        "←": KeycodeInfo(functionType: .keyCode, keyCodeString: "left_arrow"),
//        "→": KeycodeInfo(functionType: .keyCode, keyCodeString: "right_arrow"),
//        "かな": KeycodeInfo(functionType: .keyCode, keyCodeString: "japanese_kana"),
//        "英数": KeycodeInfo(functionType: .keyCode, keyCodeString: "japanese_eisuu"),
//        "変換": KeycodeInfo(functionType: .keyCode, keyCodeString: "要調査"),
//        "無変換": KeycodeInfo(functionType: .keyCode, keyCodeString: "要調査"),
//            //FullSizeKeyboard
//        "print_screen": KeycodeInfo(functionType: .keyCode, keyCodeString: "print_screen"),
//        "scroll_lock": KeycodeInfo(functionType: .keyCode, keyCodeString: "scroll_lock"),
//        "pause": KeycodeInfo(functionType: .keyCode, keyCodeString: "pause"),
//        "insert": KeycodeInfo(functionType: .keyCode, keyCodeString: "insert"),
//        "application": KeycodeInfo(functionType: .keyCode, keyCodeString: "application"),
//        "help": KeycodeInfo(functionType: .keyCode, keyCodeString: "help"),
//        "power": KeycodeInfo(functionType: .keyCode, keyCodeString: "power"),
//        
//        "page_up": KeycodeInfo(functionType: .keyCode, keyCodeString: "page_ap"),
//        "page_down": KeycodeInfo(functionType: .keyCode, keyCodeString: "page_down"),
//        "home": KeycodeInfo(functionType: .keyCode, keyCodeString: "home"),
//        "end": KeycodeInfo(functionType: .keyCode, keyCodeString: "end"),
//        
//            //MacOS
//        "mission_control": KeycodeInfo(functionType: .appleVendorKeyboard, keyCodeString: "mission_control"),
//        "spotlight": KeycodeInfo(functionType: .appleVendorKeyboard, keyCodeString: "spotlight"),
//        "dictation": KeycodeInfo(functionType: .consumer, keyCodeString: "dictation"),
//        "launchpad": KeycodeInfo(functionType: .appleVendorKeyboard, keyCodeString: "launchpad"),
//            //Sound
//        "rewind": KeycodeInfo(functionType: .consumer, keyCodeString: "rewind"),
//        "play_or_pause": KeycodeInfo(functionType: .consumer, keyCodeString: "play_or_pause"),
//        "fast_forward": KeycodeInfo(functionType: .consumer, keyCodeString: "fast_forward"),
//        "mute": KeycodeInfo(functionType: .consumer, keyCodeString: "mute"),
//        "volume_decrement": KeycodeInfo(functionType: .consumer, keyCodeString: "volume_decrement"),
//        "volume_increment": KeycodeInfo(functionType: .consumer, keyCodeString: "volume_increment"),
//        "eject": KeycodeInfo(functionType: .consumer, keyCodeString: "eject"),
//            //Light
//        "display_brightness_increment": KeycodeInfo(functionType: .consumer, keyCodeString: "display_brightness_increment"),
//        "display_brightness_decrement": KeycodeInfo(functionType: .consumer, keyCodeString: "display_brightness_decrement"),
//        "brightness_up": KeycodeInfo(functionType: .appleVendorKeyboard, keyCodeString: "brightness_up"),
//        "brightness_down": KeycodeInfo(functionType: .appleVendorKeyboard, keyCodeString: "brightness_up"),
//        "illumination_up": KeycodeInfo(functionType: .appleVendorTopCase, keyCodeString: "illumination_up"),
//        "illumination_down": KeycodeInfo(functionType: .appleVendorTopCase, keyCodeString: "illumination_down"),
//        
//        //international
//        "international1": KeycodeInfo(functionType: .keyCode, keyCodeString: "international1"),
//        "international2": KeycodeInfo(functionType: .keyCode, keyCodeString: "international2"),
//        "international3": KeycodeInfo(functionType: .keyCode, keyCodeString: "international3"),
//        "international4": KeycodeInfo(functionType: .keyCode, keyCodeString: "international4"),
//        "international5": KeycodeInfo(functionType: .keyCode, keyCodeString: "international5"),
//        "international6": KeycodeInfo(functionType: .keyCode, keyCodeString: "international6"),
//        "international7": KeycodeInfo(functionType: .keyCode, keyCodeString: "international7"),
//        "international8": KeycodeInfo(functionType: .keyCode, keyCodeString: "international8"),
//        "international9": KeycodeInfo(functionType: .keyCode, keyCodeString: "international9"),
//        "lang1": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang1"),
//        "lang2": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang2"),
//        "lang3": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang3"),
//        "lang4": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang4"),
//        "lang5": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang5"),
//        "lang6": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang6"),
//        "lang7": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang7"),
//        "lang8": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang8"),
//        "lang9": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang9"),
//        
//        //SpecialKeys
//        "layer1": KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"layer1\",\"value\": true, \"key_up_value\": false}"),
//        "layer2": KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"layer2\",\"value\": true, \"key_up_value\": false}"),
//        "layer3": KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"layer3\",\"value\": true, \"key_up_value\": false}"),
//        "layer4": KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"layer4\",\"value\": true, \"key_up_value\": false}"),
//        "layer5": KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"layer5\",\"value\": true, \"key_up_value\": false}"),
//        "layer6": KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"layer6\",\"value\": true, \"key_up_value\": false}"),
//        "layer7": KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"layer7\",\"value\": true, \"key_up_value\": false}"),
//        "layer8": KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"layer8\",\"value\": true, \"key_up_value\": false}"),
//
//        "left_shift": KeycodeInfo(functionType: .keyCode, keyCodeString: "left_shift"),
//        "right_shift": KeycodeInfo(functionType: .keyCode, keyCodeString: "right_shift"),
//        "left_command": KeycodeInfo(functionType: .keyCode, keyCodeString: "left_command"),
//        "right_command": KeycodeInfo(functionType: .keyCode, keyCodeString: "right_command"),
//        "left_control": KeycodeInfo(functionType: .keyCode, keyCodeString: "left_control"),
//        "right_control": KeycodeInfo(functionType: .keyCode, keyCodeString: "right_control"),
//        "left_option": KeycodeInfo(functionType: .keyCode, keyCodeString: "left_option"),
//        "right_option": KeycodeInfo(functionType: .keyCode, keyCodeString: "right_option"),
//        "fn": KeycodeInfo(functionType: .appleVendorTopCase, keyCodeString: "keyboard_fn"),
//        
//        //fucntionKeys
//        "F1": KeycodeInfo(functionType: .keyCode, keyCodeString: "f1"),
//        "F2": KeycodeInfo(functionType: .keyCode, keyCodeString: "f2"),
//        "F3": KeycodeInfo(functionType: .keyCode, keyCodeString: "f3"),
//        "F4": KeycodeInfo(functionType: .keyCode, keyCodeString: "f4"),
//        "F5": KeycodeInfo(functionType: .keyCode, keyCodeString: "f5"),
//        "F6": KeycodeInfo(functionType: .keyCode, keyCodeString: "f6"),
//        "F7": KeycodeInfo(functionType: .keyCode, keyCodeString: "f7"),
//        "F8": KeycodeInfo(functionType: .keyCode, keyCodeString: "f8"),
//        "F9": KeycodeInfo(functionType: .keyCode, keyCodeString: "f9"),
//        "F10": KeycodeInfo(functionType: .keyCode, keyCodeString: "f10"),
//        "F11": KeycodeInfo(functionType: .keyCode, keyCodeString: "f11"),
//        "F12": KeycodeInfo(functionType: .keyCode, keyCodeString: "f12"),
//        "F13": KeycodeInfo(functionType: .keyCode, keyCodeString: "f13"),
//        "F14": KeycodeInfo(functionType: .keyCode, keyCodeString: "f14"),
//        "F15": KeycodeInfo(functionType: .keyCode, keyCodeString: "f15"),
//        "F16": KeycodeInfo(functionType: .keyCode, keyCodeString: "f16"),
//        "F17": KeycodeInfo(functionType: .keyCode, keyCodeString: "f17"),
//        "F18": KeycodeInfo(functionType: .keyCode, keyCodeString: "f18"),
//        "F19": KeycodeInfo(functionType: .keyCode, keyCodeString: "f19"),
//        "F20": KeycodeInfo(functionType: .keyCode, keyCodeString: "f20"),
//        "F21": KeycodeInfo(functionType: .keyCode, keyCodeString: "f21"),
//        "F22": KeycodeInfo(functionType: .keyCode, keyCodeString: "f22"),
//        "F23": KeycodeInfo(functionType: .keyCode, keyCodeString: "f23"),
//        "F24": KeycodeInfo(functionType: .keyCode, keyCodeString: "f24"),
//        //MouseKey
//        "mouse_up": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"y\": -1536 }"),
//        "mouse_up(fast)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"y\": -3072 }"),
//        "mouse_up(slow)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"y\": -768 }"),
//        "mouse_down": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"y\": 1536 }"),
//        "mouse_down(fast)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"y\": 3072 }"),
//        "mouse_down(slow)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"y\": 768 }"),
//        "mouse_left": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"x\": -1536 }"),
//        "mouse_left(fast)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"x\": -3072 }"),
//        "mouse_left(slow)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"x\": -768 }"),
//        "mouse_right": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"x\": 1536 }"),
//        "mouse_right(fast)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"x\": 3072 }"),
//        "mouse_right(slow)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"x\": 768 }"),
//        "scroll_up": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"vertical_wheel\": -32 }"),
//        "scroll_up(fast)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"vertical_wheel\": -64 }"),
//        "scroll_up(slow)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"vertical_wheel\": -16 }"),
//        "scroll_down": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"vertical_wheel\": 32 }"),
//        "scroll_down(fast)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"vertical_wheel\": 64 }"),
//        "scroll_down(slow)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"vertical_wheel\": 16 }"),
//        "scroll_left": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"horizontal_wheel\": 32 }"),
//        "scroll_left(fast)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"horizontal_wheel\": 64 }"),
//        "scroll_left(slow)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"horizontal_wheel\": 16 }"),
//        "scroll_right": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"horizontal_wheel\": -32 }"),
//        "scroll_right(fast)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"horizontal_wheel\": -64 }"),
//        "scroll_right(slow)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"horizontal_wheel\": -16 }"),
//        "speed_multi_plier(2.0)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"speed_multiplier\": 2 }"),
//        "speed_multi_plier(0.5)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"speed_multiplier\": 0.5 }"),
//        "speed_multi_plier(0.25)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"speed_multiplier\": 0.25 }"),
//        "speed_multi_plier(0.125)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"speed_multiplier\": 0.125 }"),
//        "button1": KeycodeInfo(functionType: .pointing, keyCodeString: "button1"),
//        "button2": KeycodeInfo(functionType: .pointing, keyCodeString: "button2"),
//        "button3": KeycodeInfo(functionType: .pointing, keyCodeString: "button3"),
//        "button4": KeycodeInfo(functionType: .pointing, keyCodeString: "button4"),
//        "button5": KeycodeInfo(functionType: .pointing, keyCodeString: "button5"),
//        "button6": KeycodeInfo(functionType: .pointing, keyCodeString: "button6"),
//        "button7": KeycodeInfo(functionType: .pointing, keyCodeString: "button7"),
//        "button8": KeycodeInfo(functionType: .pointing, keyCodeString: "button8"),
//        "button9": KeycodeInfo(functionType: .pointing, keyCodeString: "button9"),
//        "button10": KeycodeInfo(functionType: .pointing, keyCodeString: "button10"),
//        "button11": KeycodeInfo(functionType: .pointing, keyCodeString: "button11"),
//        "button12": KeycodeInfo(functionType: .pointing, keyCodeString: "button12"),
//        "button13": KeycodeInfo(functionType: .pointing, keyCodeString: "button13"),
//        "button14": KeycodeInfo(functionType: .pointing, keyCodeString: "button14"),
//        "button15": KeycodeInfo(functionType: .pointing, keyCodeString: "button15"),
//        "button16": KeycodeInfo(functionType: .pointing, keyCodeString: "button16"),
//        "button17": KeycodeInfo(functionType: .pointing, keyCodeString: "button17"),
//        "button18": KeycodeInfo(functionType: .pointing, keyCodeString: "button18"),
//        "button19": KeycodeInfo(functionType: .pointing, keyCodeString: "button19"),
//        "button20": KeycodeInfo(functionType: .pointing, keyCodeString: "button20"),
//        "button21": KeycodeInfo(functionType: .pointing, keyCodeString: "button21"),
//        "button22": KeycodeInfo(functionType: .pointing, keyCodeString: "button22"),
//        "button23": KeycodeInfo(functionType: .pointing, keyCodeString: "button23"),
//        "button24": KeycodeInfo(functionType: .pointing, keyCodeString: "button24"),
//        "button25": KeycodeInfo(functionType: .pointing, keyCodeString: "button25"),
//        "button26": KeycodeInfo(functionType: .pointing, keyCodeString: "button26"),
//        "button27": KeycodeInfo(functionType: .pointing, keyCodeString: "button27"),
//        "button28": KeycodeInfo(functionType: .pointing, keyCodeString: "button28"),
//        "button29": KeycodeInfo(functionType: .pointing, keyCodeString: "button29"),
//        "button30": KeycodeInfo(functionType: .pointing, keyCodeString: "button30"),
//        "button31": KeycodeInfo(functionType: .pointing, keyCodeString: "button31"),
//        "button32": KeycodeInfo(functionType: .pointing, keyCodeString: "button32"),
//        
//        //Rigion UK
//        "§_UK": KeycodeInfo(functionType: .keyCode, keyCodeString: "grave_accent_and_tilde"),
//        "`_UK": KeycodeInfo(functionType: .keyCode, keyCodeString: "non_us_backslash"),
//        //Rigion JIS
//        "^_JIS": KeycodeInfo(functionType: .keyCode, keyCodeString: "equal_sign"),
//        "@_JIS": KeycodeInfo(functionType: .keyCode, keyCodeString: "open_bracket"),
//        "[_JIS": KeycodeInfo(functionType: .keyCode, keyCodeString: "close_bracket"),
//        "]_JIS": KeycodeInfo(functionType: .keyCode, keyCodeString: "backslash"),
//        ":_JIS": KeycodeInfo(functionType: .keyCode, keyCodeString: "quote"),
//    ]
//    
//    static let ISO: [String: KeycodeInfo] = [
//        //出力されて打たれるキー：それに対するキーコード(”functionType”:”KeyCodeString”)
//        "vk_none": KeycodeInfo(functionType: .keyCode, keyCodeString: "vk_none"),
//        //BasicKeys
//            //Alphabet
//        "a": KeycodeInfo(functionType: .keyCode, keyCodeString: "a"),
//        "b": KeycodeInfo(functionType: .keyCode, keyCodeString: "b"),
//        "c": KeycodeInfo(functionType: .keyCode, keyCodeString: "c"),
//        "d": KeycodeInfo(functionType: .keyCode, keyCodeString: "d"),
//        "e": KeycodeInfo(functionType: .keyCode, keyCodeString: "e"),
//        "f": KeycodeInfo(functionType: .keyCode, keyCodeString: "f"),
//        "g": KeycodeInfo(functionType: .keyCode, keyCodeString: "g"),
//        "h": KeycodeInfo(functionType: .keyCode, keyCodeString: "h"),
//        "i": KeycodeInfo(functionType: .keyCode, keyCodeString: "i"),
//        "j": KeycodeInfo(functionType: .keyCode, keyCodeString: "j"),
//        "k": KeycodeInfo(functionType: .keyCode, keyCodeString: "k"),
//        "l": KeycodeInfo(functionType: .keyCode, keyCodeString: "l"),
//        "m": KeycodeInfo(functionType: .keyCode, keyCodeString: "m"),
//        "n": KeycodeInfo(functionType: .keyCode, keyCodeString: "n"),
//        "o": KeycodeInfo(functionType: .keyCode, keyCodeString: "o"),
//        "p": KeycodeInfo(functionType: .keyCode, keyCodeString: "p"),
//        "q": KeycodeInfo(functionType: .keyCode, keyCodeString: "q"),
//        "r": KeycodeInfo(functionType: .keyCode, keyCodeString: "r"),
//        "s": KeycodeInfo(functionType: .keyCode, keyCodeString: "s"),
//        "t": KeycodeInfo(functionType: .keyCode, keyCodeString: "t"),
//        "u": KeycodeInfo(functionType: .keyCode, keyCodeString: "u"),
//        "v": KeycodeInfo(functionType: .keyCode, keyCodeString: "v"),
//        "w": KeycodeInfo(functionType: .keyCode, keyCodeString: "w"),
//        "x": KeycodeInfo(functionType: .keyCode, keyCodeString: "x"),
//        "y": KeycodeInfo(functionType: .keyCode, keyCodeString: "y"),
//        "z": KeycodeInfo(functionType: .keyCode, keyCodeString: "z"),
//            //Number
//        "1": KeycodeInfo(functionType: .keyCode, keyCodeString: "1"),
//        "2": KeycodeInfo(functionType: .keyCode, keyCodeString: "2"),
//        "3": KeycodeInfo(functionType: .keyCode, keyCodeString: "3"),
//        "4": KeycodeInfo(functionType: .keyCode, keyCodeString: "4"),
//        "5": KeycodeInfo(functionType: .keyCode, keyCodeString: "5"),
//        "6": KeycodeInfo(functionType: .keyCode, keyCodeString: "6"),
//        "7": KeycodeInfo(functionType: .keyCode, keyCodeString: "7"),
//        "8": KeycodeInfo(functionType: .keyCode, keyCodeString: "8"),
//        "9": KeycodeInfo(functionType: .keyCode, keyCodeString: "9"),
//        "0": KeycodeInfo(functionType: .keyCode, keyCodeString: "0"),
//        //SymbolKeys
//            //単打系
//        "`": KeycodeInfo(functionType: .keyCode, keyCodeString: "non_us_backslash"),
//        "-": KeycodeInfo(functionType: .keyCode, keyCodeString: "hyphen"),
//        "=": KeycodeInfo(functionType: .keyCode, keyCodeString: "equal_sign"),
//        "[": KeycodeInfo(functionType: .keyCode, keyCodeString: "open_bracket"),
//        "]": KeycodeInfo(functionType: .keyCode, keyCodeString: "close_bracket"),
//        "\\": KeycodeInfo(functionType: .keyCode, keyCodeString: "backslash"),
//        ";": KeycodeInfo(functionType: .keyCode, keyCodeString: "semicolon"),
//        "'": KeycodeInfo(functionType: .keyCode, keyCodeString: "quote"),
//        ",": KeycodeInfo(functionType: .keyCode, keyCodeString: "comma"),
//        ".": KeycodeInfo(functionType: .keyCode, keyCodeString: "period"),
//        "/": KeycodeInfo(functionType: .keyCode, keyCodeString: "slash"),
//            //Shift + Number
//        "!": KeycodeInfo(functionType: .keyCode, keyCodeString: "1", includeShift: true),
//        "@": KeycodeInfo(functionType: .keyCode, keyCodeString: "2", includeShift: true),
//        "€": KeycodeInfo(functionType: .keyCode, keyCodeString: "2", includeShift: true, includeOption: true),
//        "#": KeycodeInfo(functionType: .keyCode, keyCodeString: "3", includeShift: true),
//        "$": KeycodeInfo(functionType: .keyCode, keyCodeString: "4", includeShift: true),
//        "%": KeycodeInfo(functionType: .keyCode, keyCodeString: "5", includeShift: true),
//        "^": KeycodeInfo(functionType: .keyCode, keyCodeString: "6", includeShift: true),
//        "&": KeycodeInfo(functionType: .keyCode, keyCodeString: "7", includeShift: true),
//        "*": KeycodeInfo(functionType: .keyCode, keyCodeString: "8", includeShift: true),
//        "(": KeycodeInfo(functionType: .keyCode, keyCodeString: "9", includeShift: true),
//        ")": KeycodeInfo(functionType: .keyCode, keyCodeString: "0", includeShift: true),
//            //Shift + Symbol
//        "~": KeycodeInfo(functionType: .keyCode, keyCodeString: "non_us_backslash", includeShift: true),
//        "_": KeycodeInfo(functionType: .keyCode, keyCodeString: "hyphen", includeShift: true),
//        "+": KeycodeInfo(functionType: .keyCode, keyCodeString: "equal_sign", includeShift: true),
//        "{": KeycodeInfo(functionType: .keyCode, keyCodeString: "open_bracket", includeShift: true),
//        "}": KeycodeInfo(functionType: .keyCode, keyCodeString: "close_bracket", includeShift: true),
//        "|": KeycodeInfo(functionType: .keyCode, keyCodeString: "backslash", includeShift: true),
//        ":": KeycodeInfo(functionType: .keyCode, keyCodeString: "semicolon", includeShift: true),
//        "\"": KeycodeInfo(functionType: .keyCode, keyCodeString: "quote", includeShift: true),
//        "<": KeycodeInfo(functionType: .keyCode, keyCodeString: "comma", includeShift: true),
//        ">": KeycodeInfo(functionType: .keyCode, keyCodeString: "period", includeShift: true),
//        "?": KeycodeInfo(functionType: .keyCode, keyCodeString: "slash", includeShift: true),
//        //KeypadKeys
//        "keypad_0": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_0"),
//        "keypad_1": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_1"),
//        "keypad_2": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_2"),
//        "keypad_3": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_3"),
//        "keypad_4": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_4"),
//        "keypad_5": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_5"),
//        "keypad_6": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_6"),
//        "keypad_7": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_7"),
//        "keypad_8": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_8"),
//        "keypad_9": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_9"),
//        "keypad_num_lock": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_num_lock"),
//        "keypad_slash": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_slash"),
//        "keypad_asterisk": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_asterisk"),
//        "keypad_hyphen": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_hyphen"),
//        "keypad_plus": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_plus"),
//        "keypad_equal_sign": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_equal_sign"),
//        "keypad_enter": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_enter"),
//        "keypad_comma": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_comma"),
//        "keypad_period": KeycodeInfo(functionType: .keyCode, keyCodeString: "keypad_period"),
//        
//        //ControlKeys
//            //Basic
//        "return": KeycodeInfo(functionType: .keyCode, keyCodeString: "return_or_enter"),
//        "␣": KeycodeInfo(functionType: .keyCode, keyCodeString: "spacebar"),
//        "spacebar": KeycodeInfo(functionType: .keyCode, keyCodeString: "spacebar"),
//        "tab": KeycodeInfo(functionType: .keyCode, keyCodeString: "tab"),
//        "esc": KeycodeInfo(functionType: .keyCode, keyCodeString: "escape"),
//        "BS": KeycodeInfo(functionType: .keyCode, keyCodeString: "delete_or_backspace"),
//        "Del": KeycodeInfo(functionType: .keyCode, keyCodeString: "delete_forward"),
//        "caps": KeycodeInfo(functionType: .keyCode, keyCodeString: "caps_lock"),
//
//        "↑": KeycodeInfo(functionType: .keyCode, keyCodeString: "up_arrow"),
//        "↓": KeycodeInfo(functionType: .keyCode, keyCodeString: "down_arrow"),
//        "←": KeycodeInfo(functionType: .keyCode, keyCodeString: "left_arrow"),
//        "→": KeycodeInfo(functionType: .keyCode, keyCodeString: "right_arrow"),
//        "かな": KeycodeInfo(functionType: .keyCode, keyCodeString: "japanese_kana"),
//        "英数": KeycodeInfo(functionType: .keyCode, keyCodeString: "japanese_eisuu"),
//        "変換": KeycodeInfo(functionType: .keyCode, keyCodeString: "要調査"),
//        "無変換": KeycodeInfo(functionType: .keyCode, keyCodeString: "要調査"),
//            //FullSizeKeyboard
//        "print_screen": KeycodeInfo(functionType: .keyCode, keyCodeString: "print_screen"),
//        "scroll_lock": KeycodeInfo(functionType: .keyCode, keyCodeString: "scroll_lock"),
//        "pause": KeycodeInfo(functionType: .keyCode, keyCodeString: "pause"),
//        "insert": KeycodeInfo(functionType: .keyCode, keyCodeString: "insert"),
//        "application": KeycodeInfo(functionType: .keyCode, keyCodeString: "application"),
//        "help": KeycodeInfo(functionType: .keyCode, keyCodeString: "help"),
//        "power": KeycodeInfo(functionType: .keyCode, keyCodeString: "power"),
//        
//        "page_up": KeycodeInfo(functionType: .keyCode, keyCodeString: "page_ap"),
//        "page_down": KeycodeInfo(functionType: .keyCode, keyCodeString: "page_down"),
//        "home": KeycodeInfo(functionType: .keyCode, keyCodeString: "home"),
//        "end": KeycodeInfo(functionType: .keyCode, keyCodeString: "end"),
//        
//            //MacOS
//        "mission_control": KeycodeInfo(functionType: .appleVendorKeyboard, keyCodeString: "mission_control"),
//        "spotlight": KeycodeInfo(functionType: .appleVendorKeyboard, keyCodeString: "spotlight"),
//        "dictation": KeycodeInfo(functionType: .consumer, keyCodeString: "dictation"),
//        "launchpad": KeycodeInfo(functionType: .appleVendorKeyboard, keyCodeString: "launchpad"),
//            //Sound
//        "rewind": KeycodeInfo(functionType: .consumer, keyCodeString: "rewind"),
//        "play_or_pause": KeycodeInfo(functionType: .consumer, keyCodeString: "play_or_pause"),
//        "fast_forward": KeycodeInfo(functionType: .consumer, keyCodeString: "fast_forward"),
//        "mute": KeycodeInfo(functionType: .consumer, keyCodeString: "mute"),
//        "volume_decrement": KeycodeInfo(functionType: .consumer, keyCodeString: "volume_decrement"),
//        "volume_increment": KeycodeInfo(functionType: .consumer, keyCodeString: "volume_increment"),
//        "eject": KeycodeInfo(functionType: .consumer, keyCodeString: "eject"),
//            //Light
//        "display_brightness_increment": KeycodeInfo(functionType: .consumer, keyCodeString: "display_brightness_increment"),
//        "display_brightness_decrement": KeycodeInfo(functionType: .consumer, keyCodeString: "display_brightness_decrement"),
//        "brightness_up": KeycodeInfo(functionType: .appleVendorKeyboard, keyCodeString: "brightness_up"),
//        "brightness_down": KeycodeInfo(functionType: .appleVendorKeyboard, keyCodeString: "brightness_up"),
//        "illumination_up": KeycodeInfo(functionType: .appleVendorTopCase, keyCodeString: "illumination_up"),
//        "illumination_down": KeycodeInfo(functionType: .appleVendorTopCase, keyCodeString: "illumination_down"),
//        
//        //international
//        "international1": KeycodeInfo(functionType: .keyCode, keyCodeString: "international1"),
//        "international2": KeycodeInfo(functionType: .keyCode, keyCodeString: "international2"),
//        "international3": KeycodeInfo(functionType: .keyCode, keyCodeString: "international3"),
//        "international4": KeycodeInfo(functionType: .keyCode, keyCodeString: "international4"),
//        "international5": KeycodeInfo(functionType: .keyCode, keyCodeString: "international5"),
//        "international6": KeycodeInfo(functionType: .keyCode, keyCodeString: "international6"),
//        "international7": KeycodeInfo(functionType: .keyCode, keyCodeString: "international7"),
//        "international8": KeycodeInfo(functionType: .keyCode, keyCodeString: "international8"),
//        "international9": KeycodeInfo(functionType: .keyCode, keyCodeString: "international9"),
//        "lang1": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang1"),
//        "lang2": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang2"),
//        "lang3": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang3"),
//        "lang4": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang4"),
//        "lang5": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang5"),
//        "lang6": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang6"),
//        "lang7": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang7"),
//        "lang8": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang8"),
//        "lang9": KeycodeInfo(functionType: .keyCode, keyCodeString: "lang9"),
//        
//        //SpecialKeys
//        "layer1": KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"layer1\",\"value\": true, \"key_up_value\": false}"),
//        "layer2": KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"layer2\",\"value\": true, \"key_up_value\": false}"),
//        "layer3": KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"layer3\",\"value\": true, \"key_up_value\": false}"),
//        "layer4": KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"layer4\",\"value\": true, \"key_up_value\": false}"),
//        "layer5": KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"layer5\",\"value\": true, \"key_up_value\": false}"),
//        "layer6": KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"layer6\",\"value\": true, \"key_up_value\": false}"),
//        "layer7": KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"layer7\",\"value\": true, \"key_up_value\": false}"),
//        "layer8": KeycodeInfo(functionType: .setVariable, keyCodeString: "{\"name\": \"layer8\",\"value\": true, \"key_up_value\": false}"),
//
//
//        "left_shift": KeycodeInfo(functionType: .keyCode, keyCodeString: "left_shift"),
//        "right_shift": KeycodeInfo(functionType: .keyCode, keyCodeString: "right_shift"),
//        "left_command": KeycodeInfo(functionType: .keyCode, keyCodeString: "left_command"),
//        "right_command": KeycodeInfo(functionType: .keyCode, keyCodeString: "right_command"),
//        "left_control": KeycodeInfo(functionType: .keyCode, keyCodeString: "left_control"),
//        "right_control": KeycodeInfo(functionType: .keyCode, keyCodeString: "right_control"),
//        "left_option": KeycodeInfo(functionType: .keyCode, keyCodeString: "left_option"),
//        "right_option": KeycodeInfo(functionType: .keyCode, keyCodeString: "right_option"),
//        "fn": KeycodeInfo(functionType: .appleVendorTopCase, keyCodeString: "keyboard_fn"),
//        
//        //fucntionKeys
//        "F1": KeycodeInfo(functionType: .keyCode, keyCodeString: "f1"),
//        "F2": KeycodeInfo(functionType: .keyCode, keyCodeString: "f2"),
//        "F3": KeycodeInfo(functionType: .keyCode, keyCodeString: "f3"),
//        "F4": KeycodeInfo(functionType: .keyCode, keyCodeString: "f4"),
//        "F5": KeycodeInfo(functionType: .keyCode, keyCodeString: "f5"),
//        "F6": KeycodeInfo(functionType: .keyCode, keyCodeString: "f6"),
//        "F7": KeycodeInfo(functionType: .keyCode, keyCodeString: "f7"),
//        "F8": KeycodeInfo(functionType: .keyCode, keyCodeString: "f8"),
//        "F9": KeycodeInfo(functionType: .keyCode, keyCodeString: "f9"),
//        "F10": KeycodeInfo(functionType: .keyCode, keyCodeString: "f10"),
//        "F11": KeycodeInfo(functionType: .keyCode, keyCodeString: "f11"),
//        "F12": KeycodeInfo(functionType: .keyCode, keyCodeString: "f12"),
//        "F13": KeycodeInfo(functionType: .keyCode, keyCodeString: "f13"),
//        "F14": KeycodeInfo(functionType: .keyCode, keyCodeString: "f14"),
//        "F15": KeycodeInfo(functionType: .keyCode, keyCodeString: "f15"),
//        "F16": KeycodeInfo(functionType: .keyCode, keyCodeString: "f16"),
//        "F17": KeycodeInfo(functionType: .keyCode, keyCodeString: "f17"),
//        "F18": KeycodeInfo(functionType: .keyCode, keyCodeString: "f18"),
//        "F19": KeycodeInfo(functionType: .keyCode, keyCodeString: "f19"),
//        "F20": KeycodeInfo(functionType: .keyCode, keyCodeString: "f20"),
//        "F21": KeycodeInfo(functionType: .keyCode, keyCodeString: "f21"),
//        "F22": KeycodeInfo(functionType: .keyCode, keyCodeString: "f22"),
//        "F23": KeycodeInfo(functionType: .keyCode, keyCodeString: "f23"),
//        "F24": KeycodeInfo(functionType: .keyCode, keyCodeString: "f24"),
//        //MouseKey
//        "mouse_up": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"y\": -1536 }"),
//        "mouse_up(fast)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"y\": -3072 }"),
//        "mouse_up(slow)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"y\": -768 }"),
//        "mouse_down": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"y\": 1536 }"),
//        "mouse_down(fast)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"y\": 3072 }"),
//        "mouse_down(slow)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"y\": 768 }"),
//        "mouse_left": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"x\": -1536 }"),
//        "mouse_left(fast)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"x\": -3072 }"),
//        "mouse_left(slow)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"x\": -768 }"),
//        "mouse_right": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"x\": 1536 }"),
//        "mouse_right(fast)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"x\": 3072 }"),
//        "mouse_right(slow)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"x\": 768 }"),
//        "scroll_up": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"vertical_wheel\": -32 }"),
//        "scroll_up(fast)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"vertical_wheel\": -64 }"),
//        "scroll_up(slow)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"vertical_wheel\": -16 }"),
//        "scroll_down": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"vertical_wheel\": 32 }"),
//        "scroll_down(fast)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"vertical_wheel\": 64 }"),
//        "scroll_down(slow)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"vertical_wheel\": 16 }"),
//        "scroll_left": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"horizontal_wheel\": 32 }"),
//        "scroll_left(fast)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"horizontal_wheel\": 64 }"),
//        "scroll_left(slow)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"horizontal_wheel\": 16 }"),
//        "scroll_right": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"horizontal_wheel\": -32 }"),
//        "scroll_right(fast)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"horizontal_wheel\": -64 }"),
//        "scroll_right(slow)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"horizontal_wheel\": -16 }"),
//        "speed_multi_plier(2.0)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"speed_multiplier\": 2 }"),
//        "speed_multi_plier(0.5)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"speed_multiplier\": 0.5 }"),
//        "speed_multi_plier(0.25)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"speed_multiplier\": 0.25 }"),
//        "speed_multi_plier(0.125)": KeycodeInfo(functionType: .mouse, keyCodeString: "{ \"speed_multiplier\": 0.125 }"),
//        "button1": KeycodeInfo(functionType: .pointing, keyCodeString: "button1"),
//        "button2": KeycodeInfo(functionType: .pointing, keyCodeString: "button2"),
//        "button3": KeycodeInfo(functionType: .pointing, keyCodeString: "button3"),
//        "button4": KeycodeInfo(functionType: .pointing, keyCodeString: "button4"),
//        "button5": KeycodeInfo(functionType: .pointing, keyCodeString: "button5"),
//        "button6": KeycodeInfo(functionType: .pointing, keyCodeString: "button6"),
//        "button7": KeycodeInfo(functionType: .pointing, keyCodeString: "button7"),
//        "button8": KeycodeInfo(functionType: .pointing, keyCodeString: "button8"),
//        "button9": KeycodeInfo(functionType: .pointing, keyCodeString: "button9"),
//        "button10": KeycodeInfo(functionType: .pointing, keyCodeString: "button10"),
//        "button11": KeycodeInfo(functionType: .pointing, keyCodeString: "button11"),
//        "button12": KeycodeInfo(functionType: .pointing, keyCodeString: "button12"),
//        "button13": KeycodeInfo(functionType: .pointing, keyCodeString: "button13"),
//        "button14": KeycodeInfo(functionType: .pointing, keyCodeString: "button14"),
//        "button15": KeycodeInfo(functionType: .pointing, keyCodeString: "button15"),
//        "button16": KeycodeInfo(functionType: .pointing, keyCodeString: "button16"),
//        "button17": KeycodeInfo(functionType: .pointing, keyCodeString: "button17"),
//        "button18": KeycodeInfo(functionType: .pointing, keyCodeString: "button18"),
//        "button19": KeycodeInfo(functionType: .pointing, keyCodeString: "button19"),
//        "button20": KeycodeInfo(functionType: .pointing, keyCodeString: "button20"),
//        "button21": KeycodeInfo(functionType: .pointing, keyCodeString: "button21"),
//        "button22": KeycodeInfo(functionType: .pointing, keyCodeString: "button22"),
//        "button23": KeycodeInfo(functionType: .pointing, keyCodeString: "button23"),
//        "button24": KeycodeInfo(functionType: .pointing, keyCodeString: "button24"),
//        "button25": KeycodeInfo(functionType: .pointing, keyCodeString: "button25"),
//        "button26": KeycodeInfo(functionType: .pointing, keyCodeString: "button26"),
//        "button27": KeycodeInfo(functionType: .pointing, keyCodeString: "button27"),
//        "button28": KeycodeInfo(functionType: .pointing, keyCodeString: "button28"),
//        "button29": KeycodeInfo(functionType: .pointing, keyCodeString: "button29"),
//        "button30": KeycodeInfo(functionType: .pointing, keyCodeString: "button30"),
//        "button31": KeycodeInfo(functionType: .pointing, keyCodeString: "button31"),
//        "button32": KeycodeInfo(functionType: .pointing, keyCodeString: "button32"),
//        
//        //Rigion UK
//        "§_UK": KeycodeInfo(functionType: .keyCode, keyCodeString: "grave_accent_and_tilde"),
//        "`_UK": KeycodeInfo(functionType: .keyCode, keyCodeString: "non_us_backslash"),
//
//        //Rigion JIS
//        "^_JIS": KeycodeInfo(functionType: .keyCode, keyCodeString: "equal_sign"),
//        "@_JIS": KeycodeInfo(functionType: .keyCode, keyCodeString: "open_bracket"),
//        "[_JIS": KeycodeInfo(functionType: .keyCode, keyCodeString: "close_bracket"),
//        "]_JIS": KeycodeInfo(functionType: .keyCode, keyCodeString: "backslash"),
//        ":_JIS": KeycodeInfo(functionType: .keyCode, keyCodeString: "quote"),
//    ]
//    
//    // 特定のレイアウトからキーコードを取得する関数
//    static func getKeycodeInfo(for layout: KeycodeRegion, key: String) -> KeycodeInfo? {
//        switch layout {
//        case .ANSI:
//            return ANSI[key]
//        case .JIS:
//            return JIS[key]
//        case .ISO:
//            return ISO[key]
//        }
//    }
//}



//// Symbols
//case hyphen // (hyphen)
//case under_bar // _ (ansi,iso: hyphen+shift, jis: international1)
//case equal_sign // = (ansi: equal_sign, iso: equal_sign, jis: hyphen + shift)
//case plus // + (ansi: equal_sign + shift, jis: semicolon + shift)
//case open_square_bracket // [ (ansi: open_bracket, iso: open_bracket, jis: close_bracket)
//case open_curly_bracket // { (ansi, iso: open_bracket + shift, jis: close+shift)
//case close_square_bracket // ] (ansi, iso: close_bracket, jis: backslash)
//case close_curly_bracket // } (ansi, iso: close+shift, jis: backslash+shift)
//case backslash // ansi: backslash, iso: non_us_pound, jis: international3
//case vertical_bar // | (ansi, iso: backslash + shift, jis: internationl3 + shift)
//case semicolon // ; (semicolon)
//case colon // : (ansi, iso: semi+shift, jis: quote)
//case single_quotation // ' (ansi, iso: quote, jis:7+shift)
//case double_quotation // " (ansi, iso: quote+shift, jis: 2+shift)
//case grave_accent // ` (ansi: grave_accent_and_tilde, iso: non_us_back_slash, jis: grave_accent_and_tilde)
//case tilde // ~ (ansi: grave_accent_and_tilde+shift, iso: non_us_backslash+shift, jis: equal_sign+shift)
//case comma // , (comma)
//case less_than // < (comma+shift)
//case period // . (priod)
//case greater_than // > (period+shift)
//case slash // / (slash)
//case question // ? (slash + shift)
//case section // § (ansi: non_us_backslash, iso: grave_accent_and_tilde, jis:  non_us_backlash)
//case plus_minus // ±, (ansi: non_us_backslash + shift, iso: ???, jis: non_us_backslash + shift)
//
//case exclamation // ! (1+shift)
//case commercial_at // @ (ansi, iso: 2+shift, jis: open_bracket)
//case number_sign // # (3+shift)
//case dollar // $ (4+shift)
//case percent // % (5+shift)
//case caret // ^ (ansi, iso: 6+shift, jis: equal_sign)
//case ampersand // & (ansi, iso: 7+shift, jis: 6+shift)
//case asterisk // * (ansi, iso: 8+shift, jis: quote+shift)
//case open_parenthesis // ( (ansi, iso: 9+shift, jis: 8+shift)
//case close_parenthesis // ) (ansi, iso: 0+shift, jis: 9+shift)
//
//case inverted_exclamation // ¡ (1+option)
//case trade_mark // ™ (2+option)
//case pound // £ (3+option)
//case cent // ¢ (4+option)
//case infinity // ∞ (5+option)
//case section // § (6+option)
//case pilcrow // ¶ (7+option)
//case bullet // • (ansi, iso: 8+option, jis: ?)
//case feminine_ordinal_indicator // ª (ansi, iso: 9+option, jis: 8+option)
//case masculine_ordinal_indicator // º (ansi, iso: 0+option, jis: 9+option)
//
//case fraction_slash // ⁄ (1+shift+option) 分数に使われるスラッシュらしい。19へぇ〜
//case euro // € (2+shift+option)
//case single_left_pointing_angle_quotation_mark // ‹ (3+shift+option)
//case single_right_pointing_angle_quotation_mark // › (4+shift+option)
//case fi_ligature // ﬁ (5+shift+option)
//case fl_ligature // ﬂ (6+shift+option)
//case double_dagger // ‡ (7+shift+option)
//case degree // ° (8+shift+option)
//case middle_dot // · (9+shift+option)
//case single_low_9_quotation_mark // ‚ (0+shift+option)
//
//case oe_ligature // œ (q+option)
//case capital_oe_ligature // Œ (q+shift+option)
//case sigma // ∑ (w+option)
//case double_low_9_quotation_mark // „ (w+shift+option)
//
//case acute_accent // ◌́ (e+shift) and typed Letter. -> á
//case acute_accent_ // ´ (e+option+shift) //Pokémonのアクセント記号
//
//case registered_trademark // ® (r+option)
//case dagger // † (t+option)
//case caron // ˇ (t+shift+option)
//case backslash_or_yen // \ (y+option)
//
//case capital_a_acute // Á (y+shift+option)
//
//case diaeresis // ◌̈ (u+option)
//case only_diaeresis // ¨ (u+option+shift) 二重母音ではないことを示す記号
//
//case circumflex // ◌̂ (i+option)
//case only_circumflex // ˆ (i+option+shift)
//
//
//case o_with_stroke // ø (o+option) oeの合字でœで代用されることもある
//case capital_o_with_stroke // Ø (o+shift+option)
//case pi // π (p+option)
//case capital_pi // ∏ (p+shift+option)
//case angstrom // å (a+option) 1å=0.1nm
//case eszett // ß (s+option) sの無声音
//case curly_d // ∂ (d+option) 数学記号、偏微分に用いられる
//case capital_i_with_circumflex // Î (d+shift+option)
//case f_with_hook // ƒ (f+option)
//case capital_i_with_diaeresis // Ï (f+shift+option)
//case copy_right // © (g+option)
//case double_acute_accent // ˝ (g+shift+option)
//case dot_above // ˙ (h+option)
//case capital_o_with_acute_accent // Ó (h+shift+option)
//case delta // ∆ (j+option) 増加量とか
//case capital_o_with_circumflex // Ô (j+shift+option)
//case ring_above // ˚ (k+option)
//case apple_logo //  (k+shift+option)
//case not_sign // ¬ (l+option)
//case capital_o_with_grave // Ò (l+shift+option)
//case omega // Ω (z+option)
//case almost_equal // ≈ (x+option)
//case c_with_cedilla // ç (c+option)
//case square_root // √ (v+option)
//case lozenge // ◊ (v+shift+option)
//case integral // ∫ (b+option)
//case i_dotless // ı (b+shift+option)
//
//case small_tilde // ◌̃ (n+option)
//case only_small_tilde // ˜ (n+option+shift)
//case mu // µ (m+option) 接頭辞マイクロ
//case capital_a_with_circumflex // Â (m+shift+option)
//
////ansiのメモをしとく
//case en_dash // – (hyphen+option)
//case em_dash // — hyphen option
//case not_equal // ≠ (equal+option)
//case plus_minus // ± (equal+option+shift)
//
//case left_double_quotation_mark // “ (open_bracket+option)
//case right_double_quotation_mark // ” (open_bracket+option+shift)
//
//case left_single_quotation_mark // ‘ (close_bracket+option)
//case right_single_quotation_mark // ’ (close_bracket+option+shift)
////↓日本語IMEでバックスラッシュで入力している文字ではない方が打たれる↓
//case yen_sign // ¥ (ansi: backslash+option, jis: ?)
//case left_pointing_double_angle_quotation_mark // « (ansi: ?, jis: backslash+option)
//case right_pointing_double_angle_quotation_mark // » (backslash+option+shift)
//
//case holizontal_ellipsis // … (semicolon+option)
//case capital_u_with_acute // Ú (semicolon+option+shift)
//
//case ae_ligature // æ (quote+option)
//case capital_ae_ligature // Æ (quote+option+shift)
//
//case less_than_or_equal_to // ≤ (comma+option)
//case macron // ¯ (comma+option+shift) マクロン:数学で平均値や平均を表現する
//
//case greater_than_or_equal_to // ≥ (period+option)
//case breve // ˘ (period+option+shift)
//
//case inverted_question_mark // ¿ (slash+option+shift)
//
//case grave_accent // ◌̀ (iso: non_us_backslash+option,jis:international1 + option)
//case only_grave_accent // ` (iso: non_us_backslash + option+shift, jis: international1 + option + shift)
