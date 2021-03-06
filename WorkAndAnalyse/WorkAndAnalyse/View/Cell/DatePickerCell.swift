//
//  DatePickerCell.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 25.04.2021.
//

import UIKit
import TableKit
import SnapKit

struct DatePickerCellConfiguration {
    var style: UIDatePickerStyle
    var mode: UIDatePicker.Mode
    var text: String
}

class DatePickerCell: UITableViewCell, ConfigurableCell {
    
    struct DatePickerCellActions {
        static let selectedValueChanged = "SelectedValueChanged"
    }
    
    var date: Date {
        datePicker.date
    }
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.tintColor = CustomColors.lightOrangeColor
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private var containerView = OutlinedView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with config: DatePickerCellConfiguration) {
        datePicker.datePickerMode = config.mode
        datePicker.preferredDatePickerStyle = config.style
        containerView.configure(text: config.text)
    }
    
    @objc func dateChanged() {
        TableCellAction(key: DatePickerCellActions.selectedValueChanged, sender: self).invoke()
    }
    
    private func commonInit() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(containerView)
        addSubview(datePicker)
        
        containerView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
        }
        
        datePicker.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(5)
            make.width.equalTo(230)
            make.bottomMargin.equalToSuperview().offset(-5)
            make.trailingMargin.equalToSuperview().offset(-5)
        }
    }

}
