//
//  JournalEntry.swift
//  JournalSwiftUI
//
//  Created by Oskar Larsson on 2022-10-04.
//

import Foundation

struct JournalEntry : Identifiable {
    
    var id = UUID()
    var title: String
    var description: String
    var date: Date
    
}
