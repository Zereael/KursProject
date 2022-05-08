//
//  MainViewController.swift
//  MyProject
//
//  Created by Anastasiia Chechina on 05.05.2022.
//

import UIKit

final class MainViewController: UIViewController {

    // MARK: - Internal Properties
    
    var output: MainViewOutput!

    // MARK: - Private Properties

    private var model: MainModel?

    private var timer: Timer?
    private let indexPathToDelete = IndexPath(row: 0, section: 0)

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var emptyView: UIView!
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    private let refreshControl = UIRefreshControl()

    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: "Добавить",
            style: .plain,
            target: self,
            action: #selector(tapAdd))
        return button
    }()
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: "Назад",
            style: .done,
            target: nil,
            action: nil)
        return button
    }()
    private lazy var fillButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: "AutoFill",
            style: .plain,
            target: self,
            action: #selector(fill))
        return button
    }()
    private lazy var goButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: "Пуск",
            style: .plain,
            target: self,
            action: #selector(tapGo))
        return button
    }()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        output.refresh()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        output.refresh()
    }

    // MARK: - Configuration
    
    private func configure() {
        configureNavBar()
        configureTableView()
    }
    
    private func configureNavBar() {
        title = "Очередь списков"
        navigationItem.leftBarButtonItems = [fillButton, goButton]
        navigationItem.rightBarButtonItem = addButton
        navigationItem.backBarButtonItem = backButton
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

    // MARK: - Actions
    
    @objc private func tapAdd() {
        output.tapAdd()
    }

    @objc private func fill() {
        let helper = FillHelper()
        helper.fill()
        output.refresh()
    }

    @objc private func tapGo() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
            goButton.title = "Пуск"
        } else {
            timer = Timer.scheduledTimer(
                timeInterval: 1.0,
                target: self,
                selector: #selector(timeHasCome),
                userInfo: nil,
                repeats: true)
            goButton.title = "Стоп"
        }
        
    }

    @objc private func timeHasCome() {
        if model?.sections.count != 0 {
            if model?.sections[indexPathToDelete.section].rows.count != 0 {
                output.delete(at: indexPathToDelete)
            } else {
                removeEmpty()
            }
        } else {
            tapGo()
        }
    }

    @objc private func refresh() {
        output.refresh()
    }
}

extension MainViewController: MainViewInput {

    func startLoader() {
        loader.startAnimating()
    }

    func stopLoader() {
        refreshControl.endRefreshing()
        loader.stopAnimating()
    }

    func showEmptyView() {
        emptyView.isHidden = false
        tableView.isHidden = true
    }

    func hideEmptyView() {
        emptyView.isHidden = true
        tableView.isHidden = false
    }

    func configure(with model: MainModel) {
        self.model = model
        tableView.reloadData()
    }

    func deleted(at indexPath: IndexPath) {
        model?.sections[indexPath.section].rows.remove(at: indexPath.row)
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }

    func deleteFirstSection() {
        model?.sections.remove(at: indexPathToDelete.section)
        tableView.beginUpdates()
        let indexSet = IndexSet(integer: indexPathToDelete.section)
        tableView.deleteSections(indexSet, with: .automatic)
        tableView.endUpdates()
    }

    // MARK: - Private Methods

    private func removeEmpty() {
        if model?.sections[indexPathToDelete.section].rows.count == 0 {
            output.dequeue()
        }
    }
}

extension MainViewController: UITableViewDelegate {}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return model?.sections[section].title
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return model?.sections.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.sections[section].rows.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = model?.sections[indexPath.section].rows[indexPath.row] else { return UITableViewCell() }
        var cell = tableView.dequeueReusableCell(withIdentifier: "mainTableViewCell")

        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "mainTableViewCell")
        }
        cell?.textLabel?.text = row.title
        cell?.detailTextLabel?.text = row.subtitle
        cell?.accessoryType = .none

        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            output.delete(at: indexPath)
        }
    }
}
