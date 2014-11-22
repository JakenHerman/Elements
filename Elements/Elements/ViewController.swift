//
//  ViewController.swift
//  Elements
//
//  Created by Jaken Herman on 11/21/14.
//  Copyright (c) 2014 Jolly Roger Company. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
                println(currentWeather.currentTime)
                
            }
            
            
        })
        
        downloadTask.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

