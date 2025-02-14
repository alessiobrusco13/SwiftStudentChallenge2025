//
//  StudySession.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 07/02/25.
//

import Foundation
import SwiftData

@Model
final class StudySession: Identifiable {
    enum Symbol: String, Codable, CaseIterable {
        case book = "book.pages.fill"
        case pencil = "pencil.and.outline"
        case bookmark = "bookmark.fill"
        case divide = "divide"
        case function = "function"
        case sum = "sum"
        case medical = "heart.text.square.fill"
        case fluidBag = "ivfluid.bag"
        case brain = "brain.fill"
        case chart = "chart.bar.xaxis"
        case textCursor = "character.cursor.ibeam"
        case scroll = "scroll.fill"
        case discussion = "bubble.left.and.bubble.right.fill"
        case laptop = "laptopcomputer"
        case arcade = "arcade.stick.console.fill"
        case gear = "gearshape.fill"
        case desktop = "desktopcomputer"
        case building = "building.columns.fill"
        case globe = "globe"
    }
    
    @Attribute(.unique) var id: UUID
    
    var title: String
    var details: String
    var completed: Bool
    var steps: [Step]
    
    var startDate: Date
#warning("It's important the user doesn't change the end date lightly. Be sure to prompt the user about it.")
    var endDate: Date
    
    var symbol: Symbol?
    var appearance: Appearance
    
    init(
        title: String,
        details: String = "",
        completed: Bool = false,
        appearance: Appearance = Appearance(),
        symbol: Symbol = .book,
        startDate: Date = .now,
        endDate: Date
    ) {
        id = UUID()
        steps = []
        
        self.title = title
        self.details = details
        self.completed = completed
        self.appearance = appearance
        self.symbol = symbol
        self.startDate = startDate
        self.endDate = endDate
    }
    
    @MainActor static let example = StudySession(
        title: "Newtonian mechanics exam",
        appearance: Appearance(titleFont: .serif),
        endDate: .now.addingTimeInterval(2*24*60*60)
    )
}
