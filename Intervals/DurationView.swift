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

                Text("\((end - start).week!) weeks \((end - start).day! - ((end - start).week!) * 7) days")
                    .font(.title2)
                Text("\((end - start).day!) days").font(.title2)
                Text("\(((end - start).day!) * 24) hours").font(.title2)
                Text("\(Date.workDays(end, start)!) work days").font(.title2)
                Text("\(Date.holiDays(end, start)!) non-working days").font(.title2)

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
