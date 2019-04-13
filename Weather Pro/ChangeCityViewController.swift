
import UIKit


// protocol declaration here:
protocol ChangeCityDelegate {
    func userEnteredANewCityName (city : String)
}


class ChangeCityViewController: UIViewController,UITextFieldDelegate {
    
    //Declare the delegate variable here:
    var delegate : ChangeCityDelegate?
    

    @IBOutlet weak var changeCityTextField: UITextField!

    override func viewDidLoad() {
        changeCityTextField.delegate = self
    }

    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        
        
        
        //1 Get the city name the user entered in the text field
        let city = changeCityTextField.text! // baraye inke esm shahri ke user vared mikone pass bedim be tabe
        
        //2 If we have a delegate set, call the method userEnteredANewCityName
        delegate?.userEnteredANewCityName(city: city) //check mikone age moteghayer delegate nil nabashe tabe ro call mikone
        
        //3 dismiss the Change City View Controller to go back to the WeatherViewController
        self.dismiss(animated: true, completion: nil) // baste shodan vc2 bargasht be vc 1
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    

    //This is the IBAction that gets called when the user taps the back button. It dismisses the ChangeCityViewController.
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
