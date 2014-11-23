//
//  ViewController.swift
//  Elements
//
//  Created by Jaken Herman on 11/21/14.
//  Copyright (c) 2014 Jolly Roger Company. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var iconView: UIImageView!
    
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var precipitationLevel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    
    private let apiKey = "b7b26fbc072aaffbae35ef7608f0227c"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")
        let forecastURL = NSURL(string: "30.704799,-95.552720", relativeToURL: baseURL)
       
        let sharedSession = NSURLSession.sharedSession()
        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(forecastURL!, completionHandler: { (location: NSURL!, response: NSURLResponse!, error:NSError!) -> Void in
            
            if (error == nil){
            
            let dataObject = NSData(contentsOfURL: location)
            let weatherDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject!, options: nil, error: nil) as NSDictionary
            
            let currentWeather = Current(weatherDictionary: weatherDictionary)
            
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.temperatureLabel.text = "\(currentWeather.temperature)"
                        self.iconView.image = currentWeather.icon!
                        self.currentTimeLabel.text = "At \(currentWeather.currentTime!) it is"
                        self.temperatureLabel.text = "\(currentWeather.temperature)"
                        self.humidityLabel.text = "\(currentWeather.humidity)"
                        self.precipitationLevel.text = "\(currentWeather.precipProbability)"
                        self.summaryLabel.text = "\(currentWeather.summary)"
                        
                })
                
                
                
            }
            
            
        })
        
        downloadTask.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

