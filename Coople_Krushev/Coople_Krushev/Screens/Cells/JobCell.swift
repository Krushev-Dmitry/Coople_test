//
//  JobCell.swift
//  Coople_test
//
//  Created by Krushev on 8/5/23.
//

import UIKit
import SnapKit

class JobCell: UITableViewCell {
    static let identifier = "JobCell"

    private var viewModel: JobCellViewModel?
    
    private lazy var workAssignmentNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var addressStreetLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var zipLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var zipAndCityStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [zipLabel,
                                                       cityLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [workAssignmentNameLabel,
                                                       addressStreetLabel,
                                                       zipAndCityStackView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    func configure(with model: JobCellViewModel) {
        self.viewModel = model
        workAssignmentNameLabel.text = model.job.workAssignmentName
        addressStreetLabel.text = model.job.jobLocation?.addressStreet
        zipLabel.text = model.job.jobLocation?.zip
        cityLabel.text = model.job.jobLocation?.city

        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
}
