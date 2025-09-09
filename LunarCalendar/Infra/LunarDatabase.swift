//
//  LunarDatabase.swift
//  LunarCalendar
//
//  Created by Chanh Le on 31/8/25.
//

import Foundation
import SQLite

struct LunarDate: Hashable {
    let solarDate: String
    let year: Int
    let month: Int
    let day: Int
    let isLeapMonth: Bool
}


struct Event: Hashable, Identifiable {
    let id: Int
    let name: String
    let solarDay: Int?
    let solarMonth: Int?
    let lunarDay: Int?
    let lunarMonth: Int?
    let startHour: Int?
    let startMinute: Int?
    let endHour: Int?
    let endMinute: Int?
    let isAllDay: Bool
}


class LunarDatabase {
    private let db: Connection
    
    
    init?() {
        guard let dbPath = Bundle.main.path(forResource: "lunar_calendar", ofType: "db") else {
            print("❌ Database file not found in bundle")
            return nil
        }

        do {
            db = try Connection(dbPath, readonly: true)
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
                    year: Int(row[1] as! Int64),   // SQLite returns Int64
                    month: Int(row[2] as! Int64),
                    day: Int(row[3] as! Int64),
                    isLeapMonth: (row[4] as! Int64) == 1
                )
            }
        } catch {
            print("Query error: \(error)")
        }
        return nil
    }
    
    func queryEvent(_ solar: Date, _ lunar: LunarDate) -> [Event] {

        var events: [Event] = []
        
        let comps = Calendar.current.dateComponents([.day, .month], from: solar)
        let solarDay = comps.day!
        let solarMonth = comps.month!
        let lunarDay = lunar.day
        let lunarMonth = lunar.month
        
        do {
            // Raw SQL with parameter binding
            let sql = """
            SELECT id, name, solar_day, solar_month, lunar_day, lunar_month, 
                   start_hour, start_minute, end_hour, end_minute, is_all_day
            FROM events 
            WHERE (solar_day = ? AND solar_month = ?) 
               OR (lunar_day = ? AND lunar_month = ?)
            """
            let stmt = try db.prepare(sql)
            
            
            for row in try stmt.run(solarDay, solarMonth, lunarDay, lunarMonth) {
                events.append(
                    Event(
                        id: Int(row[0] as? Int64 ?? 0),
                        name: row[1] as? String ?? "",
                        solarDay: Int(row[2] as? Int64 ?? 0),
                        solarMonth: Int(row[3] as? Int64 ?? 0),
                        lunarDay: Int(row[4] as? Int64 ?? 0),
                        lunarMonth: Int(row[5] as? Int64 ?? 0),
                        startHour: Int(row[6] as? Int64 ?? 0),
                        startMinute: Int(row[7] as? Int64 ?? 0),
                        endHour: Int(row[8] as? Int64 ?? 0),
                        endMinute: Int(row[9] as? Int64 ?? 0),
                        isAllDay: (row[10] as? Int64 ?? 0) == 1
                    )
                )
            }
        } catch {
            print("Query error: \(error)")
        }
        return events
    }


}

