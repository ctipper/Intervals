//
//  IntervalView.swift
//  Intervals
//
//  Created by Christopher on 14-12-2020.
//

import SwiftUI

struct IntervalView: View {
    @State private var start = Date(dateString: "2020-12-10")
    @State private var end = Date(dateString: "2021-01-01")
    @State private var text = String()
    
    var body: some View {
        VStack(alignment: .center) {
            DatePicker(
                "Start Date",
                selection: $start,
                displayedComponents: [.date]
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .padding()
            .frame(width: 30)
            .labelsHidden()
            Text("\((end - start).week!) weeks \((end - start).day! - ((end - start).week!) * 7) days").font(.title2)
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
            .frame(width: 30)
            .labelsHidden()
        }
    }
}

