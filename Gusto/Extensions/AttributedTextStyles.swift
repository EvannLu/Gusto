//
//  AttributedTextStyles.swift
//  Gusto
//
//  Created by Evan Lu on 11/13/25.
//

import SwiftUI

extension AttributedString {
    static func correctStyle(_ string: String) -> AttributedString {
        var s = AttributedString(string)
        s.foregroundColor = .green
        s.font = .system(size: 24, weight: .bold)
        return s
    }

    static func wrongStyle(_ string: String) -> AttributedString {
        var s = AttributedString(string)
        s.foregroundColor = .red
        s.font = .system(size: 20, weight: .medium)
        return s
    }
}
