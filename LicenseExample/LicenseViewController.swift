//
//  LicenseViewController.swift
//  LicenseExample
//
//  Created by Amir Farsad on 3/29/16.
//  Copyright © 2016 Emersad. All rights reserved.
//

import UIKit

class LicenseViewController: UIViewController {

    @IBOutlet weak var serialNumberField: UITextField!
    @IBAction func buyApp(sender: AnyObject) {
        var url : NSURL
// ─── Set Your URL ────────────────────────────────────────────────────────────────────────
        url = NSURL(string: "SET_BUY_URL_HERE")!
        UIApplication.sharedApplication().openURL(url)
// ─────────────────────────────────────────────────────────────────────────────────────────
    }
    @IBAction func registerApp(sender: AnyObject) {
// ─── if textfield is empty pass and go! ──────────────────────────────────────────────────
        if serialNumberField.text!.isEmpty {
            return
        }
// ─────────────────────────────────────────────────────────────────────────────────────────
        let keychain = KeychainSwift()
        let codeStr = serialNumberField.text
        let query = PFQuery(className:"PARSE_CLASS_NAME")
// ─── parse column name for where codes are stored ────────────────────────────────────────
        query.whereKey("PARSE_COLUMN_NAME", equalTo:codeStr!)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print("Error!")
            }
            if object == nil {
                print("Serial Number Doesnt exist")
            }
            else {
                object?.deleteInBackground()
                print("App Registered Successfuly!")
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
                self.presentViewController(vc, animated: true, completion: nil)
                keychain.set(true, forKey: "isLicensed")
            }
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
