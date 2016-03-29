//
//  CheckLicenseViewController.swift
//  LicenseExample
//
//  Created by Amir Farsad on 3/29/16.
//  Copyright © 2016 Emersad. All rights reserved.
//

import UIKit

class CheckLicenseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//
// ─── Defining Constants ────────────────────────────────────────────────────────────────────────
//
        let keychain = KeychainSwift()
        let amir = keychain.getBool("IsLicensed")
//
// ─── Checking Keychain ────────────────────────────────────────────────────────────────────────
//
        if amir == nil || amir == false {
            print("No License, Going to License View")
            dispatch_async(dispatch_get_main_queue(), {
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("LicenseView") as! LicenseViewController
                self.presentViewController(vc, animated: true, completion: nil)
            })
        }
// ─────────────────────────────────────────────────────────────────────────────────────────────
        else {
            print("License Found, Going to App Main Screen :)")
            dispatch_async(dispatch_get_main_queue(), {
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
                self.presentViewController(vc, animated: true, completion: nil)
            })
        }
    }
// ─────────────────────────────────────────────────────────────────────────────────────────────
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
