import XCTest
@testable import Networking


/// DateFormatter+Woo Unit Tests
///
class DateFormatterWooTests: XCTestCase {

    /// Sample Date
    ///
    let datetimeAsString = "2018-01-24T16:21:48"


    /// Verifies that a Woo Datetime is properly parsed by `DateFormatter.Defaults.dateTimeFormatter`.
    ///
    func testWooFormattedDateIsProperlyParsed() {
        guard let date = DateFormatter.Defaults.dateTimeFormatter.date(from: datetimeAsString) else {
            XCTFail()
            return
        }

        let calendar = Calendar.current
        XCTAssertEqual(calendar.component(.year, from: date), 2018)
        XCTAssertEqual(calendar.component(.month, from: date), 1)
        XCTAssertEqual(calendar.component(.day, from: date), 24)
    }

    /// Verifies that a valid stats **day** string is produced by `DateFormatter.Defaults.statsDayFormatter`.
    ///
    func testStatsDayDateStringIsProperlyParsed() {
        guard let date = DateFormatter.Defaults.dateTimeFormatter.date(from: datetimeAsString) else {
            XCTFail()
            return
        }

        let dayDateString = DateFormatter.Stats.statsDayFormatter.string(from: date)
        XCTAssertFalse(dayDateString.isEmpty)
        XCTAssertEqual(dayDateString, "2018-01-24")
    }

    /// Verifies that a valid stats **week** string is produced by `DateFormatter.Defaults.statsWeekFormatter`.
    ///
    func testStatsWeekDateStringIsProperlyParsed() {
        guard let date = DateFormatter.Defaults.dateTimeFormatter.date(from: datetimeAsString) else {
            XCTFail()
            return
        }

        let weekDateString = DateFormatter.Stats.statsWeekFormatter.string(from: date)
        XCTAssertFalse(weekDateString.isEmpty)
        XCTAssertEqual(weekDateString, "2018-W04")
    }

    /// Verifies that a valid stats **month** string is produced by `DateFormatter.Defaults.statsMonthFormatter`.
    ///
    func testStatsMonthDateStringIsProperlyParsed() {
        guard let date = DateFormatter.Defaults.dateTimeFormatter.date(from: datetimeAsString) else {
            XCTFail()
            return
        }

        let monthDateString = DateFormatter.Stats.statsMonthFormatter.string(from: date)
        XCTAssertFalse(monthDateString.isEmpty)
        XCTAssertEqual(monthDateString, "2018-01")
    }

    /// Verifies that a valid stats **year** string is produced by `DateFormatter.Defaults.statsYearFormatter`.
    ///
    func testStatsYearDateStringIsProperlyParsed() {
        guard let date = DateFormatter.Defaults.dateTimeFormatter.date(from: datetimeAsString) else {
            XCTFail()
            return
        }

        let yearDateString = DateFormatter.Stats.statsYearFormatter.string(from: date)
        XCTAssertFalse(yearDateString.isEmpty)
        XCTAssertEqual(yearDateString, "2018")
    }
}
