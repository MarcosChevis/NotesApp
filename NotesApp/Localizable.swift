//
//  Localizable.swift
//  NotesApp
//
//  Created by Rebecca Mello on 04/02/22.
//

import UIKit
import Foundation

enum Localizable: String {
    case delete = "Delete"
    case allNotesTitle = "all_notes"
    case noteTitle = "notes"
    case settingsTitle = "settings"
    case themeTitle = "themes"
    case noteTitlePlaceholder = "a_great_title"
    case themeNamePlaceholder = "your_theme_name_here"
    case searchPlaceholder = "search"
    case actionColor = "actionColor"
    case background = "background"
    case buttonBackground = "buttonBackground"
    case noteBackground = "noteBackground"
    case text = "text"
    case largeTitle = "largeTitle"
    case alertMustHaveAName = "Your_theme_must_have_a_name"
    case alertError = "An_error_has_occured"
    case alertErrorFetchingNote = "An_error_ocurred_fetching_your_notes!"
    case alertErrorFilterNote = "An_Internal_error_ocurred_trying_to_filter_your_notes"
    case alertEmptyNote = "Your_note_is_empty"
    case alertErrorAddingNote = "An_error_occured_trying_to_add_an_note"
    case alertErrorDeletingNote = "An_error_occured_trying_to_delete_an_note"
    case alertConfirmationToDelete = "Are_you_sure_you_want_to_delete_it?"
    case alertConfirmationToAction = "This_action_cannot_be_undone"
    case cancel = "cancel"
    case error = "Error"
    case themeExample = "themeExample"
    case examplePhrase1 = "examplePhrase1"
    case examplePhrase2 = "examplePhrase2"
}

func NSLocalizedString(_ localizable: Localizable) -> String {
    return NSLocalizedString(localizable.rawValue, comment: "")
}
