//
//  StudySessionView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 23/02/25.
//

import SwiftUI

// Could make timer expandable.
struct StudySessionView: View {
    let project: StudyProject
    let session: StudySession
    
    @State private var hours: Int
    @State private var minutes: Int
    @State private var seconds: Int
    
    init(project: StudyProject, session: StudySession) {
        self.project = project
        self.session = session
        
        let (hours, minutes, seconds) = session.duration.components()
        
        _hours = State(wrappedValue: hours)
        _minutes = State(wrappedValue: minutes)
        _seconds = State(wrappedValue: seconds)
    }
    
    private var togglePauseSymbol: String {
        if session.pauses == nil {
            "graduationcap.fill"
        } else {
            session.isPaused ? "play.fill" : "pause.fill"
        }
    }
    
    var body: some View {
        GroupBox {
            TimelineView(.periodic(from: .now, by: 1)) { timeline in
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            timer
                            
                            Spacer()
                            
                            togglePauseButton
                            cancelButton
                        }
                        
                        Text(session.duration.formatted(.duration(addComma: true)))
                            .foregroundStyle(session.isPaused ? .secondary : .primary)
                    }
                }
                .onChange(of: timeline.date, updateTimer)
            }
        } label: {
            Text("Study Session")
                .fontStyling(for: project.appearance)
        }
        .groupBoxStyle(.glass)
        .padding([.top, .horizontal], 16)
        .animation(.default, value: session.isPaused)
        .transition(.move(edge: .trailing).combined(with: .opacity))
    }
    
    private var timer: some View {
        HStack(spacing: 0) {
            Text("\(hours):")
            Text("\(minutes):")
            Text("\(seconds)")
        }
        .contentTransition(.numericText(countsDown: true))
        .fixedSize()
        .font(.largeTitle)
        .foregroundStyle(session.isPaused ? .secondary : .primary)
    }
    
    private func updateTimer() {
        guard !session.isPaused else { return }
        let components = session.timeRemaining.components()
        
        withAnimation {
            hours = components.hours
            minutes = components.minutes
            seconds = components.seconds
        }
    }
    
    private var togglePauseButton: some View {
        ZStack {
            Button(action: togglePause) {
                Image(systemName: togglePauseSymbol)
                    .font(session.pauses == nil ? .title2 : .title)
                    .contentTransition(.symbolEffect(.replace, options: .speed(2)))
                    .foregroundStyle(
                        session.pauses == nil ? AnyShapeStyle(.thinMaterial) : AnyShapeStyle(.white)
                    )
                    .colorScheme(.light)
                
            }
            .buttonStyle(.pressable)
            
            Circle()
                .stroke(.ultraThinMaterial, style: .init(lineWidth: 5, lineCap: .round, lineJoin: .miter))
                .frame(width: 48, height: 48)
                .colorScheme(.light)
            
            Circle()
                .trim(from: 0, to: 1 - session.progress)
                .stroke(.thinMaterial, style: .init(lineWidth: 5, lineCap: .round, lineJoin: .miter))
                .frame(width: 48, height: 48)
                .colorScheme(.light)
                .rotationEffect(.degrees(-90))
        }
        .contentShape(.circle)
        .onTapGesture(perform: togglePause)
    }
    
    private func togglePause() {
        if session.isPaused {
            session.resume()
        } else {
            session.pause()
        }
    }
    
    private var cancelButton: some View {
        Button {
            //Change
            withAnimation {
                session.cancel()
            }
        } label: {
            Image(systemName: "xmark")
                .font(.title)
                .bold()
                .frame(width: 36, height: 36)
        }
        .buttonBorderShape(.circle)
        .buttonStyle(.prominentGlass)
    }
}

#Preview {
    @Previewable @State var session = StudySession.example
    
    StudySessionView(project: .example, session: session)
        .colorScheme(.dark)
}
