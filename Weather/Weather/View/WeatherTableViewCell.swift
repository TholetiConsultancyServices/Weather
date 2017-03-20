//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Appaji Tholeti on 20/03/2017.
//  Copyright © 2017 Tholeti Consultancy Ltd. All rights reserved.
//

import UIKit

private let weathIconFontName = "Weather Icons"

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconLabel.font = UIFont(name: weathIconFontName, size: 30)
    }
    static var cellIdentifier: String {
        return String(describing: self)
    }
    var viewModel:ForecastViewModel? {
        didSet {
            timeLabel.text = viewModel?.time
            temperatureLabel.text = viewModel?.temperature
            iconLabel.text = viewModel?.forecastIcon
            weatherConditionLabel.text = viewModel?.forecastCondition
        }
    }
    
}
