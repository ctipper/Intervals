//
//  IntervalCalculator.swift
//  Intervals
//
//  Shared, view-agnostic date maths used by both the SwiftUI views
//  and the App Intents exposed to Shortcuts.
//

import Foundation
import AppIntents

/// The unit of time added to a start date when calculating an end date.
enum IntervalPeriod: String, CaseIterable, AppEnum {
    case days = "Days"
    case weeks = "Weeks"
    case months = "Months"
    case years = "Years"

    static var typeDisplayRepresentation: TypeDisplayRepresentation { "Period" }

    static var caseDisplayRepresentations: [IntervalPeriod: DisplayRepresentation] {
        [
            .days: "Days",
            .weeks: "Weeks",
            .months: "Months",
            .years: "Years"
        ]
    }

    /// The date components representing `amount` of this period.
    func dateComponents(_ amount: Int) -> DateComponents {
        var component = DateComponents()
        switch self {
        case .days:   component.day = amount
        case .weeks:  component.weekOfYear = amount
        case .months: component.month = amount
        case .years:  component.year = amount
        }
        return component
    }
}

struct IntervalCalculator {
    /// Adds `amount` of `period` to `start` and returns the resulting date.
    static func endDate(from start: Date, amount: Int, period: IntervalPeriod) -> Date {
        Calendar.current.date(byAdding: period.dateComponents(amount), to: start) ?? start
    }

    /// A breakdown of the span between two dates.
    struct Duration {
        let totalDays: Int
        let weeks: Int
        /// Days left over after whole weeks are removed (`totalDays - weeks * 7`).
        let remainderDays: Int
        let hours: Int
        let workDays: Int
        let nonWorkingDays: Int
    }

    /// Computes the duration between `start` and `end`.
    ///
    /// Delegates the arithmetic to the `Date` helpers so there is a single
    /// source of truth for the work-day / non-working-day maths.
    static func duration(from start: Date, to end: Date) -> Duration {
        let difference = end - start
        let totalDays = difference.day ?? 0
        let weeks = difference.week ?? 0

        return Duration(
            totalDays: totalDays,
            weeks: weeks,
            remainderDays: totalDays - weeks * 7,
            hours: totalDays * 24,
            workDays: Date.workDays(end, start) ?? 0,
            nonWorkingDays: Date.holiDays(end, start) ?? 0
        )
    }
}
