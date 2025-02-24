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
        
        var displayName: String {
            switch self {
            case .book: return "Book"
            case .pencil: return "Pencil"
            case .bookmark: return "Bookmark"
            case .divide: return "Division"
            case .function: return "Function"
            case .sum: return "Summation"
            case .medical: return "Medical"
            case .fluidBag: return "IV Fluid Bag"
            case .brain: return "Brain"
            case .chart: return "Chart"
            case .textCursor: return "Text Cursor"
            case .scroll: return "Scroll"
            case .discussion: return "Discussion"
            case .laptop: return "Laptop"
            case .arcade: return "Arcade"
            case .gear: return "Settings"
            case .desktop: return "Desktop Computer"
            case .building: return "Institution"
            case .globe: return "Globe"
            }
        }
    }
    
    @Attribute(.unique) var id: UUID
    
    var title: String
    var steps: [Step]
    
    @Relationship(deleteRule: .cascade, inverse: \StudySession.project) var sessions: [StudySession]
    var currentSessionID: StudyProject.ID?
    
    var startDate: Date
    var endDate: Date
    
    var symbol: Symbol
    var appearance: Appearance
    
    var isCompleted: Bool {
        steps.allSatisfy(\.isCompleted)
    }
    
    @Relationship(deleteRule: .cascade, inverse: \EmotionLog.project) var emotionLogs = [EmotionLog]()
    
    init(
        title: String,

        appearance: Appearance = Appearance(),
        symbol: Symbol = .book,
        startDate: Date = .now,
        endDate: Date
    ) {
        id = UUID()
        steps = []
        sessions = []
        
        self.title = title
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
    
    func currentSession() -> StudySession? {
        guard let currentSessionID else { return nil }
        return sessions.first { $0.id == currentSessionID }
    }
}
