//
//  FillHelper.swift
//  MyProject
//
//  Created by Anastasiia Chechina on 07.05.2022.
//

import Foundation

final class FillHelper {

    // MARK: - Private Properties

    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.timeZone = .current
        formatter.dateFormat = "d.MM.yyyy, HH:mm"
        return formatter
    }()

    private lazy var day1: Day = {
        let fromStr = "25.06.2022, 10:00"
        let toStr = "25.06.2022, 14:00"
        
        let from = formatter.date(from: fromStr) ?? Date()
        let to = formatter.date(from: toStr) ?? Date()

        return Day(id: UUID().uuidString, startTime: from, endTime: to)
    }()

    private lazy var record11: Record = {
        let fromBusyStr = "25.06.2022, 11:00"
        let toBusyStr = "25.06.2022, 11:30"

        let fromBusy = formatter.date(from: fromBusyStr) ?? Date()
        let toBusy = formatter.date(from: toBusyStr) ?? Date()

        return Record(starTime: fromBusy, endTime: toBusy, name: "Ann", surname: "Che")
    }()

    private lazy var record12: Record = {
        let fromBusyStr = "25.06.2022, 13:00"
        let toBusyStr = "25.06.2022, 13:30"

        let fromBusy = formatter.date(from: fromBusyStr) ?? Date()
        let toBusy = formatter.date(from: toBusyStr) ?? Date()

        return Record(starTime: fromBusy, endTime: toBusy, name: "Naz", surname: "Xc")
    }()

    private lazy var record13: Record = {
        let fromBusyStr = "25.06.2022, 12:00"
        let toBusyStr = "25.06.2022, 12:30"

        let fromBusy = formatter.date(from: fromBusyStr) ?? Date()
        let toBusy = formatter.date(from: toBusyStr) ?? Date()

        return Record(starTime: fromBusy, endTime: toBusy, name: "Ivan", surname: "Sidorov")
    }()

    private lazy var day2: Day = {
        let fromStr = "27.06.2022, 10:00"
        let toStr = "27.06.2022, 14:00"
        
        let from = formatter.date(from: fromStr) ?? Date()
        let to = formatter.date(from: toStr) ?? Date()

        return Day(id: UUID().uuidString, startTime: from, endTime: to)
    }()

    private lazy var record21: Record = {
        let fromBusyStr = "27.06.2022, 11:00"
        let toBusyStr = "27.06.2022, 11:30"

        let fromBusy = formatter.date(from: fromBusyStr) ?? Date()
        let toBusy = formatter.date(from: toBusyStr) ?? Date()

        return Record(starTime: fromBusy, endTime: toBusy, name: "Ann", surname: "Che")
    }()

    private lazy var record22: Record = {
        let fromBusyStr = "27.06.2022, 13:00"
        let toBusyStr = "27.06.2022, 13:30"

        let fromBusy = formatter.date(from: fromBusyStr) ?? Date()
        let toBusy = formatter.date(from: toBusyStr) ?? Date()

        return Record(starTime: fromBusy, endTime: toBusy, name: "Naz", surname: "Xc")
    }()

    private lazy var record23: Record = {
        let fromBusyStr = "27.06.2022, 12:00"
        let toBusyStr = "27.06.2022, 12:30"

        let fromBusy = formatter.date(from: fromBusyStr) ?? Date()
        let toBusy = formatter.date(from: toBusyStr) ?? Date()

        return Record(starTime: fromBusy, endTime: toBusy, name: "Ivan", surname: "Sidorov")
    }()

    private lazy var day3: Day = {
        let fromStr = "30.06.2022, 10:00"
        let toStr = "30.06.2022, 14:00"
        
        let from = formatter.date(from: fromStr) ?? Date()
        let to = formatter.date(from: toStr) ?? Date()

        return Day(id: UUID().uuidString, startTime: from, endTime: to)
    }()

    private lazy var record31: Record = {
        let fromBusyStr = "30.06.2022, 11:00"
        let toBusyStr = "30.06.2022, 11:30"

        let fromBusy = formatter.date(from: fromBusyStr) ?? Date()
        let toBusy = formatter.date(from: toBusyStr) ?? Date()

        return Record(starTime: fromBusy, endTime: toBusy, name: "Ann", surname: "Che")
    }()

    private lazy var record32: Record = {
        let fromBusyStr = "30.06.2022, 13:00"
        let toBusyStr = "30.06.2022, 13:30"

        let fromBusy = formatter.date(from: fromBusyStr) ?? Date()
        let toBusy = formatter.date(from: toBusyStr) ?? Date()

        return Record(starTime: fromBusy, endTime: toBusy, name: "Naz", surname: "Xc")
    }()

    private lazy var record33: Record = {
        let fromBusyStr = "30.06.2022, 12:00"
        let toBusyStr = "30.06.2022, 12:30"

        let fromBusy = formatter.date(from: fromBusyStr) ?? Date()
        let toBusy = formatter.date(from: toBusyStr) ?? Date()

        return Record(starTime: fromBusy, endTime: toBusy, name: "Ivan", surname: "Sidorov")
    }()

    // MARK: - Internal Methods

    func fill() {
        day1.records.append(record11)
        day1.records.append(record12)
        day1.records.append(record13)

        day2.records.append(record21)
        day2.records.append(record22)
        day2.records.append(record23)

        day3.records.append(record31)
        day3.records.append(record32)
        day3.records.append(record33)
        
        _ = DBService.write(day: day1)
        _ = DBService.write(day: day2)
        _ = DBService.write(day: day3)
    }
}
