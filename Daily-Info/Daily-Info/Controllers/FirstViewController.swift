//
//  FirstViewController.swift
//  Daily-Info
//
//  Created by Ruben  De Freyne on 28/12/2019.
//  Copyright © 2019 Ruben  De Freyne. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?zip=9000,be&units=metric&appid=36a20216bae3ee8eb277b0bca81d534b") else {return}
        
        //Create data and get session
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                do {
                    
                    //put data in JSON Serializer
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {return}
                    
                    //parsing JSON
                    guard let weatherDetails = json["weather"] as? [[String: Any]], let weatherMain = json ["main"] as? [String: Any]
                        else {return}
                    let temp = Int(weatherMain["temp"] as? Double ?? 0)
                    let description = (weatherDetails.first?["description"] as? String)?.capitalizeFirstLetter()
                    
                    //passing elements to function
                    DispatchQueue.main.async {
                        self.setWeather(weather: weatherDetails.first?["main"] as? String,  description: description, temp: temp)
                    }
                }catch {
                    print("error")
                }
            }
        }
        task.resume()
    }
    
    func setWeather(weather: String?, description: String?, temp: Int) {
        descriptionLabel.text = description ?? "..."
        temperatureLabel.text = "\(temp)°C"
        switch weather {
        case "Clear sky":
            imageView.image = UIImage(named: "Sunny")
            background.backgroundColor = UIColor(red: 0.95, green: 0.78, blue: 0.35, alpha:1.0)
        case "Few clouds":
            imageView.image = UIImage(named: "Cloudy")
            background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha:1.0)
        case "Shower rain":
            imageView.image = UIImage(named: "Rain")
            background.backgroundColor = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha:1.0)
        case "Rain":
            imageView.image = UIImage(named: "RainSun")
            background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha:1.0)
        case "Thunderstorm":
            imageView.image = UIImage(named: "Storm")
            background.backgroundColor = UIColor(red: 0.18, green: 0.20, blue: 0.29, alpha:1.0)
        case "Snow":
            imageView.image = UIImage(named: "Snow")
            background.backgroundColor = UIColor(red: 0.77, green: 0.77, blue: 0.77, alpha:1.0)
        case "Mist":
            imageView.image = UIImage(named: "Mist")
            background.backgroundColor = UIColor(red: 0.77, green: 0.77, blue: 0.77, alpha:1.0)
        default:
            imageView.image = UIImage(named: "Clouds")
            background.backgroundColor = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha:1.0)
        }
    }
}

extension String {
    func capitalizeFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}

