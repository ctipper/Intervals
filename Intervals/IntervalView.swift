//
//  IntervalView.swift
//  Intervals
//
//  Created by Christopher on 14-12-2020.
//

import SwiftUI

extension Date {
    // https://stackoverflow.com/a/24090354
    init(dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = Locale(identifier: "en_US_POSIX")
        let d = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:d)
    }
    
    // https://stackoverflow.com/a/56239944
    static func -(recent: Date, previous: Date) -> (month: Int?, day: Int?, week: Int?, hour: Int?, minute: Int?, second: Int?) {
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let week = Calendar.current.dateComponents([.weekOfYear], from: previous, to: recent).weekOfYear
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second
        
        return (month: month, day: day, week: week, hour: hour, minute: minute, second: second)
    }
    
    static func workDays(_ recent: Date, _ previous: Date) -> Int? {
        let days = Calendar.current.dateComponents([.day], from: previous, to: recent).day!
        let weeks = Calendar.current.dateComponents([.weekOfYear], from: previous, to: recent).weekOfYear!
        return days - 2 * weeks
    }
    
    static func holiDays(_ recent: Date, _ previous: Date) -> Int? {
        let weeks = Calendar.current.dateComponents([.weekOfYear], from: previous, to: recent).weekOfYear!
        return 2 * weeks
    }
}

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

