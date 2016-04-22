//
//  ViewController.swift
//  RXMVHero
//
//  Created by Anak Mirasing on 4/5/16.
//  Copyright © 2016 iGROOMGRiM. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 1011334 is 3-D Man
        
        /*
        MVProvider.request(.GetCharactersByID(id:"1011334")).subscribe { (event) -> Void in
            switch event {
            
            case .Next(let response):
                print(response)
                break
            case .Error(let error):
                print("error : \(error)")
                break
            
            case .Completed:
                print("Completed")
                break
            }
        }.addDisposableTo(disposeBag)
 
        */
        
        loadCharacterByID("1011999")
        .doOnNext { response in
            print("doOnNext")
            print(response)
        }
        .doOnError({ (error:ErrorType) in
            print("doOnError")
            print(error)
        })
        .subscribe()
        .addDisposableTo(disposeBag)
        
        
        
    }
    
    func loadCharacterByID(cid: String) -> Observable<Response> {
        return MVProvider.request(.GetCharactersByID(id:cid))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

