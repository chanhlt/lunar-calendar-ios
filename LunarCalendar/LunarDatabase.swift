//
//  LunarDatabase.swift
//  LunarCalendar
//
//  Created by Chanh Le on 31/8/25.
//

import Foundation
import SQLite

struct LunarDate {
    let solarDate: String
    let lunarYear: Int
    let lunarMonth: Int
    let lunarDay: Int
    let isLeapMonth: Bool
}

class LunarDatabase {
    private let db: Connection
    private let table = Table("lunar_dates")
    
    private let solarDate = Expression<String>(value: "solar_date")
    private let lunarYear = Expression<Int>(value: "lunar_year")
    private let lunarMonth = Expression<Int>(value: "lunar_month")
    private let lunarDay = Expression<Int>(value: "lunar_day")
    private let isLeapMonth = Expression<Int>(value: "is_leap_month")
    
    init?() {
        guard let dbPath = Bundle.main.path(forResource: "lunar_calendar", ofType: "db") else {
            print("❌ Database file not found in bundle")
            return nil
        }

        do {
            db = try Connection(dbPath, readonly: true)
            print("✅ Database opened at: \(dbPath)")
        } catch {
            print("❌ Failed to open DB: \(error)")
            return nil
        }
    }
    
    func query(for date: Date) -> LunarDate? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateStr = formatter.string(from: date)

        do {
            // Raw SQL with parameter binding
            let sql = "SELECT solar_date, lunar_year, lunar_month, lunar_day, is_leap_month FROM lunar_dates WHERE solar_date = ? LIMIT 1"
            let stmt = try db.prepare(sql)
            
            // Run the statement with dateStr as parameter
            for row in try stmt.run(dateStr) {
                return LunarDate(
                    solarDate: row[0] as! String,
                    lunarYear: Int(row[1] as! Int64),   // SQLite returns Int64
                    lunarMonth: Int(row[2] as! Int64),
                    lunarDay: Int(row[3] as! Int64),
                    isLeapMonth: (row[4] as! Int64) == 1
                )
            }
        } catch {
            print("Query error: \(error)")
        }
        return nil
    }


}

