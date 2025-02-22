//
//  StudyProject.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 07/02/25.
//

import Foundation
import SwiftData

@Model
final class StudyProject: Identifiable {
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
    var isCompleted: Bool
    var steps: [Step]
    
    @Relationship(deleteRule: .cascade, inverse: \StudySession.project) var sessions: [StudySession]
    var currentSessionID: StudyProject.ID?
    
    var startDate: Date
#warning("It's important the user doesn't change the end date lightly. Be sure to prompt the user about it.")
    var endDate: Date
    
    var symbol: Symbol?
    var appearance: Appearance
    
    @Relationship(deleteRule: .cascade, inverse: \EmotionLog.project) var emotionLogs = [EmotionLog]()
    
    init(
        title: String,
        details: String = "",
        isCompleted: Bool = false,
        appearance: Appearance = Appearance(),
        symbol: Symbol = .book,
        startDate: Date = .now,
        endDate: Date
    ) {
        id = UUID()
        steps = []
        sessions = []
        
        self.title = title
        self.details = details
        self.isCompleted = isCompleted
        self.appearance = appearance
        self.symbol = symbol
        self.startDate = startDate
        self.endDate = endDate
    }
    
    @MainActor static let example = {
        let project = StudyProject(
            title: "Newtonian mechanics exam",
            appearance: Appearance(titleFont: .serif),
            endDate: .now.addingTimeInterval(2*24*60*60)
        )
        
        project.steps = (0..<5).map {
            Step(name: "Step \($0)", details: "This is an amazing example step. You should be very careful and execute everything. Do things one at a time to ensure you understand everything and don't feel anxious.")
        }
        
        return project
    }()
}
