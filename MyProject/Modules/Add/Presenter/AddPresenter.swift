//
//  AddPresenter.swift
//  MyProject
//
//  Created by Anastasiia Chechina on 05.05.2022.
//

import Foundation

final class AddPresenter {
    
    // MARK: - Internal Properties
    
    weak var view: AddViewInput!
    var interactor: AddInteractorInput!
    var router: AddRouterInput!

    // MARK: - Private Properties

    private let dateService: IDateService = DateService()
    
    private var intervals: [[Interval]] = []
    private var ids: [String] = []
}

extension AddPresenter: AddViewOutput {

    func viewDidLoad() {
        view.startLoader()
        interactor.requestData()
    }

    func tapAddToQueue(date: Date, startTime: Date, endTime: Date) {
        let newDay = Day(
            id: UUID().uuidString,
            startTime: dateService.concatDateAndTime(date: date, time: startTime),
            endTime: dateService.concatDateAndTime(date: date, time: endTime))
        interactor.addToQueue(newDay)
    }

    func tapAddToLinkedList(date: Int, time: Int, name: String, surname: String) {
        let selectedDateId = ids[date]
        let selectedTime = intervals[date][time]
        let record = Record(
            starTime: selectedTime.startTime,
            endTime: selectedTime.endTime,
            name: name,
            surname: surname)
        interactor.addToLinkedList(with: selectedDateId, record: record)
    }
}

extension AddPresenter: AddInteractorOutput {

    func presentData(_ data: Queue<Day>) {
        ids = []
        let day = data.tail?.interval.startTime ?? Date()
        let nextDay = dateService.nextDay(for: day)

        var dates: [String] = []
        var intervals: [[Interval]] = []
        for item in data {

            ids.append(item.id)

            let dateStr = dateService.dateToString(item.interval.startTime)
            dates.append(dateStr)
            
            var busyDayIntervals: [Interval] = []
            var currentRecord = item.records.head
            while currentRecord != nil {
                busyDayIntervals.append(Interval(startTime: currentRecord!.data.interval.startTime, endTime: currentRecord!.data.interval.endTime))
                currentRecord = currentRecord?.next
            }
            let dayIntervals = dateService.intervals(
                startTime: item.interval.startTime,
                endTime: item.interval.endTime,
                busyIntervals: busyDayIntervals)
            intervals.append(dayIntervals)
        }

        self.intervals = intervals

        var times: [[String]] = []
        for item in intervals {
            var dayTimes: [String] = []
            for interval in item {
                let str = "\(dateService.timeToString(interval.startTime)) - \(dateService.timeToString(interval.endTime))"
                dayTimes.append(str)
            }
            times.append(dayTimes)
        }

        let model = AddModel(
            minNewDay: nextDay,
            maxNewDay: dateService.endOfDay(nextDay),
            dates: dates,
            times: times)
        view.stopLoader()
        view.configure(with: model)
    }

    func error(with text: String) {
        router.showError(with: text, completion: nil)
    }

    func done(with text: String) {
        let completion: (() -> Void)? = { [weak self] in
            guard let self = self else { return }
            self.viewDidLoad()
        }
        router.showDone(with: text, completion: completion)
    }
}
