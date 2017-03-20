//
//  ViewController.swift
//  Weather
//
//  Created by Appaji Tholeti on 20/03/2017.
//  Copyright © 2017 Tholeti Consultancy Ltd. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    var presenter: WeatherPresenter?
    fileprivate var viewModel: WeatherViewModel?
   
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    private func setupUI() {
        tableView.dataSource = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                                target: self,
                                                                action: #selector(loadData))

    }
    
    @objc private func loadData() {
        navigationItem.leftBarButtonItem?.isEnabled = false
        presenter?.fetchWeatherInfo(completionHandler: {[weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.navigationItem.leftBarButtonItem?.isEnabled = true
            strongSelf.activityIndicator.stopAnimating()
            switch result {
            case .Success(let weatherViewModel):
                strongSelf.viewModel = weatherViewModel
                strongSelf.title = weatherViewModel.title
                strongSelf.tableView.reloadData()
            case .Failed(let errorMessage):
                strongSelf.title = "Failed to Load, retry again"
                strongSelf.showLoadDataFailedAlert(withMessage: errorMessage)
                break
            }
        })
    }
    
    private func showLoadDataFailedAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Loading weather forecast failed",
                                                     message: message,
                                                     preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: UITableViewDataSource
extension WeatherViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let dailyForecasts = viewModel?.dailyForecasts else {
            return 1
        }
        return dailyForecasts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dailyForecasts = viewModel?.dailyForecasts else {
            return 1
        }
        return dailyForecasts[section].forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.cellIdentifier, for: indexPath) as? WeatherTableViewCell
        cell?.viewModel = viewModel?.dailyForecasts[indexPath.section].forecasts[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel?.dailyForecasts[section].day
    }
}

