//
//  JobsListViewController.swift
//  Coople_Krushev
//
//  Created by Krushev on 8/5/23.
//

import UIKit

class JobsListViewController: UIViewController {
    
    private var viewModel: JobsListViewModel!
    
    init(viewModel: JobsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
    }
}
