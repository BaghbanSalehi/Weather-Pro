//
//  ForecastTableViewController.swift
//  Weahter Pro
//
//  Created by Shayan on 12/12/18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit

class ForecastTableViewController: UITableViewController {

    let forecastData = ForecastDataModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastData.temperature.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifire = "Forecast"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath) as? ForecastTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        let temp = forecastData.temperature[indexPath.row]
        let weatherImage = forecastData.weatherIconName[indexPath.row]
        let time = forecastData.time[indexPath.row]
        
        cell.date.text = time
        cell.conditionImage.image = UIImage(named: weatherImage)
        cell.condition.text = weatherImage
        cell.temp.text = "\(temp)"
        
        
        
        return cell
    }

}
