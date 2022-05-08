//
//  DateService.swift
//  MyProject
//
//  Created by Anastasiia Chechina on 05.05.2022.
//

import Foundation

protocol IDateService {
    func timeToString(_ time: Date) -> String
    func dateToString(_ time: Date) -> String
    func nextDay(for date: Date) -> Date
    func startOfDay(_ day: Date) -> Date
    func endOfDay(_ day: Date) -> Date
    func concatDateAndTime(date: Date, time: Date) -> Date
    func intervals(startTime: Date, endTime: Date, busyIntervals: [Interval]) -> [Interval]
}

final class DateService: IDateService {

    // MARK: - Private Properties
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.timeZone = .current
        return formatter
    }()
    private lazy var calendar: Calendar = {
        var calendar = Calendar.current
        calendar.timeZone = .current
        calendar.locale = .current
        return calendar
    }()

    // MARK: - Public Methods

    func timeToString(_ time: Date) -> String {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: time)
    }

    func dateToString(_ date: Date) -> String {
        dateFormatter.dateFormat = "EEEE, d MMMM, yyyy"
        return dateFormatter.string(from: date)
    }

    func nextDay(for date: Date) -> Date {
        var dayComponent = DateComponents()
        dayComponent.day = 1
        
        let nextDate = calendar.date(byAdding: dayComponent, to: date) ?? date
        return startOfDay(nextDate)
    }

    func startOfDay(_ day: Date) -> Date {
        let components = calendar.dateComponents([.year, .month, .day], from: day)
        guard
            let year = components.year,
            let month = components.month,
            let dayNumber = components.day
        else {
            return day
        }
        let date = makeDate(
            year: year,
            month: month,
            day: dayNumber,
            hr: 0,
            min: 0)
        return date
    }

    func endOfDay(_ day: Date) -> Date {
        let components = calendar.dateComponents([.year, .month, .day], from: day)
        guard
            let year = components.year,
            let month = components.month,
            let dayNumber = components.day
        else {
            return day
        }
        let date = makeDate(
            year: year,
            month: month,
            day: dayNumber,
            hr: 23,
            min: 59)
        return date
    }

    // Concat date && time
    func concatDateAndTime(date: Date, time: Date) -> Date {
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
        guard
            let year = dateComponents.year,
            let month = dateComponents.month,
            let day = dateComponents.day,
            let hour = timeComponents.hour,
            let min = timeComponents.minute
        else {
            return Date()
        }
        let result = makeDate(
            year: year,
            month: month,
            day: day,
            hr: hour,
            min: min)
        return result
    }

    // Get free time intervals in period
    func intervals(startTime: Date, endTime: Date, busyIntervals: [Interval]) -> [Interval] {
        if busyIntervals.isEmpty {
            let interval = Interval(startTime: startTime, endTime: endTime)
            return splitInterval(interval)
        }
        
        var intervals: [Interval] = []

        var index: Int = 0
        while index <= busyIntervals.count {
            if index == 0 {
                let interval = Interval(startTime: startTime, endTime: busyIntervals[index].startTime)
                intervals.append(contentsOf: splitInterval(interval))
            } else if index == busyIntervals.count {
                let interval = Interval(startTime: busyIntervals[index - 1].endTime, endTime: endTime)
                intervals.append(contentsOf: splitInterval(interval))
            } else {
                let interval = Interval(startTime: busyIntervals[index - 1].endTime, endTime: busyIntervals[index].startTime)
                intervals.append(contentsOf: splitInterval(interval))
            }
            
            index += 1
        }

        return intervals
    }

    // MARK: - Private Methods

    private func makeDate(year: Int, month: Int, day: Int, hr: Int, min: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hr
        components.minute = min
        let date = calendar.date(from: components) ?? Date()
        return date
    }

    // Split time interval by 30 minute
    private func splitInterval(_ interval: Interval) -> [Interval] {
        var result: [Interval] = []
        var currentTime = interval.startTime
        
        var dayComponent = DateComponents()
        dayComponent.minute = 30

        while currentTime < interval.endTime {
            guard var endTime = calendar.date(byAdding: dayComponent, to: currentTime) else { break }
            endTime = endTime <= interval.endTime ? endTime : interval.endTime
            result.append(Interval(startTime: currentTime, endTime: endTime))
            currentTime = endTime
        }

        return result
    }
}
