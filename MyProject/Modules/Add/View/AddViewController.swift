//
//  AddViewController.swift
//  MyProject
//
//  Created by Anastasiia Chechina on 05.05.2022.
//

import UIKit

final class AddViewController: UIViewController {

    // MARK: - Internal Properties
    
    var output: AddViewOutput!

    // MARK: - Private Properties

    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var loader: UIActivityIndicatorView!

    @IBOutlet private weak var queueView: UIView!
    @IBOutlet private weak var addToQueueButton: UIButton!
    @IBOutlet private weak var queueDatePicker: UIDatePicker!
    @IBOutlet private weak var startTimePicker: UIDatePicker!
    @IBOutlet private weak var endTimePicker: UIDatePicker!

    @IBOutlet private weak var linkedListView: UIView!
    @IBOutlet private weak var addToLinkedListButton: UIButton!
    @IBOutlet private weak var selectDatePicker: UIPickerView!
    @IBOutlet private weak var selectTimePicker: UIPickerView!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var surnameTextFiels: UITextField!

    @IBOutlet private var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    @IBOutlet private var selectDatePickerHeightLayoutConstraint: NSLayoutConstraint?
    @IBOutlet private var selectTimePickerHeightLayoutConstraint: NSLayoutConstraint?

    private var model: AddModel?

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        output.viewDidLoad()
    }

    deinit {
      NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Configuration
    
    private func configure() {
        configureNavBar()
        configureSegmentedControl()
        configureViews()
        configurePickers()
        configureAddButtons()
        hideKeyboardWhenTappedAround()
        scrollWhenKeyboadrAppears()
    }
    
    private func configureNavBar() {
        title = "Добавить"
    }

    private func configureSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
    }

    private func configureViews() {
        queueView.isHidden = false
        linkedListView.isHidden = true
    }

    private func configurePickers() {
        queueDatePicker.isEnabled = false
        startTimePicker.isEnabled = false
        endTimePicker.isEnabled = false

        selectDatePicker.delegate = self
        selectDatePicker.dataSource = self

        selectTimePicker.delegate = self
        selectTimePicker.dataSource = self
    }

    private func configureAddButtons() {
        addToQueueButton.isEnabled = false
        addToLinkedListButton.isEnabled = false
    }

    private func scrollWhenKeyboadrAppears() {
        NotificationCenter.default.addObserver(self,
               selector: #selector(self.keyboardNotification(notification:)),
               name: UIResponder.keyboardWillChangeFrameNotification,
               object: nil)
    }

    // MARK: - Actions

    @IBAction private func segmentedControlValueChanged() {
        queueView.isHidden = segmentedControl.selectedSegmentIndex == 1
        linkedListView.isHidden = segmentedControl.selectedSegmentIndex == 0
    }

    @IBAction private func pickersValueChanged() {
        startTimePicker.date = startTimePicker.date > endTimePicker.date ? endTimePicker.date : startTimePicker.date
        endTimePicker.date = endTimePicker.date < startTimePicker.date ? startTimePicker.date : endTimePicker.date
    }

    @IBAction private func textFieldsValueChanged() {
        addToLinkedListButton.isEnabled = nameTextField.hasText && surnameTextFiels.hasText
    }

    @IBAction private func tapAddToQueueButton() {
        output.tapAddToQueue(
            date: queueDatePicker.date,
            startTime: startTimePicker.date,
            endTime: endTimePicker.date)
    }

    @IBAction private func tapAddToLinkedListButton() {
        guard
            let name = nameTextField.text,
            let surname = surnameTextFiels.text else {
            return
        }
        let date = selectDatePicker.selectedRow(inComponent: 0)
        let time = selectTimePicker.selectedRow(inComponent: 0)
        
        output.tapAddToLinkedList(date: date, time: time, name: name, surname: surname)
    }

    @objc private func keyboardNotification(notification: NSNotification) {
      guard let userInfo = notification.userInfo else { return }

      let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
      let endFrameY = endFrame?.origin.y ?? 0
      let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
      let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
      let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
      let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)

      if endFrameY >= UIScreen.main.bounds.size.height {
          keyboardHeightLayoutConstraint?.constant = 80.0
          selectDatePickerHeightLayoutConstraint?.constant = 120.0
          selectTimePickerHeightLayoutConstraint?.constant = 120.0
      } else {
          keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 80.0
          selectDatePickerHeightLayoutConstraint?.constant = 0
          selectTimePickerHeightLayoutConstraint?.constant = 0
      }

      UIView.animate(
        withDuration: duration,
        delay: TimeInterval(0),
        options: animationCurve,
        animations: { self.view.layoutIfNeeded() },
        completion: nil)
    }
}

extension AddViewController: AddViewInput {

    func startLoader() {
        loader.startAnimating()
    }

    func stopLoader() {
        loader.stopAnimating()
    }

    func configure(with model: AddModel) {
        self.model = model
        configureQueueView()
        configureLinkedListView()
    }

    private func configureQueueView() {
        guard let model = model else { return }
        queueDatePicker.minimumDate = model.minNewDay
        queueDatePicker.isEnabled = true

        startTimePicker.minimumDate = model.minNewDay
        startTimePicker.date = model.minNewDay
        startTimePicker.maximumDate = model.maxNewDay
        startTimePicker.isEnabled = true

        endTimePicker.minimumDate = model.minNewDay
        endTimePicker.date = model.maxNewDay
        endTimePicker.maximumDate = model.maxNewDay
        endTimePicker.isEnabled = true

        addToQueueButton.isEnabled = true
    }

    private func configureLinkedListView() {
        selectDatePicker.reloadAllComponents()
        selectTimePicker.reloadAllComponents()
    }
}

extension AddViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return model?.dates[row]
        case 1:
            return model?.times[selectDatePicker.selectedRow(inComponent: 0)][row]
        default:
            break
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            selectTimePicker.reloadAllComponents()
        default:
            break
        }
    }

}

extension AddViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return model?.dates.count ?? 0
        case 1:
            let index = selectDatePicker.selectedRow(inComponent: 0)
            guard
                let count = model?.times.count,
                index < count,
                let intervalArray = model?.times[index] else { return 0 }
            return intervalArray.count
        default:
            break
        }
        return 0
    }
}
