

import UIKit

class ForecastViewController: UIViewController,UITableViewDataSource {
    
    
    let forecastData = ForecastDataModel()
    



   
    
   
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
print(forecastData.weatherIconName)
        
        

        
        
        // Do any additional setup after loading the view.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastData.temperature.count
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifire = "Forecast"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath) as? ForecastTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        let temp = forecastData.temperature[indexPath.row]
        let weatherImage = forecastData.weatherIconName[indexPath.row]
        let time = forecastData.time[indexPath.row]
        let check = forecastData.check
        
        cell.date.text = time
        cell.conditionImage.image = UIImage(named: weatherImage)
        cell.condition.text = weatherImage
    if check {
        cell.temp.text = "\(temp)℃"
    }
    else
    {
        cell.temp.text = "\(temp)℉"
    }
        
        
        
        
        return cell
    }
    @IBAction func back(_ sender: UIButton)
    {
     self.dismiss(animated: true, completion: nil)
        
    }
    

}
