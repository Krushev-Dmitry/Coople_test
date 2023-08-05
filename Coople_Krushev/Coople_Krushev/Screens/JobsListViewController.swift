//
//  JobsListViewController.swift
//  Coople_Krushev
//
//  Created by Krushev on 8/5/23.
//

import UIKit
import SnapKit
import Combine

class JobsListViewController: UIViewController {
    
    private var viewModel: JobsListViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: JobsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(JobCell.self, forCellReuseIdentifier: JobCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Jobs"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        setupBindings()
    }
    
    private func setupBindings() {
        viewModel.$jobs
            .receive(on: DispatchQueue.main)
            .sink { [weak self] jobs in
                print(jobs.count)
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension JobsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.jobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JobCell.identifier, for: indexPath) as! JobCell
        let job = viewModel.jobs[indexPath.row]
        cell.configure(with: JobCellViewModel(job: job))
        return cell
    }
}

extension JobsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
