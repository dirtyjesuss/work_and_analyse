//
//  CreateTaskViewModel.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 25.03.2021.
//

import TableKit

protocol CreaTaskViewModelDelegate: class {
    func didUpdateData()
    func didFailTaskCreation(errorMessage: String)
    func didClearSceneData()
}

protocol CreateTaskViewModelOutput {
    var onGoToSubtaskCreation: (() -> Void)? { get set }
    var onFinish: (() -> Void)? { get set }
}

protocol CreateTaskViewModelProtocol {
    var dataToPresent: [TableSection] { get set }
}

class CreateTaskViewModel: CreateTaskViewModelProtocol, CreateTaskViewModelOutput {
    
    // MARK: - CreateTaskViewModelOutput
    var onGoToSubtaskCreation: (() -> Void)?
    var onFinish: (() -> Void)?
    
    // MARK: - Vars & Lets
    var dataToPresent: [TableSection] = []
    
    weak var delegate: CreaTaskViewModelDelegate?
    
    private let taskService: TaskService
    
    private var title: String?
    private var startTime = Date()
    private var subtasks: [Subtask] = []
    
    // MARK: - Init
    
    init(taskService: TaskService) {
        self.taskService = taskService
        loadSectionData()
    }
    
    // MARK: - Public methods
    
    // MARK: - Private methods
    
    private func loadSectionData() {
        dataToPresent = [
            TableSection(headerView: LabelSectionHeaderView.getView(with: "Title"), footerView: UIView(), rows: [
                TableRow<CustomTextFieldCell>(item: "Type some title for your task...", actions: [
                    TableRowAction<CustomTextFieldCell>(.custom(CustomTextFieldCellActions.textFieldChanged)) { [unowned self] (options) in
                        title = options.cell?.title
                    }
                ]),
                TableRow<CustomButtonCell>(item: CustomButtonCellConfiguration(title: "CREATE", style: .filled), actions: [
                    TableRowAction<CustomButtonCell>(.custom(CustomButtonCellActions.buttonTapped)) { [unowned self] (options) in
                        create()
                    }
                ])
            ]),
            TableSection(headerView: LabelSectionHeaderView.getView(with: "Start time"), footerView: UIView(), rows: [
                TableRow<DatePickerCell>(item: DatePickerCellConfiguration(style: .compact, mode: .dateAndTime, text: "Starts"), actions: [
                    TableRowAction<DatePickerCell>(.custom(DatePickerCell.DatePickerCellActions.selectedValueChanged)) { [unowned self] (options) in
                        startTime = options.cell?.date ?? Date()
                    }
                ])
            ]),
            TableSection(headerView: LabelSectionHeaderView.getView(with: "Subtasks"), footerView: UIView(), rows: [
                TableRow<CustomButtonCell>(item: CustomButtonCellConfiguration(title: "+", style: .outline), actions: [
                    TableRowAction<CustomButtonCell>(.custom(CustomButtonCellActions.buttonTapped)) { [unowned self] (options) in
                        onGoToSubtaskCreation?()
                    }
                ])
            ])
        ]
        
    }
    
    private func updateSectionData(with subtask: Subtask) {
        dataToPresent.last! += TableRow<DetailTextViewCell>(item: DetailTextViewCellConfiguration(mainText: subtask.title, rightDetailText: subtask.duration.stringFromTimeInterval()))
    }
    
    private func create() {
        guard
            let title = title,
            !subtasks.isEmpty
        else {
            delegate?.didFailTaskCreation(errorMessage: "Please enter the title of task and create at least one subtask.")
            return
        }
        
        let cleanTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !cleanTitle.isEmpty else {
            delegate?.didFailTaskCreation(errorMessage: "Please enter the title of task.")
            return
        }
        
        taskService.createTask(title: cleanTitle, startTime: startTime, subtasks: subtasks) { [weak self] error in
            if let error = error {
                self?.delegate?.didFailTaskCreation(errorMessage: error.localizedDescription)
                return
            }
        }
        
        clearModel()
        onFinish?()
    }
    
    private func clearModel() {
        title = nil
        startTime = Date()
        subtasks = []
        dataToPresent = []
        
        loadSectionData()
        
        delegate?.didClearSceneData()
    }
}

extension CreateTaskViewModel: AddSubtaskViewModelDelegate {
    func createSubtask(subtask: Subtask) {
        subtasks.append(subtask)
        updateSectionData(with: subtask)
        
        delegate?.didUpdateData()
    }
}
