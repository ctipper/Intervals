//
//  HelloView.swift
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
        let week = Calendar.current.dateComponents([.weekOfMonth], from: previous, to: recent).weekOfMonth
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second
        
        return (month: month, day: day, week: week, hour: hour, minute: minute, second: second)
    }
}

struct HelloView: View {
    @State private var start = Date(dateString: "2020-12-10")
    @State private var end = Date(dateString: "2021-01-01")
    @State private var text = String()
    
    var body: some View {
        VStack {
            DatePicker(
                "Start Date",
                selection: $start,
                displayedComponents: [.date]
            ).frame(width: 30.0).labelsHidden()
            Text("\((end - start).week!) weeks \((end - start).day! - ((end - start).week!) * 7) days")
            Text("\((end - start).day!) days")
            Text("\(((end - start).day!) * 24) hours")
            DatePicker(
                "End Date",
                selection: $end,
                displayedComponents: [.date]
            ).frame(width: 30.0).labelsHidden()
        }
    }
}

