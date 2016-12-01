//
//  ViewController.swift
//  Tweet In Swift
//
//  Created by iem on 01/12/2016.
//  Copyright © 2016 iem. All rights reserved.
//

import UIKit
import Social


class ViewController: UIViewController, UIPickerViewDataSource , UIPickerViewDelegate {
    

    @IBOutlet weak var tweetTextView: UITextField!
    
    @IBAction func sendTweet(_ sender: UIButton) {
        var action: String
        var feeling: String
        var tweetFinal = ""
        
        action = self.pickerDataSourceAction[self.pickerView.selectedRow(inComponent: pickerAction)]
        feeling = self.pickerDataSourceFeeling[self.pickerView.selectedRow(inComponent: pickerFeeling)]
        if(SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter)) {
            if let socialController = SLComposeViewController(forServiceType: SLServiceTypeTwitter) {
                if let sentence = self.tweetTextView.text {
                    if sentence != "" {
                        tweetFinal = sentence
                    }else {
                        tweetFinal = "je " + action + " " + feeling
                    }
                }
                socialController.setInitialText(tweetFinal)
                self.present(socialController, animated: true, completion: nil)
            }
        }else {
            let alertController = UIAlertController(title: "Social network", message: "Il n'y à aucun compte tweeter disponible sur le téléphone", preferredStyle: UIAlertControllerStyle.alert)
            let DestructiveAction = UIAlertAction(title: "Je suis un rebel", style: UIAlertActionStyle.default)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            alertController.addAction(DestructiveAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    @IBAction func tapOnBackGround(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    @IBAction func textViewDidEndOnExit(_ sender: UITextField) {
        self.view.endEditing(true)
    }
    @IBOutlet weak var pickerView: UIPickerView!
    
    let pickerDataSourceAction = ["dors","mange", "suis en cours", "galère", "cours", "poireauter"]
    let pickerDataSourceFeeling = [":)",":(", ";)", ":D", "xD", ":|"]
    
    private let pickerAction = 0
    private let pickerFeeling = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var selectedComponentCount = 0;
        if component == pickerAction {
            selectedComponentCount = pickerDataSourceAction.count
        }else {
            selectedComponentCount = pickerDataSourceFeeling.count
        }
        return selectedComponentCount;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == pickerAction {
            return pickerDataSourceAction[row]
        }else {
            return pickerDataSourceFeeling[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
    }
    
}

