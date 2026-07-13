//
//  IntervalsIntents.swift
//  IntervalsIntents
//
//  App Intents hosted in the App Intents Extension. Living here means the
//  intents run out-of-process (headless) when invoked from Shortcuts,
//  Spotlight or Siri — the main Intervals app is never launched.
//

import AppIntents
import Foundation

/// Adds an interval to a start date and returns the resulting end date.
struct CalculateEndDateIntent: AppIntent {
    static var title: LocalizedStringResource { "Calculate End Date" }
    static var description: IntentDescription {
        IntentDescription("Adds a number of days, weeks, months or years to a start date.")
    }

    @Parameter(title: "Start Date")
    var startDate: Date

    @Parameter(title: "Amount", default: 1)
    var amount: Int

    @Parameter(title: "Period", default: .days)
    var period: IntervalPeriod

    static var parameterSummary: some ParameterSummary {
        Summary("Add \(\.$amount) \(\.$period) to \(\.$startDate)")
    }

    func perform() async throws -> some IntentResult & ReturnsValue<Date> & ProvidesDialog {
        let end = IntervalCalculator.endDate(from: startDate, amount: amount, period: period)
        let formatted = end.formatted(date: .abbreviated, time: .omitted)
        return .result(value: end, dialog: "End date is \(formatted)")
    }
}

/// Calculates the span between two dates and returns the number of days.
struct CalculateDurationIntent: AppIntent {
    static var title: LocalizedStringResource { "Calculate Duration" }
    static var description: IntentDescription {
        IntentDescription("Calculates the number of days, weeks and work days between two dates.")
    }

    @Parameter(title: "Start Date")
    var startDate: Date

    @Parameter(title: "End Date")
    var endDate: Date

    static var parameterSummary: some ParameterSummary {
        Summary("Duration from \(\.$startDate) to \(\.$endDate)")
    }

    func perform() async throws -> some IntentResult & ReturnsValue<Int> & ProvidesDialog {
        let duration = IntervalCalculator.duration(from: startDate, to: endDate)
        let dialog: IntentDialog = """
        \(duration.totalDays) days (\(duration.weeks) weeks \(duration.remainderDays) days), \
        \(duration.workDays) work days, \(duration.nonWorkingDays) non-working days
        """
        return .result(value: duration.totalDays, dialog: dialog)
    }
}

/// Surfaces the intents in Spotlight and the Shortcuts app with spoken phrases.
struct IntervalsShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: CalculateEndDateIntent(),
            phrases: [
                "Calculate end date with \(.applicationName)",
                "Add an interval with \(.applicationName)"
            ],
            shortTitle: "Calculate End Date",
            systemImageName: "repeat"
        )
        AppShortcut(
            intent: CalculateDurationIntent(),
            phrases: [
                "Calculate duration with \(.applicationName)",
                "Days between dates with \(.applicationName)"
            ],
            shortTitle: "Calculate Duration",
            systemImageName: "calendar"
        )
    }
}
