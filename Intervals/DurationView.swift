//
//  IntervalView.swift
//  Intervals
//
//  Created by Christopher on 14-12-2020.
//

import SwiftUI

struct DurationView: View {
    @State private var start = Date()
    @State private var end = Date().addingTimeInterval(3600 * 24 * 8)

    var body: some View {
        TabView {
            // First Tab: Duration Calculator
            VStack {
                DatePicker(
                    "Start Date",
                    selection: $start,
                    displayedComponents: [.date]
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
                .labelsHidden()

                let duration = IntervalCalculator.duration(from: start, to: end)
                Text("\(duration.weeks) weeks \(duration.remainderDays) days")
                    .font(.title2)
                Text("\(duration.totalDays) days").font(.title2)
                Text("\(duration.hours) hours").font(.title2)
                Text("\(duration.workDays) work days").font(.title2)
                Text("\(duration.nonWorkingDays) non-working days").font(.title2)

                DatePicker(
                    "End Date",
                    selection: $end,
                    displayedComponents: [.date]
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
                .labelsHidden()
            }
            .padding()
            .tabItem {
                Label("Duration", systemImage: "calendar")
            }

            // Second Tab: IntervalView
            IntervalView()
                .tabItem {
                    Label("Interval", systemImage: "repeat")
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
