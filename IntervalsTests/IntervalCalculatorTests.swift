//
//  IntervalCalculatorTests.swift
//  IntervalsTests
//
//  Unit tests for the shared date maths and the essential Date helpers.
//

import Testing
import Foundation
@testable import Intervals

struct IntervalCalculatorTests {

    // MARK: - endDate

    @Test func addsDays() {
        let end = IntervalCalculator.endDate(from: Date(dateString: "2026-01-01"), amount: 10, period: .days)
        #expect(end == Date(dateString: "2026-01-11"))
    }

    @Test func addsWeeks() {
        let end = IntervalCalculator.endDate(from: Date(dateString: "2026-01-01"), amount: 2, period: .weeks)
        #expect(end == Date(dateString: "2026-01-15"))
    }

    @Test func addsMonths() {
        let end = IntervalCalculator.endDate(from: Date(dateString: "2026-01-01"), amount: 3, period: .months)
        #expect(end == Date(dateString: "2026-04-01"))
    }

    @Test func addsYears() {
        let end = IntervalCalculator.endDate(from: Date(dateString: "2026-01-01"), amount: 1, period: .years)
        #expect(end == Date(dateString: "2027-01-01"))
    }

    // MARK: - duration

    @Test func durationOfOneWeek() {
        let d = IntervalCalculator.duration(from: Date(dateString: "2026-01-01"), to: Date(dateString: "2026-01-08"))
        #expect(d.totalDays == 7)
        #expect(d.weeks == 1)
        #expect(d.remainderDays == 0)
        #expect(d.hours == 168)
        #expect(d.workDays == 5)
        #expect(d.nonWorkingDays == 2)
    }

    @Test func durationWithRemainderDays() {
        let d = IntervalCalculator.duration(from: Date(dateString: "2026-01-01"), to: Date(dateString: "2026-01-10"))
        #expect(d.totalDays == 9)
        #expect(d.weeks == 1)
        #expect(d.remainderDays == 2)
        #expect(d.hours == 216)
        #expect(d.workDays == 7)
        #expect(d.nonWorkingDays == 2)
    }

    @Test func durationOfFourWeeks() {
        let d = IntervalCalculator.duration(from: Date(dateString: "2026-03-02"), to: Date(dateString: "2026-03-30"))
        #expect(d.totalDays == 28)
        #expect(d.weeks == 4)
        #expect(d.workDays == 20)
        #expect(d.nonWorkingDays == 8)
    }

    // MARK: - Date helpers (the essential functions)

    @Test func workDaysExcludeWeekends() {
        let start = Date(dateString: "2026-01-01")
        let end = Date(dateString: "2026-01-15")
        // 14 days = 2 weeks -> 10 work days, 4 non-working days
        #expect(Date.workDays(end, start) == 10)
        #expect(Date.holiDays(end, start) == 4)
    }

    @Test func workDaysAndHoliDaysSumToTotal() {
        let start = Date(dateString: "2026-01-01")
        let end = Date(dateString: "2026-01-10")
        let total = (end - start).day
        #expect(Date.workDays(end, start)! + Date.holiDays(end, start)! == total)
    }

    @Test func subtractionOperatorYieldsComponents() {
        let diff = Date(dateString: "2026-01-15") - Date(dateString: "2026-01-01")
        #expect(diff.day == 14)
        #expect(diff.week == 2)
    }

    // MARK: - IntervalPeriod

    @Test func periodProducesMatchingComponents() {
        #expect(IntervalPeriod.days.dateComponents(5).day == 5)
        #expect(IntervalPeriod.weeks.dateComponents(3).weekOfYear == 3)
        #expect(IntervalPeriod.months.dateComponents(2).month == 2)
        #expect(IntervalPeriod.years.dateComponents(4).year == 4)
    }
}
