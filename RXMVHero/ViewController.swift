//
//  ViewController.swift
//  RXMVHero
//
//  Created by Anak Mirasing on 4/5/16.
//  Copyright © 2016 iGROOMGRiM. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 1011334 is 3-D Man
        MVProvider.request(.GetCharactersByID(id:"1011334")).subscribe { (event) -> Void in
            switch event {
            
            case .Next(let response):
                print(response)
                break
            case .Error(let error):
                print("error : \(error)")
                break
                default:
                break
            }
        }
        
        let timeIn = NSDate().timeIntervalSince1970
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

