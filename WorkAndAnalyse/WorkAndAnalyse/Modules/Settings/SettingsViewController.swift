//
//  SettingsViewController.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 26.05.2021.
//

import UIKit

class SettingsViewController: BaseViewController {
    
    var viewModel: SettingsViewModelProtocol!
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFonts.openSans(size: 27, style: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(stackView)
        view.addSubview(usernameLabel)
        loadUIForData()
        
        usernameLabel.snp.makeConstraints { (make) in
            make.topMargin.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    private func loadUIForData() {
        for model in viewModel.dataToPresent {
            let settingsView = StyledButton.getInstance(title: model.title, style: .outline)
            settingsView.action = model.action
            
            stackView.addArrangedSubview(settingsView)
            
            settingsView.snp.makeConstraints { (make) in
                make.height.equalTo(60)
            }
        }
        
        usernameLabel.text = viewModel.userName
    }
}

extension SettingsViewController: SettingsViewModelDelegate {

}
