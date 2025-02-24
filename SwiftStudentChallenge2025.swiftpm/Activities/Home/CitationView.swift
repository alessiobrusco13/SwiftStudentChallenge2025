//
//  CitationView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 24/02/25.
//

import SwiftUI

struct Citation: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let date: String
    let source: String
}

struct CitationsView: View {
    let citations: [Citation] = [
        Citation(title: "Estrategias para minimizar la procrastinación", author: "Federico Hervías Ortega", date: "23 Oct 2022", source: "Know and Share Psychology"),
        Citation(title: "Stop procrastinating: TILT, time is life time", author: "Anthony Foulonneau +2 more", date: "29 Nov 2016", source: ""),
        Citation(title: "The Art of Procrastination", author: "Chien-Wei Wang +1 more", date: "01 Jan 2024", source: "Plastic and Reconstructive Surgery"),
        Citation(title: "Time Management Training Reduces Work Procrastination", author: "Rizky Alfina Maulidiyah +1 more", date: "03 Oct 2024", source: "Indonesian Journal of Law and Economics Review"),
        Citation(title: "Cognitive Prostheses for Goal Achievement", author: "Falk Lieder +3 more", date: "19 Aug 2019", source: "Nature Human Behaviour"),
        Citation(title: "A Comparative Analysis of Procrastination Among Students", author: "Nurdin Adiyansah", date: "18 Jul 2024", source: "Indonesian Research Journal on Education"),
        Citation(title: "Visual Analysis of Learning Procrastination Research", author: "Yinyin Zhang +1 more", date: "12 Jul 2024", source: "")
    ]
    
    var body: some View {
        List(citations) { citation in
            VStack(alignment: .leading) {
                Text(citation.title)
                    .font(.headline)
                Text(citation.author)
                    .font(.subheadline)
                Text("Published: \(citation.date)")
                    .font(.footnote)
                if !citation.source.isEmpty {
                    Text("Source: \(citation.source)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 4)
        }
        .navigationTitle("Citations")
    }
}
