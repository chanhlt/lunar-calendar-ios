//
//  Event.swift
//  LunarCalendar
//
//  Created by Chanh Le on 8/9/25.
//

import Foundation

func loadEvents(_ solar: Date, _ lunar: LunarDate) -> [Event] {
    return lunarDB?.queryEvent(solar, lunar) ?? []
}
