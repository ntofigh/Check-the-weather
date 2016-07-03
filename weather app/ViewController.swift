//
//  ViewController.swift
//  weather app
//
//  Created by Anar on 6/6/16.
//  Copyright © 2016 Anar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var textField: UITextField!

    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func submit(sender: AnyObject) {
        
        var wasSuccessful = false
        
        let attempedUrl = NSURL(string: "http://www.weather-forecast.com/locations/" + textField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
    
        if let url = attempedUrl {
        
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url){ (data, response, error) -> Void in
            if let urlContent = data {
                
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                
                
                let webArray = webContent?.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                if webArray!.count > 1 {
                    
                    wasSuccessful = true
                    
                    let weatherArray = webArray![1].componentsSeparatedByString("</span>")
                    
                    if weatherArray.count > 1 {
                        
                        let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.resultLabel.text = weatherSummary
                            
                        })
                        
                    }
                    
                }
                if wasSuccessful == false {
                    self.resultLabel.text = "error. try again"
                
                }
                
            }
        }
        
        task.resume()
        
        } else {
            self.resultLabel.text = "error. try again"

        
        }
    }
    
//  my version... fail
        //let city = self.textField.text
//        let urlSearch = NSURL(string: "http://www.weather-forecast.com/locations/" + city!.lowercaseString + textField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
//        
//        if let url = urlSearch {
//        
//        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
//            
//            //will happen upon task completion
//            
//            if let urlContent = data {
//                
//                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
//                
//                print(urlContent)
//                
//                //dispatch the queue make it happen first/cut the line
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    
//                    self.weatherView.loadHTMLString(String(webContent!), baseURL: nil)
//                })
//                
//            } else {
//                
//                print("error")
//                
//                //error message
//                
//            }
//            
//        }
//        task.resume()
//        }
        

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }

}

