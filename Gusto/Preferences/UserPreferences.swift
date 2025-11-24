//
//  UserPreferences.swift
//  Gusto
//
//  Created by Evan Lu on 11/13/25.
//

import SwiftUI
import Combine

class UserPreferences: ObservableObject {
    @AppStorage("showHints") var showHints: Bool = true
}
