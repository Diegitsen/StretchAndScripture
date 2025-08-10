//
//  HomeView.swift
//  StretchAndScripture
//
//  Created by diegitsen on 10/08/25.
//

import SwiftUI

// MARK: - Model
struct DayProgress: Identifiable, Equatable {
    let id = UUID()
    let date: Date
    var progress: Double   // 0...1
    var hasItems: Bool { Calendar.current.isDateInToday(date) }
}

extension DayProgress {
    var isToday: Bool { Calendar.current.isDateInToday(date) }
    var letter: String {
        // Inicial del día según locale (L, M, X/J, V, S, D)
        let sym = Calendar.current.shortWeekdaySymbols[Calendar.current.component(.weekday, from: date)-1]
        return String(sym.prefix(1)).uppercased()
    }
}

// MARK: - Ring view
struct RingProgressView: View {
    var progress: Double
    var color: Color
    var lineWidth: CGFloat = 6
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.15), lineWidth: lineWidth)
            Circle()
                .trim(from: 0, to: max(0, min(1, progress)))
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .foregroundStyle(color)
        }
    }
}

// MARK: - Day pill
struct DayPillView: View {
    let item: DayProgress
    var isSelected: Bool
    var ringSize: CGFloat
    var color: Color = .purple
    
    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                RingProgressView(progress: item.progress, color: color)
                Text(item.letter)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(isSelected ? .white : .primary)
            }
            .frame(width: ringSize, height: ringSize)
            
            // Puntito inferior
            Circle()
                .fill(item.hasItems ? Color.orange : .clear)
                .frame(width: 6, height: 6)
                .opacity(item.hasItems ? 1 : 0)
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 6)
        .background(
            Capsule()
                .fill(isSelected ? color : Color(.systemBackground).opacity(0.6))
                .overlay(Capsule().stroke(Color.black.opacity(0.07)))
                .shadow(color: .black.opacity(isSelected ? 0.15 : 0.05),
                        radius: isSelected ? 8 : 3, y: 2)
        )
    }
}

// MARK: - Week picker
struct WeekProgressPicker: View {
    @Binding var selectedDate: Date
    let items: [DayProgress]
    var color: Color = .purple
    var onSelect: ((DayProgress) -> Void)? = nil

    var body: some View {
        GeometryReader { geo in
            // --- Layout: 7 chips visibles, sin scroll ---
            let spacing: CGFloat = 12
            let hPad: CGFloat = 24
            let count = max(items.count, 1)
            let available = geo.size.width - (hPad * 2) - CGFloat(count - 1) * spacing
            let itemWidth = max(40, available / CGFloat(count))

            HStack(spacing: spacing) {
                ForEach(items) { item in
                    DayPillButton(
                        item: item,
                        isSelected: Calendar.current.isDate(item.date, inSameDayAs: selectedDate),
                        color: color
                    ) {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        selectedDate = item.date
                        onSelect?(item)
                    }
                    .frame(width: itemWidth)
                }
            }
            .padding(.horizontal, hPad)
            .padding(.vertical, 8)
            .frame(width: geo.size.width, alignment: .center)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(.ultraThinMaterial)
                    .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.black.opacity(0.06)))
            )
        }
        // altura suficiente para el pill + puntito
        .frame(height: 78)
    }
}

// Sub-view para aliviar al type-checker
struct DayPillButton: View {
    let item: DayProgress
    let isSelected: Bool
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            DayPillView(item: item, isSelected: isSelected, ringSize: 32.0, color: color)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(item.letter), progreso \(Int(item.progress * 100))%")
    }
}

// MARK: - Demo / Preview
struct WeekProgressPicker_Preview: View {
    @State private var selected = Date()
    
    private var week: [DayProgress] {
        let cal = Calendar.current
        let start = cal.date(from: cal.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        return (0..<7).compactMap { offset in
            let d = cal.date(byAdding: .day, value: offset, to: start)!
            return DayProgress(
                date: d,
                progress: [0.0, 0.25, 0.6, 0.0, 0.0, 0.0, 0.85][offset]
            )
        }
    }
    
    var body: some View {
        VStack(spacing: 24) {
            WeekProgressPicker(selectedDate: $selected, items: week, color: .purple) { day in
                // handle tap
                print("Selected:", day.date)
            }
            Spacer()
        }
        .padding(.top, 24)
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    WeekProgressPicker_Preview()
}
